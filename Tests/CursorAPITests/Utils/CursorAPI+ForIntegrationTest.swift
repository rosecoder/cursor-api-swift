import CursorAPI
import Foundation
import Testing

private let apiKey = ProcessInfo.processInfo.environment["CURSOR_API_KEY"]
private let repositoryPath = ProcessInfo.processInfo.environment["CURSOR_REPOSITORY_PATH"]

extension Trait where Self == ConditionTrait {

  public static func enabledIfIntegrationTest(
    sourceLocation: SourceLocation = #_sourceLocation
  ) -> Self {
    enabled(
      if: apiKey != nil,
      sourceLocation: sourceLocation
    )
  }
}

private enum IntegrationTestError: Error {
  case missingAPIKey
}

struct IntegrationTestMetadata {

  let repositoryPath: String
}

func withCursorAPIForIntegrationTest<Result>(
  operation: (CursorAPI, IntegrationTestMetadata) async throws -> Result
) async throws -> Result {
  guard let apiKey, let repositoryPath else {
    throw IntegrationTestError.missingAPIKey
  }

  let cursorAPI = CursorAPI(
    authorization: .apiKey(apiKey)
  )
  let runTask = Task {
    try await cursorAPI.run()
  }
  let result = try await operation(cursorAPI, .init(repositoryPath: repositoryPath))
  runTask.cancel()
  try await runTask.value
  return result
}
