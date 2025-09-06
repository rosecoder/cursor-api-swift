import AsyncHTTPClient
import Foundation
import NIO
import NIOFoundationCompat
import NIOHTTP1
import NIOSSL
import ServiceLifecycle
import Tracing

public final class CursorAPI: Sendable, Service {

  private let httpClient = HTTPClient()
  private let configuration: Configuration

  private let jsonEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
  }()
  private let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }()

  public init() {
    self.configuration = .init(authorization: nil)
  }

  public init(authorization: Configuration.Authorization) {
    self.configuration = Configuration(authorization: authorization)
  }

  public init(configuration: Configuration) {
    self.configuration = configuration
  }

  public func run() async throws {
    await cancelWhenGracefulShutdown {
      while !Task.isCancelled {
        try? await Task.sleep(nanoseconds: .max / 2)
      }
    }

    try await httpClient.shutdown()
  }

  enum Body {
    case none
    case jsonEncoded(any Encodable)
  }

  func execute<ReturnElement: Decodable>(
    method: HTTPMethod,
    path: String,
    queryItems: [URLQueryItem] = [],
    body: Body = .none,
    configuration: Configuration?
  ) async throws -> ReturnElement {
    let configuration = configuration ?? self.configuration
    return try await withSpan(
      "cursor-" + path,
      ofKind: .client
    ) { span in
      span.attributes["/http/url"] = configuration.endpoint + path
      span.attributes["/http/method"] = method.rawValue

      let response = try await request(
        method: method,
        path: path,
        queryItems: queryItems,
        body: body,
        configuration: configuration
      )
      span.attributes["/http/status_code"] = String(response.status.code)

      return try await decode(response: response)
    }
  }

  private func request(
    method: HTTPMethod,
    path: String,
    queryItems: [URLQueryItem],
    body: Body,
    configuration: Configuration
  ) async throws -> HTTPClientResponse {
    var urlComponents = URLComponents(string: configuration.endpoint + path)!
    urlComponents.queryItems = queryItems

    var request = HTTPClientRequest(url: urlComponents.string!)
    request.method = method

    if case .apiKey(let token) = configuration.authorization {
      request.headers.add(name: "Authorization", value: "Bearer " + token)
    }

    switch body {
    case .none:
      break
    case .jsonEncoded(let data):
      request.headers.add(name: "Content-Type", value: "application/json")
      request.body = .bytes(try jsonEncoder.encode(data))
    }

    return try await httpClient.execute(request, timeout: configuration.timeout)
  }

  struct ResponseStatusError: Error, CustomStringConvertible {

    let statusCode: UInt

    var description: String {
      "Cursor API response status code \(statusCode)"
    }
  }

  struct ResponseDecodingError: Error {

    let error: Error
    let body: String
  }

  func decode<Element: Decodable>(
    response: HTTPClientResponse
  ) async throws -> Element {
    guard !(500..<600).contains(response.status.code) else {
      throw ResponseStatusError(statusCode: response.status.code)
    }

    let body = try await response.body.collect(upTo: 1024 * 1024)  // 1 MB

    if response.status.code < 300 {
      do {
        return try jsonDecoder.decode(Element.self, from: body)
      } catch {
        throw ResponseDecodingError(error: error, body: String(buffer: body))
      }
    }

    if let remoteError = try? jsonDecoder.decode(RemoteError.self, from: body) {
      throw remoteError
    }
    throw UnregonizedError(status: response.status, description: String(buffer: body))
  }

  struct UnregonizedError: Error {

    let status: HTTPResponseStatus
    let description: String
  }

  public struct RemoteError: Decodable, Error, CustomStringConvertible {

    public let message: String
    public let details: [Detail]

    enum CodingKeys: String, CodingKey {
      case error
      case details
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.message = try container.decode(String.self, forKey: .error)
      self.details = try container.decodeIfPresent([Detail].self, forKey: .details) ?? []
    }

    public struct Detail: Decodable, Sendable, CustomStringConvertible {

      public let message: String
      public let code: String
      public let path: [String]?

      public var description: String {
        var result = "\(code): \(message)"
        if let path {
          result += " (at \(path.joined(separator: ".")))"
        }
        return result
      }
    }

    // MARK: - CustomStringConvertible

    public var description: String {
      "\(message): \(details.map { $0.description }.joined(separator: ", "))"
    }
  }
}
