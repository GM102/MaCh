
import XCTest

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
    
    func testElementsBuilder() {
        let builder = ProcessElementsBuilder(commandQueue: MockProcessMemoryCommandQueue())
        let shader = builder.openClose(withName: "test", address: Address.mockAddress10)
        XCTAssertEqual(shader.value, OpenCloseState.stoppedInBetween(nil))
        shader.update(forAddress: Address.mockAddress10, value: 155)
        XCTAssertEqual(shader.value, OpenCloseState.stoppedInBetween(55))
        shader.update(forAddress: Address.mockAddress10, value: 1000)
        XCTAssertEqual(shader.value, OpenCloseState.stoppedInBetween(nil))
//        shader.setValue(.stoppedInBetween(1000))
//        XCTAssertEqual(shader.value, OpenCloseState.stoppedInBetween(nil))
    }
}
