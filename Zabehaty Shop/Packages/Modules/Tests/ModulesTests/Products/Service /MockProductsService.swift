import Foundation
import DomainModels
import Modules
import Moya

@MainActor
public final class MockProductsService: ProductsServiceProtocol {

    public var mockProducts: [ProductDTO]
    public var mockProduct: ProductDTO?
    public var shouldFail: Bool = false
    public var error: Error = NSError(domain: "Mock", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock Error"])

    public init(products: [ProductDTO] = [], product: ProductDTO? = nil) {
        self.mockProducts = products
        self.mockProduct = product
    }

    public func fetchProducts() async throws -> [ProductDTO] {
        if shouldFail { throw error }
        return mockProducts
    }

    public func fetchProduct(by id: Int) async throws -> ProductDTO {
        if shouldFail { throw error }
        guard let p = mockProduct, p.id == id else {
            throw NSError(domain: "Mock", code: 404, userInfo: [NSLocalizedDescriptionKey: "Product not found"])
        }
        return p
    }
}
