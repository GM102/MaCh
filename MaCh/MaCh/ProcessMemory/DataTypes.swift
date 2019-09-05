
import Foundation

protocol DataType {
    var rawData: UInt {get set}
//    static var defaultValue: Self {get}
}

enum OnOffState:DataType, Equatable {
    
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
    
    init() {
        self = .off
    }
}

enum OpenCloseState:DataType, Equatable {
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
            case 100..<200: self = .stoppedInBetween(Int(newValue) - 100)
            default: self = .stoppedInBetween(nil)
            }
        }
        get {
            switch self {
            case .opening: return 0
            case .closing: return 1
            case .open: return 2
            case .closed: return 3
            case .stoppedInBetween(.none): return 4
            case .stoppedInBetween(.some(let percent)): return UInt(100 + percent)
            }
        }
    }
    init() {
        self = .stoppedInBetween(nil)
    }
}

