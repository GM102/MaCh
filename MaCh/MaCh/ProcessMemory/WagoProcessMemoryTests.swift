
import XCTest

class FakeWagoMemoryGateway: WagoMemoryGateway {
    var lastWriteCommands: [MemoryCellWriteCommand]?
    var lastreadRange: WagoMemoryRange?
    var fakeReadMemory: [UInt16]?
    
    func getData(atRange range: WagoMemoryRange, completion: @escaping ([UInt16]?, Error?) -> ()) {
        lastreadRange = range
        completion(fakeReadMemory,nil)
    }
    
    func writeCommands(_ commands: [MemoryCellWriteCommand], readRange: WagoMemoryRange, completion: @escaping ([UInt16]?, Error?) -> ()) {
        lastreadRange = readRange
        lastWriteCommands = commands
        completion(fakeReadMemory, nil)
    }
}

class FakeElement:UpdatableElement {
    var lastUpdateValue: UInt16?
    func update(forAddress address: Address, value: UInt16) {
        lastUpdateValue = value
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
        let fakeElement = FakeElement()
        processMemory?.elements.append(fakeElement)
        api?.fakeReadMemory = [1]
        processMemory?.queueWriteCommand(address: Address.mockAddress10, data: OnOffState.on)
        processMemory?.executeCommands()
        XCTAssertEqual(api?.lastWriteCommands?.last?.address.offset, 10)
        XCTAssertEqual(api?.lastWriteCommands?.last?.value, 1)
        XCTAssertEqual(api?.lastreadRange, .allMemory)
        XCTAssertEqual(fakeElement.lastUpdateValue, 1)
    }
    
    func testRefreshData() {
        let fakeElement = FakeElement()
        processMemory?.elements.append(fakeElement)
        api?.fakeReadMemory = [7]
        processMemory?.refreshData()
        XCTAssertEqual(fakeElement.lastUpdateValue, 7)
    }

}
