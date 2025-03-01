import UIKit

class HabbitsTrackerViewController: UIViewController {
    var presenter: HabbitsTrackerPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}
