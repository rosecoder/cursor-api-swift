import CursorAPI
import Testing

@Suite(.enabledIfIntegrationTest()) struct ListRepositoriesTests {

  @Test func shouldReturnRepositories() async throws {
    try await withCursorAPIForIntegrationTest { cursorAPI, _ in
      let repositories = try await cursorAPI.getRepositories()
      print(repositories)
      #expect(!repositories.isEmpty)
    }
  }
}
