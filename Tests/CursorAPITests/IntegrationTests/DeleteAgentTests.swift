import CursorAPI
import Testing

@Suite(.enabledIfIntegrationTest()) struct DeleteAgentTests {

  @Test func shouldDeleteAgent() async throws {
    try await withCursorAPIForIntegrationTest { cursorAPI, metadata in
      let agent = try await cursorAPI.createAgent(
        prompt: "This is a test. Just state \"it works\" without anything else.",
        source: .init(repository: metadata.repositoryPath, ref: "main")
      )

      try await cursorAPI.deleteAgent(id: agent.id)
      // should not fail
    }
  }
}
