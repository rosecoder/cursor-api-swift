import Foundation

extension CursorAPI {

  public func getAgent(id: Agent.ID, configuration: Configuration? = nil) async throws
    -> Agent
  {
    try await execute(
      method: .GET,
      path: "/v0/agents/\(id)",
      configuration: configuration
    )
  }
}
