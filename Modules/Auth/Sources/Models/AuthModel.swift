protocol AuthModelProtocol {
    // Define Model functions
    func fetchData()
    func saveData() -> Bool
}

class AuthModel: AuthModelProtocol {
    // Implement Model logic
    func fetchData() {
        // Your fetch logic here
    }

    func saveData() -> Bool {
        // Your save logic here
        return true
    }
}
