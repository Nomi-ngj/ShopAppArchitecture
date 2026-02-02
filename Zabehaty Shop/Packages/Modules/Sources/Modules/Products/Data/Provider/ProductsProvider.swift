import Foundation
import NetworkCore

@MainActor
public final class ProductsProvider {

    // Provide singleton service instance
    public static let service: ProductsService =
        ProductsService(provider: ProviderFactory.make(for: ProductsTarget.self))
    
    // Provide a singleton view model instance conforming to ProductsViewModelUseCases
    public static let viewModel: any ProductsViewModelUseCases = ProductsViewModel(service: service)
}
