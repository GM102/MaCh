
import Foundation

enum WagoMemoryRange {
    case everything
}

enum WagoMemoryType:String {
    case merkers = "M"
    case outputs = "Q"
}

protocol WagoMemoryGateway {
    func getData(atRange range:WagoMemoryRange,
                 completion:@escaping ([UInt16]?, Error?)->())
    func writeCommands(_ commands:[MemoryCellWriteCommand],
                       readRange:WagoMemoryRange,
                       completion:@escaping ([UInt16]?, Error?)->())
}
