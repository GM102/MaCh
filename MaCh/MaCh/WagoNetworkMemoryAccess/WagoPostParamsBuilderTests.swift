
import XCTest

struct MockWriteCommands {
    static let clearFirst4:[MemoryCellWriteCommand] = setFirst4(withValue: 0)
    static func setFirst4(withValue value:UInt) -> [MemoryCellWriteCommand] {
        return [0,1,2,3].map { (address) in
            let address = Address(offset: UInt(address))
            return MemoryCellWriteCommand(address: address, value: value)
        }
    }
}

class WagoPostParamsBuilderTests: XCTestCase {

    func testExampleParsing() {
        let commands = MockWriteCommands.clearFirst4
        let params = WagoPostParamsBuilder(writeCommands: commands).build()
        XCTAssertEqual(params.keys.count, 4 * 3)
        XCTAssertEqual(params["ADR4"], "MW3")
    }
    
    func testCommandBuilder() {
        let command = MemoryCellWriteCommand(address: Address.mockAddress10, value: 5)
        let params = command.build()
        XCTAssertEqual(params.count, 3)
        
    }
}
