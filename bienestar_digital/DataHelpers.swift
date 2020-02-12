

import Foundation
import UIKit
//Displays an alert with a message depending on the string passed through parameters
class DataHelpers{
    
    static var path: URL? = URL(fileURLWithPath: "/Users/user/Desktop/SergioDAM/bienestar-digital/data.csv" )
    
    
    
    
    static func displayAlert(userMessage:String, alertType: Int)->UIAlertController{
        let alertTitle: String
        
        if (alertType == 0) {
            alertTitle = "There was an error!"
        } else {
            alertTitle = "Nice!"
        }
        
        let alert = UIAlertController(title: alertTitle, message: userMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alert
        //       self.present(alert, animated: true, completion: nil)
        
    }
    
    //
    static func isUsernameValid(_ username: String) -> Bool {
        return true
    }
    
    //
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //
    static func isValidPassword(_ password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: password)
    }
    
    //
    static func isValidRepeatedPassword(_ repeatedPassword: String , _ userPassword : String) -> Bool {
        return userPassword == repeatedPassword
    }
    
        
    static func parseCsvData ()-> [DataModel] {
        var texto:String = " "
        do {
            texto = try String(contentsOf: path!, encoding: .utf8)
            
            print(JSONObjectFromTSV(tsvInputString: texto, columnNames: ["Date","App","Event","Latitude","Longitude"]))
            
        } catch {
            print("Error al leer desde fichero")
        }
           var result: [DataModel] = []
           var rows = texto.components(separatedBy: "\n")
           rows.remove(at:0)
           for row in rows{
               let column = row.components(separatedBy: ",")
            let usage = DataModel(Date: column[0], App: column[1], Event: column[2], Latitude: Double(column[3])!, Longitude: Double(column[4])!)
               result.append(usage)
           }
          
           return result
       }
    
    static func loadFile() {
        do {
            let texto = try String(contentsOf: path!, encoding: .utf8)
            
            print(JSONObjectFromTSV(tsvInputString: texto, columnNames: ["Date","App","Event","Latitude","Longitude"]))
            
        } catch {
            print("Error al leer desde fichero")
        }
        
    }
    
    static func JSONObjectFromTSV(tsvInputString:String, columnNames optionalColumnNames:[String]? = nil) -> Array<NSDictionary>
    {
      let lines = tsvInputString.components(separatedBy: "\n")
      guard lines.isEmpty == false else { return [] }
      
      let columnNames = optionalColumnNames ?? lines[0].components(separatedBy: ",")
      var lineIndex = (optionalColumnNames != nil) ? 0 : 1
      let columnCount = columnNames.count
      var result = Array<NSDictionary>()
      
      for line in lines[lineIndex ..< lines.count] {
        let fieldValues = line.components(separatedBy: ",")
        if fieldValues.count != columnCount {
          //      NSLog("WARNING: header has %u columns but line %u has %u columns. Ignoring this line", columnCount, lineIndex,fieldValues.count)
        }
        else
        {
            result.append(NSDictionary(objects: fieldValues, forKeys: columnNames as [NSCopying]))
        }
        lineIndex = lineIndex + 1
      }
      return result
    }

    
}

