import Foundation

extension CursorAPI {

  public func getAgent(id: Agent.ID) async throws
    -> Agent
  {
    try await execute(
      method: .GET,
      path: "/v0/agents/\(id)"
    )
  }
}
