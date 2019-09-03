
import XCTest

class ProcessElementsRepositoryTests: XCTestCase {
    var repoBuilder: MockProcessElementsRepositoryBuilder?
    override func setUp() {
        repoBuilder = MockProcessElementsRepositoryBuilder()
    }

    func testApiUpdate() {
        let expectation = XCTestExpectation()
        repoBuilder?.mockApi = MockProcessMemoryCommandQueue()
        let repo = repoBuilder?.build()
        let element = repo?.onOffElements.first
        XCTAssertEqual(element?.value, OnOffState.off)
        element?.stateUpdatedCallback = {element in
            XCTAssertEqual(element.dataState, DataState.valid)
            XCTAssertEqual(element.value, OnOffState.on)
            expectation.fulfill()
        }
        repo?.update(forAddress: element!.address, value: 1)
        wait(for: [expectation], timeout: 1)
    }
    
    func testGenerateCommand() {
        repoBuilder?.mockApi = MockProcessMemoryCommandQueue()
        let repo = repoBuilder?.build()
        let element = repo?.onOffElements.first
        element?.setValue(.on)
        XCTAssertEqual(repoBuilder?.mockApi.commandsData.first as? OnOffState, OnOffState.on)
        XCTAssertEqual(repoBuilder?.mockApi.commandsData.count, 1)
    }
}
