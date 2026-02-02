import Foundation
import DomainModels

@MainActor
public final class ProductsViewModel:
    ProductsViewModelUseCases  {

    // MARK: - Published properties
    public private(set) var products: [ProductDTO] = []
    public private(set) var selectedProduct: ProductDTO?
    public var isLoading: Bool = false
    public var errorMessage: String?

    // MARK: - Dependencies
    private let service: ProductsServiceProtocol

    public init(service: ProductsServiceProtocol) {
        self.service = service
    }

    // MARK: - List of Products
    public func loadProducts() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }

        do {
            let result = try await service.fetchProducts()

            await MainActor.run {
                debugPrint(result)
                didLoadList(result)
                isLoading = false
            }

        } catch {
            await MainActor.run {
                debugPrint(error)
                didFailList(error)
                isLoading = false
            }
        }
    }


    public func didLoadList(_ output: [ProductDTO]) {
        self.products = output
    }

    public func didFailList(_ error: Error) {
        self.errorMessage = error.localizedDescription
    }

    // MARK: - Single Product
    public func loadProduct(by id: Int) async {
        isLoading = true
        errorMessage = nil
        do {
            let product = try await service.fetchProduct(by: id)
            debugPrint(product)
            didLoadItem(product)
        } catch {
            debugPrint(error)
            didFailItem(error)
        }
        isLoading = false
    }

    public func didLoadItem(_ output: ProductDTO) {
        self.selectedProduct = output
    }

    public func didFailItem(_ error: Error) {
        self.errorMessage = error.localizedDescription
    }
}
