import CursorAPI
import Testing

@Suite(.enabledIfIntegrationTest()) struct AddFollowupTests {

  @Test func shouldAddFollowup() async throws {
    try await withCursorAPIForIntegrationTest { cursorAPI, metadata in
      let agent = try await cursorAPI.createAgent(
        prompt: "This is a test. Just state \"it works\" without anything else.",
        source: .init(repository: metadata.repositoryPath, ref: "main")
      )

      try await cursorAPI.addFollowup(
        id: agent.id,
        prompt: .init(text: "Now just that \"it still works\"")
      )
      // should not fail
    }
  }
}
