
import Foundation

protocol ProcessMemoryCommandQueue {
    func queueWriteCommand(address:Address, data:UInt)
}

protocol ProcessMemoryManagement {
    func refreshData()
    var apiInterface:WagoMemoryGateway {get set}
}

protocol ProcessElementsRepository: UpdatableElement {
    func addElement(withName name:String, address:Address) -> ProcessElement
    
    // create protocol to not expose UpdatableElement
    // introduce subscript?
    // remove elements array
    // change elements array type 
    func getElement(forAddress address:Address) -> UpdatableElement?
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
    
    func refreshData() {
        if writeCommands.count > 0 {
            executeCommands()
        }
        apiInterface.getData(atRange: .allMemory, completion: propagateMemoryUpdate)
    }
    
    private func executeCommands() {
        apiInterface.writeCommands(writeCommands, readRange: .allMemory, completion: propagateMemoryUpdate)
        writeCommands = []
    }
    
    private func propagateMemoryUpdate(_ ints:[UInt16]?, _ error:Error?) {
        ints?.enumerated().forEach({ [weak self] tuple in
            let (offset, value) = tuple
            self?.update(forAddress: Address(offset: UInt(offset)), value: UInt(value))
        })
    }

    func update(forAddress address: Address, value: UInt) {
        elements.forEach{$0.update(forAddress: address, value: value)}
    }
    
    func addElement(withName name: String, address: Address) -> ProcessElement {
        let element = ProcessElement(address: address, name: name, commandQueue: self)
        // FIXME: retain cycle
        elements.append(element)
        return element
    }
    
    func getElement(forAddress address: Address) -> UpdatableElement? {
        for element in elements {
            if (element as? ProcessElement)?.address == address {
                return element
            }
        }
        return nil
    }
    

}
