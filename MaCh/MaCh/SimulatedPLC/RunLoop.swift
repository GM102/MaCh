
import Foundation

class RunLoop {
    internal init(memory: ProgramMemory) {
        self.memory = memory
    }
    
    var memory:ProgramMemory
    var programs = [(ProgramMemory)->()]()
    
    func run() {
        programs.forEach { $0(memory) }
    }
    
    func run(_ loops:Int) {
        for _ in 0..<loops {
            run()
        }
    }
}
