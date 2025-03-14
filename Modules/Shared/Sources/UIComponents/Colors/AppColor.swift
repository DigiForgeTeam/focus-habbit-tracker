//
//  AppColor.swift
//  HelpProject
//
//  Created by Вячеслав Пучков on 14.03.2025.
//

import UIKit

enum AppColor {
    
    case background         // Фон приложения
    case surface            // Поверхности карточек, модальных окон
    case primaryText        // Основной текст
    case secondaryText      // Второстепенный текст
    case accentRed          // Красный для ошибок, удаления
    case borderGray         // Серый для бордеров
    case borderBlue         // Синий для бордеров
    case textFieldBackground // Фон текстфилда
    case buttonTabBarBackground // Общий фон для кнопок и таббара
    case tabBarInactive     // Цвет неактивного таббара
    case tabBarActive       // Цвет активного таббара
    
    var color: UIColor {
        switch self {
        case .background:
            return UIColor(dynamicLight: "#0B0B19", dark: "#0B0B19")
        case .surface:
            return UIColor(dynamicLight: "#14142F", dark: "#14142F")
        case .primaryText:
            return UIColor(dynamicLight: "#FFFFFF", dark: "#FFFFFF")
        case .secondaryText:
            return UIColor(dynamicLight: "#0B0B19", dark: "#0B0B19")
        case .accentRed:
            return UIColor(dynamicLight: "#FF453A", dark: "#FF453A")
        case .borderGray:
            return UIColor(dynamicLight: "#4A484A", dark: "#4A484A")
        case .textFieldBackground:
            return UIColor(dynamicLight: "#2C2C2E", dark: "#2C2C2E")
        case .borderBlue:
            return UIColor(dynamicLight: "#37395E", dark: "#37395E")
        case .tabBarInactive:
            return UIColor(dynamicLight: "#949494", dark: "#949494")
        case .tabBarActive:
            return UIColor(dynamicLight: "#FBDF70", dark: "#FBDF70")
        case .buttonTabBarBackground:
            return UIColor(dynamicLight: "#FFFFFF", dark: "#FFFFFF")
        }
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }

    /// Поддержка светлой и темной темы
    convenience init(dynamicLight lightHex: String, dark darkHex: String) {
        self.init { traitCollection in
            return traitCollection.userInterfaceStyle == .dark
                ? UIColor(hex: darkHex)
                : UIColor(hex: lightHex)
        }
    }
}
