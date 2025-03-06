protocol AuthUseCaseProtocol {
    // Define UseCase functions
    func execute()
}

class AuthUseCase: AuthUseCaseProtocol {
    private var service: AuthServiceProtocol

    init(service: AuthServiceProtocol) {
        self.service = service
    }

    func execute() {
        // Business logic here
    }
}
