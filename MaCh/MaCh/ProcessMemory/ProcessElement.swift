
import Foundation

enum DataState: Equatable {
    case invalid
    //    case outdated(Int)
    case valid
    case queuedCommand
}

protocol UpdatableElement {
    func update(forAddress address:Address, value:UInt16)
}

class ProcessElement: UpdatableElement {
    func update(forAddress address: Address, value: UInt16) {
        if address == self.address {
            dataState = .valid
            self.value = UInt(value)
            stateUpdatedCallback?(self)
        }
    }
    
    let address:Address
    var dataState:DataState
    let name:String
    private(set) var value:UInt
    var stateUpdatedCallback: ((ProcessElement) -> ())?
    let commandQueue:ProcessMemoryCommandQueue
    
    init(address:Address, name:String, value:UInt, commandQueue:ProcessMemoryCommandQueue) {
        self.address = address
        dataState = .invalid
        self.name = name
        self.value = value
        self.commandQueue = commandQueue
    }
    
    func setValue(_ value:UInt) {
        self.value = value
        dataState = .queuedCommand
        commandQueue.queueWriteCommand(address: address, data: value)
        stateUpdatedCallback?(self)
    }
}

struct ProcessElementsBuilder {
    let commandQueue:ProcessMemoryCommandQueue
    
    func onOff(withName name:String, address:Address) -> ProcessElement {
        return ProcessElement(address: address, name: name, value: OnOffState().rawValue, commandQueue: commandQueue)
    }
    
    func openClose(withName name:String, address:Address) -> ProcessElement {
        return ProcessElement(address: address, name: name, value: OpenCloseState().rawValue, commandQueue: commandQueue)
    }
}
