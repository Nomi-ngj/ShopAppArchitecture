import Foundation
import DomainModels
import Modules

// MARK: - List ViewModel Mock
@MainActor
public final class MockProductsListVM: ProductsListUseCase {

    public private(set) var products: [ProductDTO] = []
    public private(set) var isLoading: Bool = false
    public private(set) var errorMessage: String?

    public init(products: [ProductDTO] = []) {
        self.products = products
    }

    public func loadProducts() async {
        isLoading = true
        errorMessage = nil
        try? await Task.sleep(nanoseconds: 100_000_000) // simulate delay

        if products.isEmpty == true {
            errorMessage = "No products available"
        }
        isLoading = false
    }
}
