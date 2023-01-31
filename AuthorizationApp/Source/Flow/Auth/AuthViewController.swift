
import UIKit

class AuthViewController: UIViewController {
    
    private var viewModel: AuthViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
    
    func inject(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }
}

