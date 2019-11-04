
import XCTest

class ProcessElementTests: XCTestCase {
    func testExampleSetOperation() {
        let expectation = XCTestExpectation()
        let element = MockProcessElementBuilder().exampleElement
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
        let element = MockProcessElementBuilder().exampleElement
        element.update(forAddress: Address(offset: 0), value: 10)
        XCTAssertEqual(element.dataState, DataState.invalid)
        XCTAssertEqual(element.value, OnOffState.off.rawValue)
        element.update(forAddress: Address(offset: 10), value: 1)
        XCTAssertEqual(element.dataState, DataState.valid)
        XCTAssertEqual(element.value, OnOffState.on.rawValue)
    }
    
    func testElementsBuilder() {
        let shader = ProcessElement(address: Address.mockAddress10,
                                    name: name,
                                    value: OpenCloseState().rawValue,
                                    commandQueue: MockProcessMemoryCommandQueue())
        XCTAssertEqual(shader.value, OpenCloseState.stoppedInBetween(nil).rawValue)
        shader.update(forAddress: Address.mockAddress10, value: 155)
        XCTAssertEqual(shader.value, OpenCloseState.stoppedInBetween(55).rawValue)
        // TODO: its not a good place to introduce OnOffState/OpenCloseState
    }
}
