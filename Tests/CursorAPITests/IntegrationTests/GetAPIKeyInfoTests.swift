import CursorAPI
import Testing

@Suite(.enabledIfIntegrationTest()) struct GetAPIKeyInfoTests {

  @Test func shouldReturnAPIKeyInfo() async throws {
    try await withCursorAPIForIntegrationTest { cursorAPI, _ in
      let info = try await cursorAPI.getAPIKeyInfo()
      print(info)
      #expect(!info.apiKeyName.isEmpty)
      #expect(!info.userEmail.isEmpty)
    }
  }
}
