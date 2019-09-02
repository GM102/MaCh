
import XCTest

struct MockProcessElementBuilder {
    var mockApi:MockProcessMemoryCommandQueue = MockProcessMemoryCommandQueue()
    var exampleOnOf: ProcessElement<OnOffState> {
        return ProcessElement(address: Address(offset: 10), name: "test", value: OnOffState.off, commandQueue: mockApi)
    }
}

class MockProcessElementsRepository: ProcessElementsRepositoryImp {
}

class MockProcessElementsRepositoryBuilder {
    var mockApi:MockProcessMemoryCommandQueue = MockProcessMemoryCommandQueue()
    func build() -> MockProcessElementsRepository {
        let repo = MockProcessElementsRepository()
        let element = MockProcessElementBuilder(mockApi: mockApi).exampleOnOf
        repo.onOffElements.append(element)
        return repo
    }
}

class ProcessElementTests: XCTestCase {
    func testExampleSetOperation() {
        let expectation = XCTestExpectation()
        let element = MockProcessElementBuilder().exampleOnOf
        XCTAssertEqual(element.dataState, DataState.invalid)
        element.stateUpdatedCallback = { element in
            XCTAssertEqual(element.dataState, DataState.queuedCommand)
            XCTAssertEqual(element.value, OnOffState.on)
            expectation.fulfill()
        }
        element.setValue(.on)
        wait(for: [expectation], timeout: 1)
    }
    
    func testMemoryChangePropagation() {
        let element = MockProcessElementBuilder().exampleOnOf
        element.update(forAddress: Address(offset: 0), value: 10)
        XCTAssertEqual(element.dataState, DataState.invalid)
        XCTAssertEqual(element.value, OnOffState.off)
        element.update(forAddress: Address(offset: 10), value: 1)
        XCTAssertEqual(element.dataState, DataState.valid)
        XCTAssertEqual(element.value, OnOffState.on)
    }
}
