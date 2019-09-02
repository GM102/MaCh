
import Foundation

protocol ProcessElementsRepository: MemoryUpdatePropagation {
    var onOffElements: [ProcessElement<OnOffState>] {get}
}

class ProcessElementsRepositoryImp: ProcessElementsRepository {
    func update(forAddress address: Address, value: UInt16) {
        onOffElements.forEach{$0.update(forAddress: address, value: value)}
    }
    
    var onOffElements = [ProcessElement<OnOffState>]()
}
