import Foundation

public struct ProductDTO: Codable, Sendable {
    public let id: Int
    public let title: String
    public let price: Double
    public init(id: Int, title: String, price: Double) {
        self.id = id
        self.title = title
        self.price = price
    }
}


