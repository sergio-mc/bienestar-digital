//
//  AppTableViewCell.swift
//  bienestar_digital
//
//  Created by Sergio on 29/01/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import UIKit

// Clase para inicializar los outlets de la celda propia del TableView
class AppTableViewCell: UITableViewCell {

    
    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appTodayTime: UILabel!
    
}
