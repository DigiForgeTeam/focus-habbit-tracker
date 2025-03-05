protocol WelcomeModulePresenterProtocol {
    func viewDidLoad()
}

class WelcomeModulePresenter: WelcomeModulePresenterProtocol {
    weak var view: WelcomeModuleViewController?
    func viewDidLoad() {
    }
}
