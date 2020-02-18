import UIKit
import SkyFloatingLabelTextField
import Foundation
import Alamofire
class RecoverPageViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var userEmail: SkyFloatingLabelTextField!
    
    fileprivate var activityView : UIView?
    
    
    // Función donde se llama un evento al ser pulsado un botón. Comprueba si el email existe. Si este existe le envia de nuevo a la aplicación, por lo contrario le muestra una alerta.
    @IBAction func recoverButton(_ sender: Any) {
        let userRecoverEmail = userEmail.text;
        
        if(userRecoverEmail!.isEmpty)
        {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage: "All fields are required", alertType: 0), animated: true, completion: nil)
            return;
            
        } else {
            if let email = userRecoverEmail {
                if(DataHelpers.isValidEmailFake(email)){
                    sendEmail(email: email)
                    self.segueRecover()
                    self.segueRecover2()
                    self.showSpinner()
                }else{
                    self.present(DataHelpers.displayAlert(userMessage: "Email no corresponde al especificado en MockData", alertType: 0), animated: true, completion: nil)
                }
            }
            else{
                self.present(DataHelpers.displayAlert(userMessage: "Invalid email", alertType: 0), animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    // Función que al cargar la vista añade un evento a un elementos de la vista
    override func viewDidLoad() {
        userEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        super.viewDidLoad()
    }
    
    // Esta función notifica de cuando un textfield ha sido modificado.
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                var errorMessage=""
                switch textfield {
                    
                case userEmail:
                    if(!DataHelpers.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }
                default:
                    errorMessage = ""
                }
                
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
    
    // Función asincrona (FALSA) que envía un correo al destinatario.
    func sendEmail(email:String)  {
        let url = URL(string:"http://0.0.0.0:8888/bienestar/public/api/user/password/reset")
        AF.request(url!,
                   method: .post,
                   parameters:["email": email],
                   encoder: JSONParameterEncoder.default
            
        ).response { response in
            do{
                let responseData:RegisterResponse = RegisterResponse(code: 500)
                if(responseData.code==500) {
                    
                    self.present(DataHelpers.displayAlert(userMessage:"mail sended!", alertType: 1), animated: true, completion: nil)
                    self.removeSpinner()
                }
            }
        }
        
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
    
    // Función donde se hace un dismiss de la vista actual
    func segueRecover()  {
        self.dismiss(animated: true, completion: nil)
    }
    // Función donde se indica hacía donde irá dirigido el permorfSegue
    func segueRecover2()  {
        performSegue(withIdentifier: "recoverSegue", sender: nil)
    }
}

