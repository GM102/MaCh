
import Foundation

enum DataState: Equatable {
    case invalid
    //    case outdated(Int)
    case valid
    case queuedCommand
}

protocol MemoryUpdatePropagation {
    func update(forAddress address:Address, value:UInt16)
}

class ProcessElement<T:DataType>: MemoryUpdatePropagation {
    func update(forAddress address: Address, value: UInt16) {
        if address == self.address {
            dataState = .valid
            self.value.rawData = UInt(value)
            stateUpdatedCallback?(self)
        }
    }
    
    let address:Address
    var dataState:DataState
    let name:String
    private(set) var value:T
    var stateUpdatedCallback: ((ProcessElement) -> ())?
    let commandQueue:ProcessMemoryCommandQueue
    
    init(address:Address, name:String, value:T, commandQueue:ProcessMemoryCommandQueue) {
        self.address = address
        dataState = .invalid
        self.name = name
        self.value = value
        self.commandQueue = commandQueue
    }
    
    func setValue(_ value:T) {
        self.value = value
        dataState = .queuedCommand
        commandQueue.queueWriteCommand(address: address, data: value)
        stateUpdatedCallback?(self)
    }
}
