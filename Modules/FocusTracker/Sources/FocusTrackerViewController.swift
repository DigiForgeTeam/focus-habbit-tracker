import UIKit

class FocusTrackerViewController: UIViewController {
    var presenter: FocusTrackerPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}
