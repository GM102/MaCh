
import XCTest

class SimulatedPLCIntegrationTest: XCTestCase {
    
    let bitAddress1 = Address(offset: 1)
    let bitAddress5 = Address(offset: 5)
    let simulatedPLC = SimulatedPLCMemoryGateway()
    lazy var process = WagoProcessMemory(api: simulatedPLC)
    var processElement1: ProcessElement?
    var processElement5: ProcessElement?

    
    func testPrepareSimulatedPLCEnvironment() {
        prepareSimulatedProgram()
        initialiseProcessElements()
        
        processElement1?.setValue(1)
        process.refreshData()
        
        XCTAssertEqual(processElement1?.value, 1)
        XCTAssertEqual(processElement5?.value, 0)
    }
    
    func testSimulatedPLCRunloop() {
        testPrepareSimulatedPLCEnvironment()
        let expectation = XCTestExpectation()
        processElement5?.stateUpdatedCallback = { element in
            XCTAssertEqual(element.value, 1)
            expectation.fulfill()
        }

        simulatedPLC.runloop.run()
        process.refreshData()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(processElement1?.value, 0)
        XCTAssertEqual(processElement5?.value, 1)
    }
    
    fileprivate func initialiseProcessElements() {
       processElement1 = process.addElement(withName: "name1", address: bitAddress1)
       processElement5 = process.addElement(withName: "name5", address: bitAddress5)
//       let elementBuilder = ProcessElementsBuilder(commandQueue: process)
//        processElement1 = elementBuilder.onOff(withName: "name1", address: bitAddress1)
//        processElement5 = elementBuilder.onOff(withName: "name5", address: bitAddress5)
//        process.elements = [
//            processElement1!,
//            processElement5!,
//        ]
    }

    private func prepareSimulatedProgram() {
        let program:(ProgramMemory)->() = {memory in
            let memory1 = memory.bit(forAddress: self.bitAddress1)
            memory.bit(forAddress: self.bitAddress5).value = memory1.value
            memory1.value = false
        }
        simulatedPLC.runloop.programs = [program]
    }
    
}
