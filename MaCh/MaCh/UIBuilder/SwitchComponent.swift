
import Foundation
import UIKit

@IBDesignable
class SwitchComponent: UITableViewCell {
    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    weak var element: ProcessElement?
    
    func setup(withElement element:ProcessElement) {
        self.element = element
        title.text = element.name
        element.stateUpdatedCallback = { element in
            self.switchView.isOn = element.value != 0
        }
    }
    
    @IBAction func valueChanged(_ sender: UISwitch) {
        element?.setValue(sender.isOn ? 1 : 0)
    }
    
}
