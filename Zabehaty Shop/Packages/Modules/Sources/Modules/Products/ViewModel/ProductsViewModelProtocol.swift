import DomainModels

@MainActor
public protocol ProductsListUseCase {
    var products: [ProductDTO] { get }
    func loadProducts() async
}

@MainActor
public protocol ProductDetailsUseCase {
    var selectedProduct: ProductDTO? { get }
    func loadProduct(by id: Int) async
}

@MainActor
public protocol ProductsViewModelUseCases: ProductDetailsUseCase, ProductsListUseCase {}
