import FirebaseAuth

public protocol NetworkServiceProtocol {
    func registerUser(email: String, password: String) async throws -> AuthDataResult
}

public final class FirebaseManager: NetworkServiceProtocol {
    
    public static let shared = FirebaseManager()
    
    private init() { }
    
    public func registerUser(email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().createUser(withEmail: email, password: password)
    }
}
