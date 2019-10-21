
import XCTest

class DataTypesTests: XCTestCase {

    func testOpenCloseModelDefaults() {
        let data = OpenCloseState()
        XCTAssertEqual(data, OpenCloseState.stoppedInBetween(nil))
        XCTAssertEqual(data, OpenCloseState(rawValue: 1000))
//        XCTAssertEqual(data, OpenCloseState.stoppedInBetween(1000))
    }
}
