//
//  AppTableViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 29/01/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import UIKit

class AppTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let apps = ["instagram","whatsapp","facebook","chrome","gmail","reloj"]
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = appTableView.dequeueReusableCell(withIdentifier: "AppCell") as? AppTableViewCell
        
        let imagen = apps[indexPath.item]
        cell?.appImage.image = UIImage.init(imageLiteralResourceName: imagen)
        
        cell?.appName.text = "Instagram"
        cell?.appTodayTime.text = "8 horas"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    
    
    
    @IBOutlet weak var appTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
    }
    

}
