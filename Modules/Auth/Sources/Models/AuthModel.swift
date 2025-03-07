import Foundation

public struct User {
    public let uid: String
    public let email: String?
    
    public init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}
