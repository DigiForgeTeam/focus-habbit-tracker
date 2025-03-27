
import UIKit

public enum FontFactory {
    
    public static func poppinsBold(size: CGFloat) -> UIFont { font("Poppins-Bold", size, .bold) }
    public static func openSansBold(size: CGFloat) -> UIFont { font("OpenSans-Bold", size, .bold) }
    public static func openSansRegular(size: CGFloat) -> UIFont { font("OpenSans-Regular", size, .regular) }
    public static func openSansSemiBold(size: CGFloat) -> UIFont { font("OpenSans-SemiBold", size, .semibold) }
    public static func interMedium(size: CGFloat) -> UIFont { font("Inter-Medium", size, .medium) }
    public static func interRegular(size: CGFloat) -> UIFont { font("Inter-Regular", size, .regular) }
    public static func interLight(size: CGFloat) -> UIFont { font("Inter-Light", size, .light) }
    public static func sfProDisplayRegular(size: CGFloat) -> UIFont { font("SF-Pro-Display-Regular", size, .regular) }
    public static func sfProDisplaySemiBold(size: CGFloat) -> UIFont { font("SF-Pro-Display-Semibold", size, .semibold)}
    public static func sfProDisplayBold(size: CGFloat) -> UIFont { font("SF-Pro-Display-Bold", size, .bold) }

    private static func font(_ name: String, _ size: CGFloat, _ weight: UIFont.Weight) -> UIFont {
        return UIFont(name: name, size: size) ?? .systemFont(ofSize: size, weight: weight)
    }
}
