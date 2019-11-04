
import Foundation

class Core {
    static let shared = Core()
    var simulatedPLC:SimulatedPLCMemoryGateway
    var process:WagoProcessMemory

    lazy var element0 = {
        process.addElement(withName: "name0", address: Address(offset: 0))
    }()
    lazy var element1 = {
        process.addElement(withName: "name1", address: Address(offset: 1))
    }()

    private var timer:Timer
    private init(){
        let plc = SimulatedPLCMemoryGateway()
        simulatedPLC = plc
        let process = WagoProcessMemory(api: simulatedPLC)
        self.process = process
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            plc.runloop.run()
            process.refreshData()
        }
    }
    
    
}
