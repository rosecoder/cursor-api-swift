import Foundation
import Testing

@testable import CursorAPI

@Suite struct ISO8601DateDecodingTests {

  let decoder = CursorAPI.jsonDecoder

  private struct Wrapper: Decodable { let createdAt: Date }

  @Test func decodesISO8601WithoutFractionalSeconds() throws {
    let json = """
      {"createdAt":"2025-09-10T16:24:55Z"}
      """.data(using: .utf8)!

    let decoded = try decoder.decode(Wrapper.self, from: json)
    #expect(Int(decoded.createdAt.timeIntervalSince1970) == 1_757_521_495)
  }

  @Test func decodesISO8601WithFractionalSeconds() throws {
    let json = """
      {"createdAt":"2025-09-10T16:24:55.924Z"}
      """.data(using: .utf8)!

    let decoded = try decoder.decode(Wrapper.self, from: json)
    // Accepts fractional seconds; base seconds should match whole-second floor
    #expect(Int(decoded.createdAt.timeIntervalSince1970) == 1_757_521_495)
  }
}
