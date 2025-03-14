import FirebaseAuth

public protocol FirebaseModuleServiceProtocol {
    func registerUser(email: String, password: String) async throws -> AuthDataResult
}

public final class FirebaseManager: FirebaseModuleServiceProtocol {
    
    public static let shared = FirebaseManager()
    
    private init() { }
    
    public func registerUser(email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().createUser(withEmail: email, password: password)
    }
}


//    public func registerUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
//        Auth.auth().createUser(withEmail: email, password: password) {
//            result,
//            error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            guard let uid = result?.user.uid else {
//                completion(
//                    .failure(
//                        NSError(
//                            domain: "FirebaseError",
//                            code: -1,
//                            userInfo: [NSLocalizedDescriptionKey: "User ID not found"]
//                        )
//                    )
//                )
//                return
//            }
//            completion(.success(uid))
//        }
//    }
