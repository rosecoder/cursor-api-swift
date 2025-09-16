extension CursorAPI {

  public func getModels(configuration: Configuration?) async throws -> [Model] {
    let result: GetModelsResult = try await execute(
      method: .GET,
      path: "/v0/models",
      configuration: configuration
    )
    return result.models
  }
}

public struct GetModelsResult: Sendable {

  public let models: [Model]
}
extension GetModelsResult: Decodable {}
