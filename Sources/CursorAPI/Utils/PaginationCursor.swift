public struct PaginationCursor: Sendable {

  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }
}

extension PaginationCursor: Hashable {}
extension PaginationCursor: Equatable {}

extension PaginationCursor: ExpressibleByStringLiteral {

  public init(stringLiteral value: String) {
    self.init(rawValue: value)
  }
}

extension PaginationCursor: Decodable {

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.rawValue = try container.decode(String.self)
  }
}
