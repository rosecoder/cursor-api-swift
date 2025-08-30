import CursorAPI
import Testing

@Suite(.enabledIfIntegrationTest()) struct CreateAgentTests {

  @Test func shouldCreateAgent() async throws {
    try await withCursorAPIForIntegrationTest { cursorAPI, metadata in
      let agent = try await cursorAPI.createAgent(
        prompt: "This is a test. Just state \"it works\" without anything else.",
        source: .init(repository: metadata.repositoryPath, ref: "main")
      )
      print(agent)
      #expect(!agent.id.rawValue.isEmpty)
    }
  }
}
