import Foundation
import DomainModels
import Modules

// MARK: - Details ViewModel Mock
@MainActor
public final class MockProductDetailsVM: ProductDetailsUseCase {

    public private(set) var selectedProduct: ProductDTO?
    public private(set) var isLoading: Bool = false
    public private(set) var errorMessage: String?

    private let product: ProductDTO?

    public init(product: ProductDTO? = nil) {
        self.product = product
    }

    public func loadProduct(by id: Int) async {
        isLoading = true
        errorMessage = nil
        try? await Task.sleep(nanoseconds: 100_000_000)

        if let p = product, p.id == id {
            selectedProduct = p
        } else {
            errorMessage = "Product with ID \(id) not found"
        }

        isLoading = false
    }
}
