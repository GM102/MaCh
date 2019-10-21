
struct MockProcessElementBuilder {
    var mockApi:MockProcessMemoryCommandQueue = MockProcessMemoryCommandQueue()
    var exampleElement: ProcessElement {
        return ProcessElement(address: Address.mockAddress10, name: "test", value: 0, commandQueue: mockApi)
    }
}
