protocol ReportModelProtocol {
    // Define Model functions
    func fetchData()
    func saveData() -> Bool
}

class ReportModel: ReportModelProtocol {
    // Implement Model logic
    func fetchData() {
        // Your fetch logic here
    }

    func saveData() -> Bool {
        // Your save logic here
        return true
    }
}
