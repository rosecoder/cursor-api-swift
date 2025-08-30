public struct Model: Sendable {

  public let rawValue: String

  public init(rawValue: String) {
    assert(!rawValue.isEmpty, "Model must not be empty")

    self.rawValue = rawValue
  }
}

extension Model: Encodable {

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}

extension Model: ExpressibleByStringLiteral {

  public init(stringLiteral value: String) {
    self.init(rawValue: value)
  }
}
