
import Foundation

struct WagoPostParamsBuilder {
    var writeCommands: [MemoryCellWriteCommand]
    
    func build() -> [String:String] {
        return writeCommands.enumerated().reduce(into:[String:String](), { (result, element) in
            let (index, command) = element
            let wagoIndex = index + 1
            result["ADR\(wagoIndex)"] = command.address.addressString
            result["VALUE\(wagoIndex)"] = String(command.value)
            result["FORMAT\(wagoIndex)"] = "%d"
        })
    }
}

struct MemoryCellWriteCommand {
    let address: Address
    var value: UInt
    
    func build() -> [String:String] {
        return ["ADR1":address.addressString,
                "VALUE1":String(value),
                "FORMAT1":"%d"]
    }
}
