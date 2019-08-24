
import Foundation

enum WagoDataType: String {
    case word = "W" // 16 bit
    case byte = "B" // 8 bit
    case bite = "X" // 1 bit
}

struct WagoPostParamsBuilder {
    var writeCommands: [MemoryCellWriteCommand]
    
    func build() -> [String:String] {
        return writeCommands.enumerated().reduce(into:[String:String](), { (result, element) in
            let (index, command) = element
            let wagoIndex = index + 1
            result["ADR\(wagoIndex)"] = command.addressString
            result["VALUE\(wagoIndex)"] = String(command.value)
            result["FORMAT\(wagoIndex)"] = "%d"
        })
    }
}

struct MemoryCellWriteCommand {
    let memoryType = WagoMemoryType.merkers
    var dataType: WagoDataType
    var address: UInt
    var addressMinor: UInt?
    var value: UInt
    
    func build() -> [String:String] {
        return ["ADR1":addressString,
                "VALUE1":String(value),
                "FORMAT1":"%d"]
    }
    
    var addressString:String {
        return memoryType.rawValue + dataType.rawValue + String(address) + minorAddressString
    }
    
    private var minorAddressString:String {
        if let addressMinor = addressMinor {
            return ".\(addressMinor)"
        }
        return ""
    }
}

extension MemoryCellWriteCommand {
    init(address:UInt, value:UInt) {
        self.init(dataType: .word, address: address, addressMinor: nil, value: value)
    }
}
