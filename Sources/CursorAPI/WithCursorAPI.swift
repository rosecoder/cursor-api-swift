public func withCursorAPI<Result>(
  configuration: Configuration,
  operation: (CursorAPI) async throws -> Result
) async throws -> Result {
  let cursorAPI = CursorAPI(configuration: configuration)
  let runTask = Task {
    try await cursorAPI.run()
  }
  let result = try await operation(cursorAPI)
  runTask.cancel()
  try await runTask.value
  return result
}

public func withCursorAPI<Result>(
  authorization: Configuration.Authorization,
  operation: (CursorAPI) async throws -> Result
) async throws -> Result {
  let cursorAPI = CursorAPI(authorization: authorization)
  let runTask = Task {
    try await cursorAPI.run()
  }
  let result = try await operation(cursorAPI)
  runTask.cancel()
  try await runTask.value
  return result
}

public func withCursorAPI<Result>(
  operation: (CursorAPI) async throws -> Result
) async throws -> Result {
  let cursorAPI = CursorAPI()
  let runTask = Task {
    try await cursorAPI.run()
  }
  let result = try await operation(cursorAPI)
  runTask.cancel()
  try await runTask.value
  return result
}
