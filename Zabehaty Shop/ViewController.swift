import UIKit
import Modules

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await ProductsProvider.viewModel.loadProducts()
            await ProductsProvider.viewModel.loadProduct(by: 1)
        }
        // Do any additional setup after loading the view.
    }


}

