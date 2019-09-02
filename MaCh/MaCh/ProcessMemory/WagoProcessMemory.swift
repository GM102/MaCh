
import Foundation

protocol ProcessMemoryCommandQueue {
    func queueWriteCommand(address:Address, data:DataType)
}

protocol ProcessMemoryManagement {
    func executeCommands()
    var apiInterface:WagoMemoryGateway {get set}
}

class WagoProcessMemory: ProcessMemoryCommandQueue, ProcessMemoryManagement {
    func queueWriteCommand(address:Address, data:DataType) {
        writeCommands.append(MemoryCellWriteCommand(address: address, value: data.rawData))
    }
    
    var apiInterface: WagoMemoryGateway
    private var writeCommands = [MemoryCellWriteCommand]()
    
    init(api:WagoMemoryGateway) {
        self.apiInterface = api
    }
    
    func executeCommands() {
        apiInterface.writeCommands(writeCommands, readRange: .allMemory) { (ints, error) in
            //
        }
    }
    
}
