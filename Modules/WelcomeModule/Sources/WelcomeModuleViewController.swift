import UIKit

class WelcomeModuleViewController: UIViewController {
    var presenter: WelcomeModulePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}
