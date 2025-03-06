protocol ReportUseCaseProtocol {
    // Define UseCase functions
    func execute()
}

class ReportUseCase: ReportUseCaseProtocol {
    private var service: ReportServiceProtocol

    init(service: ReportServiceProtocol) {
        self.service = service
    }

    func execute() {
        // Business logic here
    }
}
