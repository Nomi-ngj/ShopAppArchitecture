import XCTest
import DomainModels
@testable import Modules

@MainActor
final class ModulesProductsListTests: XCTestCase {

    var sut: MockProductsListVM!
    let mockProducts: [ProductDTO] = [
        ProductDTO(id: 1, title: "Mock Product 1", price: 2.0),
        ProductDTO(id: 2, title: "Mock Product 2", price: 2.0)
    ]

    override func setUp() {
        super.setUp()
        sut = MockProductsListVM(products: mockProducts)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: List ViewModel Tests
    func testLoadProducts_withProducts() async {
        await sut.loadProducts()

        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
        XCTAssertEqual(sut.products.count, 2)
        XCTAssertEqual(sut.products.first?.title, "Mock Product 1")
    }

    func testLoadProducts_noProducts() async {
        sut = MockProductsListVM(products: [])

        await sut.loadProducts()

        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.errorMessage, "No products available")
        XCTAssertTrue(sut.products.isEmpty)
    }
}

