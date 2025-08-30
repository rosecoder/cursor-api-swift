import Foundation

public struct APIKeyInfo: Decodable, Sendable {

  public let apiKeyName: String
  public let createdAt: Date
  public let userEmail: String
}
