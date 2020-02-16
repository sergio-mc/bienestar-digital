//
//  ProfileViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 15/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in MockData.MockUpUser
        {
            userName.text = i.userName
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        segueLogin()
        
    }
    
    func segueLogin()  {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    


}
