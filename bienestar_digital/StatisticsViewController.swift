//
//  StatisticsViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 11/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    var appTotalUsage = [String: Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appTotalUsage = AppTableViewController.GlobalVariable.appTotalUsage
        print(appTotalUsage)
        
    }
}
