import Foundation
import FirebaseCore
import FirebaseFirestore

public protocol FirestoreServiceProtocol {
    func saveUserProfile(uid: String, email: String, completion: @escaping (Result<Void, Error>) -> Void)
    func saveUserName(_ name: String, uid: String) async throws
}

public final class FirestoreService: FirestoreServiceProtocol {
    
    public static let shared = FirestoreService()
    private let db = Firestore.firestore()

    private init() { }

    public func saveUserProfile(uid: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let userData: [String: Any] = [
            "uid": uid,
            "email": email,
            "createdAt": Timestamp(date: Date())
        ]

        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    public func saveUserName(_ name: String, uid: String) async throws {
        
        let userData: [String: Any] = [ "name": name ]
        
        try await db.collection("users").document(uid).setData(userData, merge: true)
    }
}
