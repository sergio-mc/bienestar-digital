

import UIKit
import Foundation
import SkyFloatingLabelTextField
import Alamofire

class RegisterPageViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userConfirmPassword: SkyFloatingLabelTextField!
    
    
    // Función que al cargar la vista llama a eventos en sus elementos
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        usernameTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userConfirmPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
    }
    
    // Esta función notifica de cuando un textfield ha sido modificado
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                var errorMessage=""
                switch textfield {
                    
                case usernameTF:
                    if(text.count < 3) {
                        errorMessage = "Invalid username"
                    }
                case userEmailTF:
                    if(!DataHelpers.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }
                case userPasswordTF:
                    if(!DataHelpers.isValidPassword(text)) {
                        errorMessage = "Must contains 8 characters and 1 number"
                    }
                case userConfirmPassword:
                    if(!DataHelpers.isValidRepeatedPassword(text, userPasswordTF.text ?? "" )) {
                        errorMessage = "Passwords doesn't match"
                    }
                default:
                    errorMessage = ""
                }
                
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
    
    
    // Función que ejecuta un evento al pulsarse el botón. Valida los camptos del registro.
    @IBAction func signUpButton(_ sender: Any) {
        
        let userEmail = userEmailTF.text
        let userPassword = userPasswordTF.text
        let userName = usernameTF.text
        let repeatedPassword = userConfirmPassword.text
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userName!.isEmpty || repeatedPassword!.isEmpty)
        {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage: "All fields are required", alertType: 0), animated: true, completion: nil)
            
            return;
            
        } else {
            
            //Validation of email and password, CAMBIAR ESTO A UN METODO QUE VALIDE TODO
            if ( DataHelpers.isValidPassword(userPassword!) && DataHelpers.isValidEmail(userEmail!) && DataHelpers.isUsernameValid(userName!)){
                
                //Validation of passwords
                createUser(email: userEmail!,password: userPassword!,userName: userName!)
                
            } else {
                
                self.present(DataHelpers.displayAlert(userMessage: "You need to fix that first", alertType: 0), animated: true, completion: nil)
            }
        }
        
    }
    
    // Función que crea un usuario con un metodo post (FALSO).
    func createUser(email:String,password:String,userName:String)  {
        let url = URL(string:"http://0.0.0.0:8888/bienestar/public/api/")
        let user=User( email: email, password: password, userName: userName)
        
        AF.request(url!,
                   method: .post,
                   parameters:user,
                   encoder: JSONParameterEncoder.default
            
        ).response { response in
            do{
                let responseData:RegisterResponse = RegisterResponse(code: 500)
                if(responseData.code==500) {
                    self.segueLogin()
                    self.createUserFaked(email: email, password: password)
                    self.present(DataHelpers.displayAlert(userMessage:"Registered!", alertType: 1), animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    // Función donde se indica hacía donde irá dirigido el permorfSegue
    func segueLogin()  {
        performSegue(withIdentifier: "registerSegue", sender: nil)
    }
    
    // Función para añadir el usuario falso a el array de usuarios disponibles en MockData
    func createUserFaked(email:String,password:String)
    {
        let user = User( email: email, password: password)
        MockData.MockUpUser.append(user)
    }
    
    
    
}
