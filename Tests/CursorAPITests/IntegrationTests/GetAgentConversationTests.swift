import CursorAPI
import Testing

@Suite(.enabledIfIntegrationTest()) struct GetAgentConversationTests {

  @Test func shouldReturnAgentConversation() async throws {
    try await withCursorAPIForIntegrationTest { cursorAPI, _ in
      let result = try await cursorAPI.getAgents()
      let agent = try #require(result.agents.first)

      let conversation = try await cursorAPI.getAgentConversation(id: agent.id)
      print(conversation)
      #expect(conversation.id == agent.id)
    }
  }
}
