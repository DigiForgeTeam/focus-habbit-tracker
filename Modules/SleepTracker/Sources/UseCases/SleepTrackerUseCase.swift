protocol SleepTrackerUseCaseProtocol {
    // Define UseCase functions
    func execute()
}

class SleepTrackerUseCase: SleepTrackerUseCaseProtocol {
    private var service: SleepTrackerServiceProtocol

    init(service: SleepTrackerServiceProtocol) {
        self.service = service
    }

    func execute() {
        // Business logic here
    }
}
