extension CursorAPI {

  public func addFollowup(
    id: Agent.ID,
    prompt: Prompt,
    configuration: Configuration? = nil
  ) async throws {
    let _: AddFollowupResult = try await execute(
      method: .POST,
      path: "/v0/agents/\(id)/followup",
      body: .jsonEncoded(
        AddFollowupRequest(prompt: prompt)
      ),
      configuration: configuration
    )
  }
}

private struct AddFollowupRequest: Encodable {

  let prompt: Prompt
}

private struct AddFollowupResult: Sendable {}
extension AddFollowupResult: Decodable {}
