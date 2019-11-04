
import Foundation

class SimulatedPLCMemoryGateway: WagoMemoryGateway {
    let runloop = RunLoop(memory: ProgramMemoryImp())

    func getData(atRange range: WagoMemoryRange, completion: @escaping ([UInt16]?, Error?) -> ()) {
        let result:[UInt16] = (0..<UInt(10)).map { index in
            let bit = self.runloop.memory.bit(forAddress: Address(offset: index))
            return bit.value ? UInt16(1) : UInt16(0)
        }
        completion(result,nil)
    }
    
    func writeCommands(_ commands: [MemoryCellWriteCommand], readRange: WagoMemoryRange, completion: @escaping ([UInt16]?, Error?) -> ()) {
        commands.forEach{ command in
            let bit = runloop.memory.bit(forAddress: command.address)
            bit.value = command.value > 0
        }
        getData(atRange: readRange, completion: completion)
    }
}
