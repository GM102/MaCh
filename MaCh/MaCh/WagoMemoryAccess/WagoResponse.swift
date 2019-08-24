
import Foundation
import SwiftyJSON

struct WagoResponse {
    private var json:JSON
    
    init?(_ response:String?) {
        guard let response = response else {
            return nil
        }
        json = JSON(parseJSON:response)
    }
    
    func memoryMap(ofType type:WagoMemoryType) -> [UInt16] {
        return json[type.rawValue].arrayValue.compactMap{$0.uInt16}
    }
    
    var memoryMap:[UInt16] {
        return memoryMap(ofType: .merkers) + memoryMap(ofType: .outputs)
    }
}
