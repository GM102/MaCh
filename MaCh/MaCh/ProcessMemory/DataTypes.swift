
import Foundation

protocol DataType {
    var rawData:UInt {get set}
}

enum OnOffState:DataType {
    case on
    case off
    
    var boolValue:Bool {
        switch self {
        case .on: return true
        case .off: return false
        }
    }
    
    var rawData: UInt {
        set {
            self = newValue > 0 ? .on : .off
        }
        get {
            switch self {
            case .on: return 1
            case .off: return 0
            }
        }
    }
}

enum OpenCloseState:DataType {
    case opening
    case closing
    case open
    case closed
    case stoppedInBetween(Int?)
    
    var rawData: UInt {
        set {
            switch newValue {
            case 0: self = .opening
            case 1: self = .closing
            case 2: self = .open
            case 3: self = .closed
            case let v where (v >= 100 && v <= 200): self = .stoppedInBetween(Int(v) - 100)
            default: self = .stoppedInBetween(nil)
            }
        }
        get {
            switch self {
            case .opening: return 0
            case .closing: return 1
            case .open: return 2
            case .closed: return 3
            case .stoppedInBetween(let percent): return UInt(100 + (percent ?? -1) )
            }
        }
    }
}


