import Foundation

public struct AgentConversation: Sendable {

  public let id: Agent.ID
  public let messages: [Message]
}

extension AgentConversation: Decodable {}
extension AgentConversation: CustomDebugStringConvertible {

  public var debugDescription: String {
    if messages.isEmpty {
      return "AgentConversation(id: \(id.debugDescription), messages: [])"
    }
    return """
      AgentConversation(id: \(id.debugDescription), messages: [
        \(messages.map { $0.debugDescription.replacingOccurrences(of: "\n", with: "\n  ") }.joined(separator: "\n  "))
      ])
      """
  }
}

extension AgentConversation {

  public struct Message: Sendable {

    public let id: String
    public let kind: Kind
    public let text: String

    public enum Kind: String, Sendable, Decodable {
      case userMessage = "user_message"
      case assistantMessage = "assistant_message"
    }
  }
}
extension AgentConversation.Message: Decodable {

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case kind = "type"
    case text = "text"
  }
}
extension AgentConversation.Message: CustomDebugStringConvertible {

  public var debugDescription: String {
    "Message(id: \"\(id)\", kind: \"\(kind.rawValue)\", text: \"\(text)\")"
  }
}
