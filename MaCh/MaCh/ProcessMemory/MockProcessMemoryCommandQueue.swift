
import Foundation

class MockProcessMemoryCommandQueue: ProcessMemoryCommandQueue {
    var commandsData = [UInt]()
    func queueWriteCommand(address: Address, data: UInt) {
        commandsData.append(data)
    }
}
