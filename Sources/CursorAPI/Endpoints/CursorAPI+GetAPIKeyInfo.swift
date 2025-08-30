extension CursorAPI {

  public func getAPIKeyInfo(configuration: Configuration? = nil) async throws -> APIKeyInfo {
    try await execute(
      method: .GET,
      path: "/v0/me",
      configuration: configuration
    )
  }
}
