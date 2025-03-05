import UIKit

class UserProfileViewController: UIViewController {
    var presenter: UserProfilePresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}
