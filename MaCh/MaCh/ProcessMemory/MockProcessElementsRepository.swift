
import XCTest

struct MockProcessElementBuilder {
    var mockApi:MockProcessMemoryCommandQueue = MockProcessMemoryCommandQueue()
    var exampleOnOf: ProcessElement<OnOffState> {
        return ProcessElement(address: Address.mockAddress10, name: "test", value: OnOffState.off, commandQueue: mockApi)
    }
}

class MockProcessElementsRepository: WagoProcessMemory {
    init() {
        super.init(api: FakeWagoMemoryGateway())
    }
}

class MockProcessElementsRepositoryBuilder {
    var mockApi:MockProcessMemoryCommandQueue = MockProcessMemoryCommandQueue()
    func build() -> MockProcessElementsRepository {
        let repo = MockProcessElementsRepository()
        let element = MockProcessElementBuilder(mockApi: mockApi).exampleOnOf
        repo.elements.append(element)
        return repo
    }
}
