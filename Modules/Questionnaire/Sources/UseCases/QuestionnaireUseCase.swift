protocol QuestionnaireUseCaseProtocol {
    // Define UseCase functions
    func execute()
}

class QuestionnaireUseCase: QuestionnaireUseCaseProtocol {
    private var service: QuestionnaireServiceProtocol

    init(service: QuestionnaireServiceProtocol) {
        self.service = service
    }

    func execute() {
        // Business logic here
    }
}
