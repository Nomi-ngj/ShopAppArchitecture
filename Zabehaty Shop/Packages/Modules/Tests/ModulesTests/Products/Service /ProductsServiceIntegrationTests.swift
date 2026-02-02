import XCTest
import Moya
import DomainModels
@testable import Modules

@MainActor
final class ProductsServiceIntegrationTests: XCTestCase {

    var sut: ProductsService!

    override func setUp() {
        super.setUp()
        let provider = MoyaProvider<ProductsTarget>() // real network
        sut = ProductsService(provider: provider)
    }

    func testFetchProducts() async throws {
        let products = try await sut.fetchProducts()
        XCTAssertGreaterThan(products.count, 0, "Should fetch at least 1 product")
        XCTAssertNotNil(products.first?.title)
    }

    func testFetchProductById() async throws {
        let product = try await sut.fetchProduct(by: 1)
        XCTAssertEqual(product.id, 1)
        XCTAssertNotNil(product.title)
    }
}
