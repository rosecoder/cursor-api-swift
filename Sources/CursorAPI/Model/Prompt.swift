public struct Prompt: Sendable {

  public let text: String
  public let images: [Image]

  public init(text: String, images: [Image] = []) {
    assert(!text.isEmpty, "Text must not be empty")
    assert(images.count <= 5, "Images must be less than or equal to 5")

    self.text = text
    self.images = images
  }
}

extension Prompt: Encodable {}

extension Prompt: ExpressibleByStringLiteral {

  public init(stringLiteral value: String) {
    self.init(text: value)
  }
}
