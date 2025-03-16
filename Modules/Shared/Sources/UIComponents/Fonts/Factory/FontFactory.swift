
import UIKit

public enum FontFactory {
    
    public enum Poppins {
        public static func bold(size: CGFloat) -> UIFont {
            return UIFont(name: "Poppins-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
        }
    }
    
    public enum OpenSans {
        public static func bold(size: CGFloat) -> UIFont {
            return UIFont(name: "OpenSans-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
        }
        
        public static func regular(size: CGFloat) -> UIFont {
            return UIFont(name: "OpenSans-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
        }
        
        public static func semiBold(size: CGFloat) -> UIFont {
            return UIFont(name: "OpenSans-SemiBold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
        }
    }
    
    public enum Inter {
        public static func medium(size: CGFloat) -> UIFont {
            return UIFont(name: "Inter-Medium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
        }
        
        public static func regular(size: CGFloat) -> UIFont {
            return UIFont(name: "Inter-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
        }
        
        public static func light(size: CGFloat) -> UIFont {
            return UIFont(name: "Inter-Light", size: size) ?? .systemFont(ofSize: size, weight: .light)
        }
    }
    
    public enum SFProDisplay {
        public static func regular(size: CGFloat) -> UIFont {
            return UIFont(name: "SF-Pro-Display-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
        }
        
        public static func semiBold(size: CGFloat) -> UIFont {
            return UIFont(name: "SF-Pro-Display-Semibold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
        }
        
        public static func bold(size: CGFloat) -> UIFont {
            return UIFont(name: "SF-Pro-Display-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
        }
    }
}

