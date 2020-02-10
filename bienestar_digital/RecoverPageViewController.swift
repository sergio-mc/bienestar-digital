import UIKit
import SkyFloatingLabelTextField
import Foundation
import Alamofire
class RecoverPageViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var userEmail: SkyFloatingLabelTextField!
    
    
    
    @IBAction func recoverButton(_ sender: Any) {
        let userRecoverEmail = userEmail.text;
        
        if(userRecoverEmail!.isEmpty)
        {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage: "All fields are required", alertType: 0), animated: true, completion: nil)
            return;
            
        } else {
            if let email = userRecoverEmail {
                if(DataHelpers.isValidEmail(email)){
                    sendEmail(email: email)
                }
            }
            else{
                self.present(DataHelpers.displayAlert(userMessage: "Invalid email", alertType: 0), animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        userEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        super.viewDidLoad()
    }
    
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
    
    func sendEmail(email:String)  {
        let url = URL(string:"http://0.0.0.0:8888/petit-api/public/api/user/password/reset")
        AF.request(url!,
                   method: .post,
                   parameters:["email": email],
                   encoder: JSONParameterEncoder.default
            
        ).response { response in
            do{
                let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                if(responseData.code==200) {
                    
                    self.present(DataHelpers.displayAlert(userMessage:"mail sended!", alertType: 1), animated: true, completion: nil)
                }else{
                    self.present(DataHelpers.displayAlert(userMessage:responseData.errorMsg ?? "", alertType: 0), animated: true, completion: nil)
                }
            }catch{
                print(error)
            }
        }
        
    }
    
}

