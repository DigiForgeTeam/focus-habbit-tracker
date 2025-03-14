import Foundation

public struct User {
    public let uid: String
    public let email: String?
    public let photoURL: String?
    
    public init(uid: String, email: String?, photoURL: String?) {
        self.uid = uid
        self.email = email
        self.photoURL = photoURL
    }
}
