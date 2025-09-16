import CursorAPI

public struct NoOpCursorAPI: CursorAPIProtocol {

  public init() {}

  private enum NoOpError: Error {
    case notImplemented
  }

  public func addFollowup(
    id: Agent.ID,
    prompt: Prompt,
    configuration: Configuration?
  ) async throws {
    // No-op
  }

  public func createAgent(
    prompt: Prompt,
    source: Agent.Source,
    model: Model?,
    target: CreateAgentTarget?,
    webhook: Webhook?,
    configuration: Configuration?
  ) async throws -> Agent {
    throw NoOpError.notImplemented
  }

  public func deleteAgent(
    id: Agent.ID,
    configuration: Configuration?
  ) async throws {
    // No-op
  }

  public func getAgent(
    id: Agent.ID,
    configuration: Configuration?
  ) async throws -> Agent {
    throw NoOpError.notImplemented
  }

  public func getAgentConversation(
    id: Agent.ID,
    configuration: Configuration?
  ) async throws -> AgentConversation {
    throw NoOpError.notImplemented
  }

  public func getAgents(
    limit: UInt,
    cursor: PaginationCursor?,
    configuration: Configuration?
  ) async throws -> CursorAPI.GetAgentsResult {
    throw NoOpError.notImplemented
  }

  public func getAPIKeyInfo(
    configuration: Configuration?
  ) async throws -> APIKeyInfo {
    throw NoOpError.notImplemented
  }

  public func getModels(
    configuration: Configuration?
  ) async throws -> [Model] {
    return []
  }

  public func getRepositories(
    configuration: Configuration?
  ) async throws -> [Repository] {
    return []
  }
}
