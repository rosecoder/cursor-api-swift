public protocol CursorAPIProtocol: Sendable {

    func addFollowup(
        id: Agent.ID,
        prompt: Prompt,
        configuration: Configuration?
    ) async throws

    func createAgent(
        prompt: Prompt,
        source: Agent.Source,
        model: Model?,
        target: CreateAgentTarget?,
        webhook: Webhook?,
        configuration: Configuration?
    ) async throws -> Agent

    func deleteAgent(
        id: Agent.ID,
        configuration: Configuration?
    ) async throws

    func getAgent(
        id: Agent.ID,
        configuration: Configuration?
    ) async throws -> Agent

    func getAgentConversation(
        id: Agent.ID,
        configuration: Configuration?
    ) async throws -> AgentConversation

    func getAgents(
        limit: UInt,
        cursor: PaginationCursor?,
        configuration: Configuration?
    ) async throws -> CursorAPI.GetAgentsResult

    func getAPIKeyInfo(
        configuration: Configuration?
    ) async throws -> APIKeyInfo

    func getModels(
        configuration: Configuration?
    ) async throws -> [Model]

    func getRepositories(
        configuration: Configuration?
    ) async throws -> [Repository]
}

extension CursorAPIProtocol {

    public func addFollowup(
        id: Agent.ID,
        prompt: Prompt
    ) async throws {
        try await addFollowup(
            id: id,
            prompt: prompt,
            configuration: nil
        )
    }

    public func createAgent(
        prompt: Prompt,
        source: Agent.Source,
        model: Model? = nil,
        target: CreateAgentTarget? = nil,
        webhook: Webhook? = nil
    ) async throws -> Agent {
        try await createAgent(
            prompt: prompt,
            source: source,
            model: model,
            target: target,
            webhook: webhook,
            configuration: nil
        )
    }

    public func deleteAgent(
        id: Agent.ID
    ) async throws {
        try await deleteAgent(
            id: id,
            configuration: nil
        )
    }

    public func getAgent(
        id: Agent.ID
    ) async throws -> Agent {
        try await getAgent(
            id: id,
            configuration: nil
        )
    }

    public func getAgentConversation(
        id: Agent.ID
    ) async throws -> AgentConversation {
        try await getAgentConversation(
            id: id,
            configuration: nil
        )
    }

    public func getAgents(
        limit: UInt = 20,
        cursor: PaginationCursor? = nil
    ) async throws -> CursorAPI.GetAgentsResult {
        try await getAgents(
            limit: limit,
            cursor: cursor,
            configuration: nil
        )
    }

    public func getAPIKeyInfo() async throws -> APIKeyInfo {
        try await getAPIKeyInfo(configuration: nil)
    }

    public func getModels() async throws -> [Model] {
        try await getModels(configuration: nil)
    }

    public func getRepositories() async throws -> [Repository] {
        try await getRepositories(configuration: nil)
    }
}
