
import Alamofire
import SwiftyJSON

struct WagoURL {
    private static let baseUrl = "http://192.168.1.201/"
    private static var readRangesBaseUrl:String {
        return baseUrl + "webserv/samples/"
    }
    static var writeAPI: String {
        return baseUrl + "WRITEPI"
    }
    
    static func readAPI(withMemoryRange range:WagoMemoryRange) -> String {
        switch range {
        case .everything:
            return readRangesBaseUrl + "all_hex.ssi"
        }
    }
}

import Foundation

class WagoMemoryNetworkAPI: WagoMemoryGateway {
    static let shared:WagoMemoryGateway = WagoMemoryNetworkAPI()
    
    func getData(atRange range: WagoMemoryRange, completion: @escaping ([UInt16]?, Error?) -> ()) {
        Alamofire.request(WagoURL.readAPI(withMemoryRange: range), method: .get, parameters: nil).validate().responseString { (response) in
            completion(WagoResponse(response.result.value)?.memoryMap, nil)
        }
    }

    func writeCommands(_ commands: [MemoryCellWriteCommand],
                       readRange: WagoMemoryRange,
                       completion: @escaping ([UInt16]?, Error?) -> ()) {
        let paramsBuilder = WagoPostParamsBuilder(writeCommands: commands)
        let headers = ["Referer:": WagoURL.readAPI(withMemoryRange: readRange)]
        Alamofire.request(WagoURL.writeAPI,
                          method: .post,
                          parameters: paramsBuilder.build(),
                          encoding:URLEncoding.httpBody,
                          headers:headers).validate().responseString { (response) in
                            completion(WagoResponse(response.result.value)?.memoryMap, nil)
        }
    }
}
