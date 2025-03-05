protocol FocusTrackerPresenterProtocol {
    func viewDidLoad()
}

class FocusTrackerPresenter: FocusTrackerPresenterProtocol {
    weak var view: FocusTrackerViewController?

    func viewDidLoad() {

    }
}
