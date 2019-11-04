
import XCTest

class RunLoopTests: XCTestCase {
    let runloop = RunLoop(memory: ProgramMemoryImp())

    func testRunloopExecutesPrograms() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        let program:(ProgramMemory)->() = { _ in
            expectation.fulfill()
        }
        runloop.programs = [program]
        runloop.run(2)
        wait(for: [expectation], timeout: 1)
    }

    func testModifyMemory() {
        let program:(ProgramMemory)->() = { memory in
            let bit = memory.bit(forAddress: Address(offset: 0))
            bit.value = !bit.value
        }
        runloop.programs = [program]
        runloop.run(3)
        let bit = runloop.memory.bit(forAddress: Address(offset: 0))
        XCTAssertEqual(bit.value, true)
    }

}
