import Foundation

public struct ProductsDTO: Decodable, Sendable {
    
    public let products: [ProductDTO]
    
    public init(products: [ProductDTO]) {
        self.products = products
    }
}
