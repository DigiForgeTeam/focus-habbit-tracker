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
