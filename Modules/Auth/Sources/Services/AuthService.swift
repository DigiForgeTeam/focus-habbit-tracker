import Firebase
import FirebaseAuth
//import FirebaseFirestore
import FirebaseModule

public protocol AuthServiceProtocol {
    func registerUser(email: String, password: String) async throws
}

public final class AuthService: AuthServiceProtocol {
    
    public init() { }
    
    //    public func registerUser(
    //        email: String,
    //        password: String,
    //        completion: @escaping (Result<Void,Error>) -> Void
    //    ) {
    //        FirebaseManager.shared.registerUser(email: email, password: password) { result in
    //            switch result {
    //            case .success(let uid):
    //                FirestoreService.shared.saveUserProfile(uid: uid, email: email) { saveResult in
    //                    completion(saveResult)
    //                }
    //            case .failure(let error):
    //                completion(.failure(error))
    //            }
    //        }
    //    }
    
    public func registerUser(email: String, password: String) async throws {
        do {
//            let authResult = try await FirebaseManager.shared.registerUser(email: email, password: password)
//            let uid = authResult.user.uid
            
//            try await FirestoreService.shared.saveUserProfile(uid: uid, email: email)
        } catch {
            throw error
        }
    }
}
