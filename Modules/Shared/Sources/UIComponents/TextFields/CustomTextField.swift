

import UIKit


//MARK: - CustomTextFieldViewProtocol
public protocol CustomTextFieldViewProtocol: AnyObject {
    func getEnteredText() -> String?
}

//MARK: - CustomTextField
public class CustomTextField: UITextField {
    //MARK: - Constants
    enum Constants {
        static let size = CGSize(width: 342.adaptedWidth, height: 44.adaptedHeight)
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - Init
    public init(placeholderTitle: String) {
        super.init(frame: .zero)
        self.placeholder = placeholderTitle
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - Private Methods
private extension CustomTextField {
    private func setupTextField() {
        backgroundColor = AppColor.textFieldBackground.color
        layer.borderWidth = 1
        layer.borderColor = AppColor.borderGray.color.cgColor
        heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        layer.cornerRadius = Constants.cornerRadius
#warning("Заменить шрифт")
        font = UIFont.systemFont(ofSize: 16)
        textColor = AppColor.primaryText.color
         if let placeholder = self.placeholder {
             self.attributedPlaceholder = NSAttributedString(
                 string: placeholder,
                 attributes: [
                    .foregroundColor: AppColor.primaryText.color.withAlphaComponent(0.6),
                     .font: UIFont.systemFont(ofSize: 16)
                 ]
             )
         }
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24.adaptedWidth, height: .zero))
        leftView = paddingView
        leftViewMode = .always
    }
}

// MARK: - Public Methods
extension CustomTextField: CustomTextFieldViewProtocol {
    public func getEnteredText() -> String? {
        return self.text ?? ""
    }
}

