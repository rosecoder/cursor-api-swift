import CursorAPI
import Testing

@Suite(.enabledIfIntegrationTest()) struct ListAgentTests {

  @Test func shouldReturnAgents() async throws {
    try await withCursorAPIForIntegrationTest { cursorAPI, metadata in
      let result = try await cursorAPI.getAgents()
      print(result)
      #expect(result.agents.count > 0)
    }
  }

  @Test func shouldReturnAgentsForNextPage() async throws {
    try await withCursorAPIForIntegrationTest { cursorAPI, metadata in
      let firstResult = try await cursorAPI.getAgents(limit: 1)
      #expect(!firstResult.agents.isEmpty)
      let nextCursor = try #require(firstResult.nextCursor)

      let secondResult = try await cursorAPI.getAgents(cursor: nextCursor)
      #expect(!secondResult.agents.isEmpty)
      #expect(firstResult.nextCursor != secondResult.nextCursor)
    }
  }
}
