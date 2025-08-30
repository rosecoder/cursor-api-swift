public struct Webhook: Sendable {

  public let url: String
  public let secret: String

  public init(url: String, secret: String) {
    assert(!url.isEmpty, "URL must not be empty")
    assert(url.count <= 2048, "URL must not exceed 2048 characters")
    assert(
      secret.count >= 32 && secret.count <= 256,
      "Secret must be between 32 and 256 characters"
    )

    self.url = url
    self.secret = secret
  }
}

extension Webhook: Encodable {}
