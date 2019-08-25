//
//import Foundation
//
//enum OnOffState {
//    case on
//    case off
//    
//    var boolValue:Bool {
//        switch self {
//        case .on: return true
//        case .off: return false
//        }
//    }
//}
//    
//enum OpenCloseAction {
//    case opening
//    case closing
//    case stop
//}
//
//enum OpenCloseState {
//    case opening
//    case closing
//    case open
//    case closed
//    case stoppedInBetween(Int?)
//}
//
//enum ActionType {
//    case get(OpenCloseState)
//    case set(OpenCloseAction)
//    case get(OnOffState)
//    case set(OnOffState)
//    case getValue(Int)
//    case setValue(Int)
//}
//
//struct ElementViewModel {
//    
//}
//
//struct ElementAction {
//    var name: String
//    var viewModel: ElementViewModel
//}
//
//struct Element {
//    var name: String
//    var actions: [ElementAction]
//    
////    var address: Address
//    
//    // possible actions for role
//}
//
//struct Sensor {
//    func requestUpdate() {
//        
//    }
//}
//
//struct Actor {
//    func performAction() {
//        
//    }
//}
//
//// get all Room Elements
////
//
////class Room {
////    var blinds:[Blind]
////    var lights:[Light]
////    var windows:[Window]
////    var sensors:[Sensor]
////}
////
////class Chata {
////    var salon:Room
////    var pokojE:Room
////    var pokojN:Room
////    var garderoba:Room
////    var lazienka:Room
////    var hol:Room
////    var kotlownia:Room
////
////    var pokojJ:Room
////    var pokojZ:Room
////    var holPietro:Room
////    var lazienkaPietro:Room
////
////    var strych:Room
////}
