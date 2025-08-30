#if canImport(Foundation)
  import Foundation
#endif

extension Prompt {

  public struct Image: Sendable {

    public let data: String
    public let dimension: Dimension

    public init(data: String, dimension: Dimension) {
      self.data = data
      self.dimension = dimension
    }
  }
}
extension Prompt.Image: Encodable {}

#if canImport(Foundation)
  extension Prompt.Image {

    public init(data: Data, dimension: Dimension) {
      self.data = data.base64EncodedString()
      self.dimension = dimension
    }
  }
#endif

extension Prompt.Image {

  public struct Dimension: Sendable {

    public let width: UInt
    public let height: UInt
  }
}
extension Prompt.Image.Dimension: Encodable {}
