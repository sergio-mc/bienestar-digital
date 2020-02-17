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
        if let reset = (storyboard?.instantiateViewController(withIdentifier: "login"))
        {
            reset.modalPresentationStyle = .fullScreen
            self.present(reset, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func segueReset(_ sender: Any) {
        if let reset = (storyboard?.instantiateViewController(withIdentifier: "reset"))
        {
            reset.modalPresentationStyle = .fullScreen
            self.present(reset, animated: true, completion: nil)
        }
    }
    
    func segueLogin()  {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    @IBOutlet weak var notificationsOutlet: UISegmentedControl!
    
    @IBAction func notificationsSelector(_ sender: Any) {
        let contenido = UNMutableNotificationContent()
        contenido.title = "Notificaciones"
        contenido.subtitle = "Estado"
        contenido.body = ""
        contenido.sound = UNNotificationSound.default
        contenido.badge = 3
        
        let disparador = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let peticion = UNNotificationRequest(identifier: "miNotificacion", content: contenido, trigger: disparador)
        
        
        
        switch notificationsOutlet.selectedSegmentIndex {
        case 0:
            UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound]){
                (autorizado,error) in
                if autorizado {
                    print("Permiso concedido")
                } else {
                    print("Permiso denegado")
                }
            }
            contenido.body = "Notificaciones desactivadas"
            UNUserNotificationCenter.current().add(peticion,withCompletionHandler: nil)
            break
        case 1:
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound]){
                (autorizado,error) in
                if autorizado {
                    print("Permiso concedido")
                } else {
                    print("Permiso denegado")
                }
            }
            contenido.body = "Notificaiones activadas"
            UNUserNotificationCenter.current().add(peticion,withCompletionHandler: nil)
            break
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in MockData.MockUpUser
        {
            userName.text = i.userName
        }
    }
    
}
