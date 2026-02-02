import Moya
import NetworkCore
import DomainModels

public protocol ProductsServiceProtocol: Sendable {
    func fetchProducts() async throws -> [ProductDTO]
    func fetchProduct(by id: Int) async throws -> ProductDTO
}

public final class ProductsService:@unchecked Sendable, ProductsServiceProtocol {

    private let provider: MoyaProvider<ProductsTarget>

    public init(provider: MoyaProvider<ProductsTarget>) {
        self.provider = provider
    }

    public func fetchProducts() async throws -> [ProductDTO] {
        let result:ProductsDTO = try await provider.requestAsync(.list, type: ProductsDTO.self)
        return result.products
    }
    
    public func fetchProduct(by id:Int) async throws -> ProductDTO {
        try await provider.requestAsync(.details(id: id), type: ProductDTO.self)
    }
}
