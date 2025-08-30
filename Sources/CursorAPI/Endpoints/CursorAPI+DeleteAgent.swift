import Foundation

extension CursorAPI {

  public func deleteAgent(
    id: Agent.ID,
    configuration: Configuration? = nil
  ) async throws {
    let _: DeleteAgentResult = try await execute(
      method: .DELETE,
      path: "/v0/agents/\(id)",
      configuration: configuration
    )
  }
}

private struct DeleteAgentResult: Decodable {}
