

import UIKit

// MARK: - CustomButton
class CustomButton: UIButton {
    //MARK: Constants
    enum Constants {
        static let height: CGFloat = 48
        static let cornerRadius: CGFloat = 14
    }
    
    // MARK: - Properties
    override var isEnabled: Bool {
           didSet {
               updateState()
           }
       }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
extension CustomButton {
    func configure(title: String, width: CGFloat, isEnabled: Bool = true) {
        setTitle(title, for: .normal)
        widthAnchor.constraint(equalToConstant: width).isActive = true
        self.isEnabled = isEnabled
    }
}

// MARK: - Private Methods
private extension CustomButton {
    func setupButton() {
        layer.cornerRadius = Constants.cornerRadius
        heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        setTitleColor(AppColor.secondaryText.color, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)  //изменить когда будет заведен шрифт
        updateState()
    }
    
    func updateState() {
        backgroundColor = isEnabled ? AppColor.buttonTabBarBackground.color : AppColor.buttonTabBarBackground.color.withAlphaComponent(0.7)
    }
}
