
import XCTest

class FakeWagoMemoryGateway: WagoMemoryGateway {
    var lastWriteCommands: [MemoryCellWriteCommand]?
    var lastreadRange: WagoMemoryRange?
    
    func getData(atRange range: WagoMemoryRange, completion: @escaping ([UInt16]?, Error?) -> ()) {
        lastreadRange = range
        completion(nil,nil)
    }
    
    func writeCommands(_ commands: [MemoryCellWriteCommand], readRange: WagoMemoryRange, completion: @escaping ([UInt16]?, Error?) -> ()) {
        lastreadRange = readRange
        lastWriteCommands = commands
        completion(nil, nil)
    }

}

class WagoEventsTests: XCTestCase {
    var api: FakeWagoMemoryGateway?
    var processMemory: WagoProcessMemory?
    
    override func setUp() {
        let api = FakeWagoMemoryGateway()
        self.api = api
        processMemory = WagoProcessMemory(api: api)
    }

    func testWriteCommand() {
        processMemory?.queueWriteCommand(address: Address.mockAddress10, data: OnOffState.on)
        processMemory?.executeCommands()
        XCTAssertEqual(api?.lastWriteCommands?.last?.address.offset, 10)
        XCTAssertEqual(api?.lastWriteCommands?.last?.value, 1)
        XCTAssertEqual(api?.lastreadRange, .allMemory)
    }
    
    // TODO:
    /// - memory update after command execution
}
