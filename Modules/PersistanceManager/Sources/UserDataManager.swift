import CoreData

public final class UserDataManager: UserDataManagerProtocol {
    
    private let persistanceManager: PersistanceManagerProtocol
    
    public init(persistanceManager: PersistanceManagerProtocol) {
        self.persistanceManager = persistanceManager
    }
    
    public func createUser(with info: [String: Any]) {
        // Безопасное извлечение значений из словаря
        guard let uid = info["uid"] as? String,
              let name = info["name"] as? String,
              let email = info["email"] as? String else {
            print("Invalid user info provided")
            return
        }
        
        let userEntity = UserEntity(context: persistanceManager.context)
        userEntity.uid = uid
        userEntity.name = name
        userEntity.email = email
        persistanceManager.saveContext()
    }
    
    public func getUser(with uid: String) -> UserEntity? {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %@", uid)
        
        do {
            return try persistanceManager.context.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch user from database: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func getUsers() -> [UserEntity] {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            return try persistanceManager.context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch users from database: \(error.localizedDescription)")
            return []
        }
    }
    
    public func updateUser(_ info: [String: Any], for uid: String) {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %@", uid)
        
        do {
            if let user = try persistanceManager.context.fetch(fetchRequest).first {
                
                // Обновить поля вопросника
                
                persistanceManager.saveContext()
            } else {
                print("User not found for uid: \(uid)")
            }
        } catch {
            print("Failed to update user attributes in database: \(error.localizedDescription)")
        }
    }
    
    public func removeUser(with uid: String) {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %@", uid)
        
        do {
            if let user = try persistanceManager.context.fetch(fetchRequest).first {
                persistanceManager.context.delete(user)
                persistanceManager.saveContext()
            }
        } catch {
            print("Failed to remove user from database: \(error.localizedDescription)")
        }
    }
}
