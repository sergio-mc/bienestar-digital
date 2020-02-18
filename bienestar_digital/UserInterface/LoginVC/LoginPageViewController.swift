

import UIKit
import SkyFloatingLabelTextField
import Foundation
import Alamofire

class LoginPageViewController: UIViewController, UITextFieldDelegate {
    
    fileprivate var activityView : UIView?
    
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    
    //Displays an alert with a message depending on the string passed through parameters
    
    
    // Función encargada de cuando se pulse el boton de logearse compruebe si hay errores, por lo contrario llama a la función loginUser()
    @IBAction func loginButton(_ sender: Any) {
        let userEmail = userEmailTF.text;
        let userPassword = userPasswordTF.text;
        
        if(userEmail!.isEmpty || userPassword!.isEmpty)
        {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage:"All fields are required", alertType: 0), animated: true, completion: nil)
            return;
            
        } else {
            
            if(DataHelpers.isValidEmail(userEmail!) && DataHelpers.isValidPassword(userPassword!) && DataHelpers.isValidUser(userEmail!, userPassword!)){
                loginUser(email: userEmail!, password: userPassword!)
                {
                    (isWorking) in
                   
                    if(isWorking) {self.segueLogin()
                           
                    }
                }
                self.showSpinner()
            }else{
                self.present(DataHelpers.displayAlert(userMessage:"Usuario no corresponde al especificado en MockData", alertType: 0), animated: true, completion: nil)
                return;
            }
            
        }
        
        
    }
    
    // Función que al cargar la vista cambia las propiedades de navigationBar y les añade eventos a elementos de esta.
    override func viewDidLoad() {
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // Esta función notifica de cuando se ha hecho un cambio en los elementos textfield de la vista
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                var errorMessage=""
                switch textfield {
                    
                case userEmailTF:
                    if(!DataHelpers.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }
                case userPasswordTF:
                    if(!DataHelpers.isValidPassword(text)) {
                        errorMessage = "Must contains 8 characters and 1 number"
                    }
                default:
                    errorMessage = ""
                }
                
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
    
    // Función asincrona (FALSA) en la cual se envía un usuario y valida si este existe o no. En caso de que si, entra en la aplicación, en caso contrario se avisa al usuario con un error.
    func loginUser(email:String,password:String, completion: @escaping (Bool) -> ()){
        let url = URL(string:"http://0.0.0.0:8888/bienestar/public/api/user/login")
        let user=User( email: email, password: password)
        
        AF.request(url!,
                   method: .post,
                   parameters:user,
                   encoder: JSONParameterEncoder.default
            
        ).response { response in
            print(response);
            var isWorking = false
            do{
                let responseData:RegisterResponse = RegisterResponse(code: 500)
                if(responseData.code==500) {
                    
                 
                    isWorking = true
                    completion(isWorking)
                    self.removeSpinner()
                    
                }
                
            }
        }
        
    }
    // Función donde se indica hacía donde irá dirigido el permorfSegue
    func segueLogin()  {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    // Función donde se muestra el spinner de carga
    func showSpinner()
    {
        activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        self.view.addSubview(activityView!)
    }
    
    // Función para eliminar el spinner de carga de la vista 
    func removeSpinner()
    {
        activityView?.removeFromSuperview()
        activityView = nil
    }
    
    
}
