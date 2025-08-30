import NIOCore

public struct Configuration: Sendable {

  public let authorization: Authorization?
  public let endpoint: String
  public let timeout: TimeAmount

  public init(
    authorization: Authorization?,
    endpoint: String = "https://api.cursor.com",
    timeout: TimeAmount = .seconds(30)
  ) {
    self.authorization = authorization
    self.endpoint = endpoint
    self.timeout = timeout
  }
}
