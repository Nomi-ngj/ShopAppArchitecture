import XCTest
import DomainModels
@testable import Modules

// MARK: - Details ViewModel Tests
@MainActor
final class ModulesProductDetailsTests: XCTestCase {

    var sut: MockProductDetailsVM!
    let mockProduct = ProductDTO(id: 1, title: "Mock Product 1", price: 2.0)

    override func setUp() {
        super.setUp()
        sut = MockProductDetailsVM(product: mockProduct)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLoadProduct_found() async {
        await sut.loadProduct(by: 1)

        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
        XCTAssertEqual(sut.selectedProduct?.id, 1)
        XCTAssertEqual(sut.selectedProduct?.title, "Mock Product 1")
    }

    func testLoadProduct_notFound() async {
        await sut.loadProduct(by: 2)

        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.errorMessage, "Product with ID 2 not found")
        XCTAssertNil(sut.selectedProduct)
    }
}
