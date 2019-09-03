
import Foundation

class MockProcessMemoryCommandQueue: ProcessMemoryCommandQueue {
    var commandsData = [DataType]()
    func queueWriteCommand(address: Address, data: DataType) {
        commandsData.append(data)
    }
}
