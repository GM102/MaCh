
import Foundation

enum WagoMemoryRange {
    case everything // outputs & memory
    case allMemory
}

protocol WagoMemoryGateway {
    func getData(atRange range:WagoMemoryRange,
                 completion:@escaping ([UInt16]?, Error?)->())
    func writeCommands(_ commands:[MemoryCellWriteCommand],
                       readRange:WagoMemoryRange,
                       completion:@escaping ([UInt16]?, Error?)->())
}
