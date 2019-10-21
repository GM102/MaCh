
import XCTest

class MockProcessMemory: WagoProcessMemory {
    init() {
        super.init(api: FakeWagoMemoryGateway())
    }
}

struct MockProcessMemoryBuilder {
    var mockApi:MockProcessMemoryCommandQueue = MockProcessMemoryCommandQueue()
    mutating func build(withElements elements:[ProcessElement]) -> MockProcessMemory {
        let repo = MockProcessMemory()
        repo.elements = elements
        return repo
    }
}

class ProcessElementsRepositoryTests: XCTestCase {
    var processMemoryBuilder: MockProcessMemoryBuilder?
    var element: ProcessElement?
    var processMemory: WagoProcessMemory?
    
    override func setUp() {
        processMemoryBuilder = MockProcessMemoryBuilder()
        processMemoryBuilder?.mockApi = MockProcessMemoryCommandQueue()
        element = MockProcessElementBuilder(mockApi: processMemoryBuilder!.mockApi).exampleElement
        processMemory = processMemoryBuilder?.build(withElements:[element!])
    }

    func testProcessToElementUpdate() {
        let expectation = XCTestExpectation()
        expectation.assertForOverFulfill = true
        XCTAssertEqual(element?.value, 0)
        element?.stateUpdatedCallback = {element in
            XCTAssertEqual(element.dataState, DataState.valid)
            XCTAssertEqual(element.value, 1)
            expectation.fulfill()
        }
        processMemory?.update(forAddress: Address(offset: 123), value: 5)
        processMemory?.update(forAddress: element!.address, value: 1)
        processMemory?.update(forAddress: Address(offset: 7), value: 3)
        wait(for: [expectation], timeout: 1)
    }
    
    func testElementToProcessUpdate() {
        element?.setValue(4)
        XCTAssertEqual(processMemoryBuilder?.mockApi.commandsData.first, 4)
        XCTAssertEqual(processMemoryBuilder?.mockApi.commandsData.count, 1)
    }
}
