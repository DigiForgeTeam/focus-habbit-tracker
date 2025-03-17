import CoreData


public final class CoreDataManager: PersistanceManagerProtocol {
    
    public init() {
        self.setup()
    }
    
    private let persistanceContainer = NSPersistentContainer(name: "MainDataModel")
    
    public var context: NSManagedObjectContext {
        persistanceContainer.viewContext
    }
    
    private func setup() {
        persistanceContainer.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("Successfully loaded CoreData")
            }
        }
    }
    
    public func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Context saved successfully.")
            } catch {
                let nsError = error as NSError
                print("Failed to save context: \(nsError.localizedDescription), \(nsError.userInfo)")
            }
        }
    }
}
