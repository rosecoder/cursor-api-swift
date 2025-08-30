import Foundation

extension CursorAPI {

  public func createAgent(
    prompt: Prompt,
    source: Agent.Source,
    model: Model? = nil,
    target: CreateAgentTarget? = nil,
    webhook: Webhook? = nil,
    configuration: Configuration? = nil
  ) async throws
    -> Agent
  {
    try await execute(
      method: .POST,
      path: "/v0/agents",
      body: .jsonEncoded(
        CreateAgentRequest(
          prompt: prompt,
          source: source,
          model: model,
          target: target,
          webhook: webhook
        )
      ),
      configuration: configuration
    )
  }
}

private struct CreateAgentRequest: Encodable {

  let prompt: Prompt
  let source: Agent.Source
  let model: Model?
  let target: CreateAgentTarget?
  let webhook: Webhook?
}

public struct CreateAgentTarget: Sendable {

  public var branchName: String?
  public var autoCreatePullRequest: Bool?

  public init(branchName: String?, autoCreatePullRequest: Bool?) {
    self.branchName = branchName
    self.autoCreatePullRequest = autoCreatePullRequest
  }
}

extension CreateAgentTarget: Encodable {

  enum CodingKeys: String, CodingKey {
    case branchName = "branchName"
    case autoCreatePullRequest = "autoCreatePr"
  }
}
