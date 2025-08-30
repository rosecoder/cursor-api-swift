import Foundation

extension CursorAPI {

  public func deleteAgent(
    id: Agent.ID
  ) async throws {
    let _: DeleteAgentResult = try await execute(
      method: .DELETE,
      path: "/v0/agents/\(id)"
    )
  }
}

private struct DeleteAgentResult: Decodable {}
