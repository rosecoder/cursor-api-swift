import Foundation

public struct Agent: Sendable {

  public let id: ID
  public let name: String
  public let status: Status
  public let source: Source
  public let target: Target
  public let summary: String?
  public let createdAt: Date
}

extension Agent: Decodable {}
extension Agent: Identifiable {}
extension Agent: CustomDebugStringConvertible {

  public var debugDescription: String {
    """
    Agent(
      id: \(id.debugDescription),
      name: \"\(name)\",
      status: \(status),
      source: \(source.debugDescription),
      target: \(target.debugDescription),
      summary: \(summary.flatMap { "\"\($0)\"" } ?? "nil"),
      createdAt: \(createdAt)
    )
    """
  }
}

extension Agent {

  public struct ID: Sendable {

    public let rawValue: String

    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }
}
extension Agent.ID: Hashable {}
extension Agent.ID: Equatable {}
extension Agent.ID: CustomStringConvertible {

  public var description: String {
    rawValue
  }
}
extension Agent.ID: CustomDebugStringConvertible {

  public var debugDescription: String {
    "\"" + description + "\""
  }
}
extension Agent.ID: Decodable {

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.rawValue = try container.decode(String.self)
  }
}

extension Agent {

  public enum Status: String, Sendable {
    case running = "RUNNING"
    case finished = "FINISHED"
    case error = "ERROR"
    case creating = "CREATING"
    case expired = "EXPIRED"
  }
}
extension Agent.Status: Decodable {}
extension Agent.Status: Hashable {}
extension Agent.Status: Equatable {}
extension Agent.Status: CustomDebugStringConvertible {

  public var debugDescription: String {
    "." + rawValue.lowercased()
  }
}

extension Agent {

  public struct Source: Sendable {

    public let repository: String
    public let ref: String

    public init(repository: String, ref: String) {
      assert(!repository.isEmpty, "Repository must not be empty")
      assert(!ref.isEmpty, "Ref must not be empty")

      self.repository = repository
      self.ref = ref
    }
  }
}
extension Agent.Source: Codable {}
extension Agent.Source: Hashable {}
extension Agent.Source: Equatable {}
extension Agent.Source: CustomDebugStringConvertible {

  public var debugDescription: String {
    """
    Source(repository: \"\(repository)\", ref: \"\(ref)\")
    """
  }
}

extension Agent {

  public struct Target: Sendable {

    public let branchName: String?
    public let cursorWebURL: String
    public let pullRequestURL: String?
    public let autoCreatePullRequest: Bool?
  }
}
extension Agent.Target: Decodable {

  enum CodingKeys: String, CodingKey {
    case branchName = "branchName"
    case cursorWebURL = "url"
    case pullRequestURL = "prUrl"
    case autoCreatePullRequest = "autoCreatePr"
  }
}
extension Agent.Target: Hashable {}
extension Agent.Target: Equatable {}
extension Agent.Target: CustomDebugStringConvertible {

  public var debugDescription: String {
    """
    Target(branchName: \(branchName.flatMap { "\"\($0)\"" } ?? "nil"), cursorWebURL: \"\(cursorWebURL)\", pullRequestURL: \(pullRequestURL.flatMap { "\"\($0)\"" } ?? "nil"), autoCreatePullRequest: \(autoCreatePullRequest.flatMap { "\($0)" } ?? "nil"))
    """
  }
}
