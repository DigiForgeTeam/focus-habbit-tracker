protocol UserProfilePresenterProtocol {
    func viewDidLoad()
}

class UserProfilePresenter: UserProfilePresenterProtocol {
    weak var view: UserProfileViewController?

    func viewDidLoad() {

    }
}
