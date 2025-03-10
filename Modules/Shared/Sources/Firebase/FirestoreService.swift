//import FirebaseFirestore
import Foundation
import FirebaseCore

public final class FirestoreService {
    public static let shared = FirestoreService()
//    private let db = Firestore.firestore()

    private init() {}

    public func saveUserProfile(uid: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let userData: [String: Any] = [
            "uid": uid,
            "email": email,
            "createdAt": Timestamp(date: Date())
        ]
        
//        db.collection("users").document(uid).setData(userData) { error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//        }
    }
}
