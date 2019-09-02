
import XCTest

class WagoResponseParsingTests: XCTestCase {

    func testParseMerkers() {
        let dto = WagoResponse(mockResponse())
        let result = dto?.memoryMap(ofType:.merkers)
        XCTAssertEqual(result?.count, 5)
        XCTAssertEqual(result?[0], 64515)
    }
    
    func testParseExample() {
        let dto = WagoResponse(mockResponse())
        XCTAssertEqual(dto?.memoryMap.count, 10)
    }

    func mockResponse() -> String {
        return
"""
{
   "M":[
      64515,
      0,
      255,
      0,
      0
   ],
   "Q":[
      16,
      0,
      0,
      0,
      0
   ]
}
"""
    }
}
