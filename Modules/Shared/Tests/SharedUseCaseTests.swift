import XCTest
import {ModuleName}

class {ModuleName}UseCaseTests: XCTestCase {

    var useCase: {ModuleName}UseCase!
    var mockRepository: Mock{ModuleName}Repository!

    override func setUp() {
        super.setUp()
        mockRepository = Mock{ModuleName}Repository()
        useCase = {ModuleName}UseCaseImpl(repository: mockRepository)
    }

    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }

    func testExecute_shouldReturnSuccess_whenValidRequest() {
        // Given
        let request = {ModuleRequestModel}(userId: "123")
        mockRepository.stubbedFetchDataResult = .success({ModuleResponseModel}(data: "Valid data"))

        // When
        useCase.execute(request: request) { result in
            // Then
            switch result {
            case .success(let response):
                XCTAssertEqual(response.data, "Valid data")
            case .failure:
                XCTFail("Expected success, but got failure")
            }
        }
    }

    func testExecute_shouldReturnFailure_whenInvalidRequest() {
        // Given
        let request = {ModuleRequestModel}(userId: "123")
        mockRepository.stubbedFetchDataResult = .failure(NSError(domain: "Test", code: 0, userInfo: nil))

        // When
        useCase.execute(request: request) { result in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}

// Mock Repository

class Mock{ModuleName}Repository: {ModuleName}Repository {
    var stubbedFetchDataResult: Result<{ModuleResponseModel}, Error>?

    func fetchData(request: {ModuleRequestModel}, completion: @escaping (Result<{ModuleResponseModel}, Error>) -> Void) {
        if let result = stubbedFetchDataResult {
            completion(result)
        }
    }
}
