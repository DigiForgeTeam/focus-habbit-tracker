import UIKit

public class AuthModuleViewController: UIViewController {
    var presenter: AuthModulePresenterProtocol!

    public override func viewDidLoad() {
        super.viewDidLoad()
//        presenter.viewDidLoad()
        let title = UILabel()
        view.addSubview(title)
        title.frame = view.bounds
        title.textAlignment = .center
        title.text = "Отряд Бетта!"
        title.font = .systemFont(ofSize: 30, weight: .bold)
        view.backgroundColor = .red
    }
}
