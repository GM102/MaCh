
import XCTest

enum OnOffState {
    case on
    case off

    var boolValue:Bool {
        switch self {
        case .on: return true
        case .off: return false
        }
    }
}

enum OpenCloseState {
    case opening
    case closing
    case open
    case closed
    case stoppedInBetween(Int?)
}

enum DataQuality: Equatable {
    case invalid
    case outdated(Int)
    case valid
}

protocol ElementState {
    associatedtype State
    var quality: DataQuality {get}
    var state: State {get}
}

class Element<State>: ElementState {
    var name: String
    private(set) var quality = DataQuality.invalid
    private(set) var state: State
    
    init(name: String, quality: DataQuality = .invalid, state: State) {
        self.name = name
        self.quality = quality
        self.state = state
    }
    
    func update(_ state:State) {
        self.state = state
        quality = .valid
    }
}

class ElementsRepository {
    func getOne() -> Element<OnOffState> {
        return Element(name: "", quality: .invalid, state: OnOffState.off)
    }
}

class ElementTests: XCTestCase {
    func testExample() {
        var element = ElementsRepository().getOne()
        XCTAssertEqual(element.quality, .invalid)
        XCTAssertEqual(element.state, OnOffState.off)
        element.update(.on)
        XCTAssertEqual(element.quality, .valid)
        XCTAssertEqual(element.state, OnOffState.on)
    }

}
