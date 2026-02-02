import XCTest
import DomainModels
@testable import Modules

@MainActor
final class ProductsViewModelTests: XCTestCase {

    var sut: ProductsViewModel!
    var mockService: MockProductsService!

    let mockProducts = [
        ProductDTO(id: 1, title: "Mock Product 1", price: 10),
        ProductDTO(id: 2, title: "Mock Product 2", price: 20)
    ]
    let singleProduct = ProductDTO(id: 1, title: "Mock Product 1", price: 10)

    override func setUp() {
        super.setUp()
        mockService = MockProductsService(products: mockProducts, product: singleProduct)
        sut = ProductsViewModel(service: mockService)
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }

    func testLoadProducts_success() async {
        await sut.loadProducts()
        XCTAssertEqual(sut.products.count, 2)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func testLoadProducts_failure() async {
        mockService.shouldFail = true
        await sut.loadProducts()
        XCTAssertEqual(sut.errorMessage, "Mock Error")
        XCTAssertTrue(sut.products.isEmpty)
        XCTAssertFalse(sut.isLoading)
    }

    func testLoadProduct_success() async {
        await sut.loadProduct(by: 1)
        XCTAssertEqual(sut.selectedProduct?.id, 1)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func testLoadProduct_failure() async {
        mockService.shouldFail = true
        await sut.loadProduct(by: 1)
        XCTAssertEqual(sut.errorMessage, "Mock Error")
        XCTAssertNil(sut.selectedProduct)
        XCTAssertFalse(sut.isLoading)
    }

    func testLoadProduct_notFound() async {
        await sut.loadProduct(by: 999)
        XCTAssertEqual(sut.errorMessage, "Product not found")
        XCTAssertNil(sut.selectedProduct)
    }
}
