import FirebaseAuth
import Firebase
import FirebaseFirestore
import Shared

public protocol AuthServiceProtocol {
    func registerUser(
        email: String,
        password: String,
        completion: @escaping (
            Result<
            Void,
            Error
            >
        ) -> Void
    )
}

public final class AuthService: AuthServiceProtocol {
    
    public init() { }

    public func registerUser(
        email: String,
        password: String,
        completion: @escaping (
            Result<
            Void,
            Error
            >
        ) -> Void
    ) {
        FirebaseManager.shared.registerUser(email: email, password: password) { result in
            switch result {
            case .success(let uid):
                FirestoreService.shared.saveUserProfile(uid: uid, email: email) { saveResult in
                    completion(saveResult)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
