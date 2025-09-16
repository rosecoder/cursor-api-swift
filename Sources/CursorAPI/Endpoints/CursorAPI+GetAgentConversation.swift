import Foundation

extension CursorAPI {

  public func getAgentConversation(id: Agent.ID, configuration: Configuration?) async throws
    -> AgentConversation
  {
    try await execute(
      method: .GET,
      path: "/v0/agents/\(id)/conversation",
      configuration: configuration
    )
  }
}
