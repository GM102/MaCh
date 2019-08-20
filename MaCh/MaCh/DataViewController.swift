//
//  DataViewController.swift
//  MaCh
//
//  Created by Grzegorz Moscichowski on 20/08/2019.
//  Copyright © 2019 Grzegorz Moscichowski. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }


}

