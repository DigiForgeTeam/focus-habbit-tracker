import UIKit

class AuthModuleViewController: UIViewController {
    var presenter: AuthModulePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}
