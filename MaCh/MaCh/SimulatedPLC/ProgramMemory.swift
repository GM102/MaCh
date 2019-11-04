
import Foundation

class ProgramMemoryImp: ProgramMemory {
    private var contents = [MemoryCell]()
    
    func bit(forAddress address:Address) -> MemoryBit {
        for cell in contents {
            if cell.address == address {
                return cell.load
            }
        }
        let newCell = MemoryCell(address: address, load: MemoryBit())
        contents.append(newCell)
        return newCell.load
    }
}

class MemoryBit {
    var value = false
}

struct MemoryCell {
    let address:Address
    let load:MemoryBit
}

protocol ProgramMemory {
    func bit(forAddress address:Address) -> MemoryBit
}
