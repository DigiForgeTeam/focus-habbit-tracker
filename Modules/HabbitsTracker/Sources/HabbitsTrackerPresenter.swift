protocol HabbitsTrackerPresenterProtocol {
    func viewDidLoad()
}

class HabbitsTrackerPresenter: HabbitsTrackerPresenterProtocol {
    weak var view: HabbitsTrackerViewController?
    
    func viewDidLoad() {
        
    }
}
