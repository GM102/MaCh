
import Foundation

//protocol UIntRepresentable {
//    init(rawValue: UInt)
////    var rawData: UInt {get set}
//}

enum OnOffState:UInt {
    case on = 1
    case off = 0
    
    var boolValue:Bool {
        switch self {
        case .on: return true
        case .off: return false
        }
    }
    
    init(rawValue: UInt) {
        self = rawValue > 0 ? .on : .off
    }
    
    init() {
        self = .off
    }
}

enum OpenCloseState {
    case opening
    case closing
    case open
    case closed
    case stoppedInBetween(Int?)
    
    init() {
        self = .stoppedInBetween(nil)
    }
}

extension OpenCloseState:RawRepresentable, Equatable {
    init(rawValue: UInt) {
        switch rawValue {
        case 0: self = .opening
        case 1: self = .closing
        case 2: self = .open
        case 3: self = .closed
        case 100..<200: self = .stoppedInBetween(Int(rawValue) - 100)
        default: self = .stoppedInBetween(nil)
        }
    }
    var rawValue: UInt {
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

