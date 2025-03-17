protocol PersistanceManagerUseCaseProtocol {
    // Define UseCase functions
    func execute()
}

class PersistanceManagerUseCase: PersistanceManagerUseCaseProtocol {
    private var service: PersistanceManagerServiceProtocol

    init(service: PersistanceManagerServiceProtocol) {
        self.service = service
    }

    func execute() {
        // Business logic here
    }
}
