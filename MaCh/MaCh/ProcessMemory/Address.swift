
import Foundation

enum WagoMemoryType:String {
    case merkers = "M"
    case outputs = "Q"
}

enum WagoDataType: String {
    case word = "W" // 16 bit
    case byte = "B" // 8 bit
    case bit = "X" // 1 bit
}

struct Address:Equatable {
    let memoryType: WagoMemoryType
    let dataType: WagoDataType
    let offset: UInt
    let offsetBit: UInt?
    
    var addressString:String {
        return memoryType.rawValue + dataType.rawValue + String(offset) + offsetBitString
    }
    
    private var offsetBitString:String {
        if let offsetBit = offsetBit {
            return ".\(offsetBit)"
        }
        return ""
    }
}

extension Address {
    init(offset:UInt) {
        self.init(memoryType:.merkers, dataType: .word, offset: offset, offsetBit: nil)
    }
}
