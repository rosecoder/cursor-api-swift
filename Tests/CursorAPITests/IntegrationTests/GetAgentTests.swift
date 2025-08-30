import CursorAPI
import Testing

@Suite(.enabledIfIntegrationTest()) struct GetAgentTests {

  @Test func shouldReturnAgent() async throws {
    try await withCursorAPIForIntegrationTest { cursorAPI, metadata in
      let result = try await cursorAPI.getAgents()
      let agent = try #require(result.agents.first)
      print(agent)

      let agentResult = try await cursorAPI.getAgent(id: agent.id)
      #expect(agentResult.id == agent.id)
    }
  }
}
