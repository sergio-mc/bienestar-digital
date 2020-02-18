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
    
    // Función que al cargar la vista setea el nombre del correspondiente usuario
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in MockData.MockUpUser
        {
            userName.text = i.userName
        }
    }
    
    // Función que cuando el boton es pulsado se envia de nuevo al usuario al login.
    @IBAction func logOut(_ sender: Any) {
        if let reset = (storyboard?.instantiateViewController(withIdentifier: "login"))
        {
            reset.modalPresentationStyle = .fullScreen
            self.present(reset, animated: true, completion: nil)
        }
        
    }
    
    // Función donde se hace un segue a la vista de recuperación de contraseña tras haber pulsado el botón
    @IBAction func segueReset(_ sender: Any) {
        if let reset = (storyboard?.instantiateViewController(withIdentifier: "reset"))
        {
            reset.modalPresentationStyle = .fullScreen
            self.present(reset, animated: true, completion: nil)
        }
    }
    
    // Función donde se indica hacía donde irá dirigido el permorfSegue
    func segueLogin()  {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    @IBOutlet weak var notificationsOutlet: UISegmentedControl!
    
    // Función donde indepedientemente del index que tenga el selector, te envía una alerta de permisos de notificaciones.
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
    
    // Función donde cada vez que la vista se ejecute se setea el correspondiente usuario
    override func viewWillAppear(_ animated: Bool) {
        for i in MockData.MockUpUser
        {
            userName.text = i.userName
        }
    }
    
}
