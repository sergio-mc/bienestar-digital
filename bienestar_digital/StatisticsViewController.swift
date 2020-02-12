//
//  StatisticsViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 11/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    var path: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        path = URL(fileURLWithPath: "/Users/user/Downloads/data.csv" )
        
        loadFile()
        
    }
    
    func loadFile() {
        do {
            let texto = try String(contentsOf: path!, encoding: .utf8)
            
            print(JSONObjectFromTSV(tsvInputString: texto, columnNames: ["Date","App","Event","Latitude","Longitude"]))
            
            //print(JSONObjectFromTSV(tsvInputString: texto))
            
        } catch {
            print("Error al leer desde fichero")
        }
        
    }
    
    func JSONObjectFromTSV(tsvInputString:String, columnNames optionalColumnNames:[String]? = nil) -> Array<NSDictionary>
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
