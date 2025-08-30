import Foundation

extension CursorAPI {

  public func getAgents(
    limit: UInt = 20,
    cursor: PaginationCursor? = nil,
    configuration: Configuration? = nil
  ) async throws
    -> GetAgentsResult
  {
    try await execute(
      method: .GET,
      path: "/v0/agents",
      queryItems: [
        URLQueryItem(name: "limit", value: String(limit)),
        cursor.flatMap { URLQueryItem(name: "cursor", value: $0.rawValue) },
      ]
      .compactMap { $0 },
      configuration: configuration
    )
  }
}

extension CursorAPI {

  public struct GetAgentsResult: Sendable {

    public let agents: [Agent]
    public let nextCursor: PaginationCursor?
  }
}
extension CursorAPI.GetAgentsResult: Decodable {}
extension CursorAPI.GetAgentsResult: CustomDebugStringConvertible {

  public var debugDescription: String {
    if agents.isEmpty {
      return "ListAgentsResult(nextCursor: \(nextCursor?.rawValue ?? "nil"), agents: [])"
    }
    return """
      ListAgentsResult(nextCursor: \(nextCursor?.rawValue ?? "nil"), agents: [
        \(agents.map { $0.debugDescription.replacingOccurrences(of: "\n", with: "\n  ") }.joined(separator: "\n  "))
      ])
      """
  }
}
