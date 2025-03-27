

import UIKit
import Shared

// MARK: - BasicProtocol
protocol BasicProtocol: AnyObject {
    func setTabBarVisibility(_ isVisible: Bool)
    func setNavBarTitle(_ title: String)
    func showBackButton(_ show: Bool)
}
    
// MARK: - BasicViewController
public class BasicViewController: UIViewController {
    //MARK: Constants
    enum Constants {
        enum NavigationBar {
            static let height: CGFloat = 44.adaptedHeight
            static let insets = UIEdgeInsets(top: 44.adaptedHeight, left: 19.adaptedWidth, bottom: .zero, right: -19.adaptedWidth)
        }
        enum TabBar {
            static let height: CGFloat = 53.adaptedHeight
            static let insets = UIEdgeInsets(top: .zero, left: 19.adaptedWidth, bottom: -27.adaptedHeight, right: -19.adaptedWidth)
            static let cornerRadius: CGFloat = 26
        }
    }
    
    // MARK: - UI Elements
    lazy var navigationBar: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: Constants.NavigationBar.height).isActive = true
        
        return view
    }()
    
    lazy var tabBar: CustomTabBar = {
        let view = CustomTabBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: Constants.TabBar.height).isActive = true
        view.layer.cornerRadius = Constants.TabBar.cornerRadius
        view.backgroundColor = AppColor.buttonTabBarBackground.color
        
        return view
    }()
    
    //
    lazy var testCircleView: SleepCircleView = {
        let view = SleepCircleView(sleepHours: 10, currentDay: "Wd")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setNavBarTitle("BasicViewController")
        
        view.addSubview(testCircleView)
        NSLayoutConstraint.activate([
            testCircleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testCircleView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Private Methods
private extension BasicViewController {
    //MARK: Func
    func configureUI() {
        view.backgroundColor = AppColor.background.color
        
        let insetsNavBar = Constants.NavigationBar.insets
        let insetsTabBar = Constants.TabBar.insets
        
        view.addSubview(navigationBar)
        view.addSubview(tabBar)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: insetsNavBar.top),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insetsNavBar.left),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insetsNavBar.right),
            
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insetsTabBar.left),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insetsTabBar.right),
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insetsTabBar.bottom)
        ])
    }
}

extension BasicViewController: BasicProtocol {
    //MARK: BasicProtocol
    func setTabBarVisibility(_ isVisible: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            tabBar.alpha = isVisible ? 1 : 0
            tabBar.isUserInteractionEnabled = isVisible
        }
    }
    
    func setNavBarTitle(_ title: String) {
        navigationBar.setTitle(title)
    }
    
    func showBackButton(_ show: Bool) {
        navigationBar.showBackButton(show)
    }
}
