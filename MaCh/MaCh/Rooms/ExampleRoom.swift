
import Foundation

protocol Button {
    var name:String {get}
    func tap()
    var state:Bool {get set}
    var stateListener:(Bool)->Void {get set}
}

protocol Label {
    var name:String {get}
    var text:String {get set}
    var stateListener:(String)->Void {get set}
}


//struct Room {
//    var toggles = [BinaryElement]()
//}
