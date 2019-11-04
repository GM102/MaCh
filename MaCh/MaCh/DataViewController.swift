
import UIKit

class DataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var dataObject: String = ""

    var datasource:[ProcessElement] = [Core.shared.element0, Core.shared.element1]

    override func viewDidLoad() {
        super.viewDidLoad()
        let program:(ProgramMemory)->() = {memory in
            let memory0 = memory.bit(forAddress: Address(offset: 0))
            memory.bit(forAddress: Address(offset: 1)).value = memory0.value
        }
        Core.shared.simulatedPLC.runloop.programs = [program]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "switch", for: indexPath)
        
        (cell as? SwitchComponent)?.setup(withElement: datasource[indexPath.row] )
        
        return cell
    }
}

