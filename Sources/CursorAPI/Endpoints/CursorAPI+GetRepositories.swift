extension CursorAPI {

  public func getRepositories(configuration: Configuration?) async throws -> [Repository] {
    let result: GetRepositoriesResult = try await execute(
      method: .GET,
      path: "/v0/repositories",
      configuration: configuration
    )
    return result.repositories
  }
}

public struct GetRepositoriesResult: Sendable {

  public let repositories: [Repository]
}
extension GetRepositoriesResult: Decodable {}
