import CursorAPI
import Testing

@Suite(.enabledIfIntegrationTest()) struct ListModelsTests {

  @Test func shouldReturnModels() async throws {
    try await withCursorAPIForIntegrationTest { cursorAPI, _ in
      let models = try await cursorAPI.getModels()
      print(models)
      #expect(!models.isEmpty)
    }
  }
}
