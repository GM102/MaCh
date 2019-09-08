
import XCTest

class ProcessElementTests: XCTestCase {
    func testExampleSetOperation() {
        let expectation = XCTestExpectation()
        let element = MockProcessElementBuilder().exampleOnOf
        XCTAssertEqual(element.dataState, DataState.invalid)
        element.stateUpdatedCallback = { element in
            XCTAssertEqual(element.dataState, DataState.queuedCommand)
            XCTAssertEqual(element.value, OnOffState.on.rawValue)
            expectation.fulfill()
        }
        element.setValue(OnOffState.on.rawValue)
        wait(for: [expectation], timeout: 1)
    }
    
    func testMemoryChangePropagation() {
        let element = MockProcessElementBuilder().exampleOnOf
        element.update(forAddress: Address(offset: 0), value: 10)
        XCTAssertEqual(element.dataState, DataState.invalid)
        XCTAssertEqual(element.value, OnOffState.off.rawValue)
        element.update(forAddress: Address(offset: 10), value: 1)
        XCTAssertEqual(element.dataState, DataState.valid)
        XCTAssertEqual(element.value, OnOffState.on.rawValue)
    }
    
    func testElementsBuilder() {
        let builder = ProcessElementsBuilder(commandQueue: MockProcessMemoryCommandQueue())
        let shader = builder.openClose(withName: "test", address: Address.mockAddress10)
        XCTAssertEqual(shader.value, OpenCloseState.stoppedInBetween(nil).rawValue)
        shader.update(forAddress: Address.mockAddress10, value: 155)
        XCTAssertEqual(shader.value, OpenCloseState.stoppedInBetween(55).rawValue)
        shader.update(forAddress: Address.mockAddress10, value: 1000)
        XCTAssertEqual(shader.value, OpenCloseState.stoppedInBetween(nil).rawValue)
        shader.setValue(OpenCloseState.stoppedInBetween(1000).rawValue)
        XCTAssertEqual(shader.value, OpenCloseState.stoppedInBetween(nil).rawValue)
    }
}
