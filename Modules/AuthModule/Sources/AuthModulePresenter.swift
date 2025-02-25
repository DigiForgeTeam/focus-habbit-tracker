protocol AuthModulePresenterProtocol {
    func viewDidLoad()
}

class AuthModulePresenter: AuthModulePresenterProtocol {
    weak var view: AuthModuleViewController?
    
    func viewDidLoad() {
        
    }
}
