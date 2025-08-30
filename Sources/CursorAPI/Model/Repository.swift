public struct Repository: Sendable {

  public let owner: String
  public let name: String
  public let repository: String
}

extension Repository: Decodable {}
extension Repository: Hashable {}
extension Repository: Equatable {}
