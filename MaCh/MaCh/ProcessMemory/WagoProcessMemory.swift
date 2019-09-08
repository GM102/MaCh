
import Foundation

protocol ProcessMemoryCommandQueue {
    func queueWriteCommand(address:Address, data:UInt)
}

protocol ProcessMemoryManagement {
    func executeCommands()
    func refreshData()
    var apiInterface:WagoMemoryGateway {get set}
}

protocol ProcessElementsRepository: UpdatableElement {
    var elements: [UpdatableElement] {get}
}

class WagoProcessMemory: ProcessMemoryCommandQueue, ProcessMemoryManagement, ProcessElementsRepository {
    var apiInterface: WagoMemoryGateway
    private var writeCommands = [MemoryCellWriteCommand]()
    var elements = [UpdatableElement]()

    init(api:WagoMemoryGateway) {
        self.apiInterface = api
    }

    func queueWriteCommand(address:Address, data:UInt) {
        writeCommands.append(MemoryCellWriteCommand(address: address, value: data))
    }
    
    func executeCommands() {
        apiInterface.writeCommands(writeCommands, readRange: .allMemory, completion: propagateMemoryUpdate)
    }
    
    func refreshData() {
        apiInterface.getData(atRange: .allMemory, completion: propagateMemoryUpdate)
    }
    
    private func propagateMemoryUpdate(_ ints:[UInt16]?, _ error:Error?) {
        ints?.enumerated().forEach({ tuple in
            let (offset, value) = tuple
            self.update(forAddress: Address(offset: UInt(offset)), value: value)
        })
    }

    func update(forAddress address: Address, value: UInt16) {
        elements.forEach{$0.update(forAddress: address, value: value)}
    }
 
    var onOffElements:[ProcessElement] {
        return elements.compactMap{$0 as? ProcessElement}
    }
}
