import CoreData


protocol PersistanceManagerServiceProtocol {
    func createUser()
    func updateUser(_ info: String)
    func getUser()
    func getUsers()
    func removeUser()
}

class PersistanceManagerService: PersistanceManagerServiceProtocol {
    func createUser() {
        <#code#>
    }
    
    func updateUser(_ info: String) {
        <#code#>
    }
    
    func getUser() {
        <#code#>
    }
    
    func getUsers() {
        <#code#>
    }
    
    func removeUser() {
        <#code#>
    }
}
