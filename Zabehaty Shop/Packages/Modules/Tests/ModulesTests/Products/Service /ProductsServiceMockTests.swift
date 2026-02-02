import XCTest
import Moya
import DomainModels
@testable import Modules

final class ProductsServiceMockTests: XCTestCase {

    var sut: ProductsService!

    override func setUp() {
        super.setUp()
        
        // 1️⃣ Custom endpoint closure
        let endpointClosure: (ProductsTarget) -> Endpoint = { target in
            switch target {
            case .list:
                let data = """
                {
                  "products": 
                [
                    {"id":1,"title":"Mock Product 1","price":10.0},
                    {"id":2,"title":"Mock Product 2","price":20.0}
                ]
                }
                """.data(using: .utf8)!
                return Endpoint(
                    url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                    sampleResponseClosure: { .networkResponse(200, data) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            case .details(let id):
                let data = """
                {"id":\(id),"title":"Mock Product \(id)","price":10.0}
                """.data(using: .utf8)!
                return Endpoint(
                    url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                    sampleResponseClosure: { .networkResponse(200, data) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            }
        }

        // 2️⃣ Use stubClosure to immediately return stub responses
        let stubClosure: (ProductsTarget) -> Moya.StubBehavior = { _ in .immediate }

        // 3️⃣ Create provider
        let provider = MoyaProvider<ProductsTarget>(
            endpointClosure: endpointClosure,
            stubClosure: stubClosure
        )

        sut = ProductsService(provider: provider)
    }

    func testFetchProducts_withMock() async throws {
        let products = try await sut.fetchProducts()
        XCTAssertEqual(products.count, 2)
        XCTAssertEqual(products.first?.title, "Mock Product 1")
    }

    func testFetchProductById_withMock() async throws {
        let product = try await sut.fetchProduct(by: 1)
        XCTAssertEqual(product.id, 1)
        XCTAssertEqual(product.title, "Mock Product 1")
    }
}
