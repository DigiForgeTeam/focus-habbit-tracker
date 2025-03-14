import XCTest
import {ModuleName}

class {ModuleName}ServiceTests: XCTestCase {

    var service: {ModuleName}Service!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        service = {ModuleName}Service(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        service = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testFetchData_shouldReturnSuccess_whenValidResponse() {
        // Given
        let endpoint = "someEndpoint"
        let expectedData = "{ModuleResponseModel}(data: \"Valid data\")"
        mockNetworkManager.stubbedFetchDataResult = .success(expectedData)

        // When
        service.fetchData(endpoint: endpoint, parameters: [:]) { result in
            // Then
            switch result {
            case .success(let response):
                XCTAssertEqual(response.data, "Valid data")
            case .failure:
                XCTFail("Expected success, but got failure")
            }
        }
    }

    func testFetchData_shouldReturnFailure_whenInvalidResponse() {
        // Given
        let endpoint = "someEndpoint"
        mockNetworkManager.stubbedFetchDataResult = .failure(NSError(domain: "Test", code: 0, userInfo: nil))

        // When
        service.fetchData(endpoint: endpoint, parameters: [:]) { result in
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

// Mock Network Manager

class MockNetworkManager: NetworkManager {
    var stubbedFetchDataResult: Result<{ModuleResponseModel}, Error>?

    func fetchData(endpoint: String, parameters: [String: Any], completion: @escaping (Result<{ModuleResponseModel}, Error>) -> Void) {
        if let result = stubbedFetchDataResult {
            completion(result)
        }
    }
}

