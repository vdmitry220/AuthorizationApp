
import UIKit

class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemCyan
    }
    
    func inject(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}
