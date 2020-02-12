//
//  CSVManager.swift
//  bienestar_digital
//
//  Created by Sergio on 11/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import Foundation
import UIKit

var dataModel = [DataModel]()

class CSVManager: UIViewController {


func parseDataCSV()-> [DataModel]{

    let path = Bundle.main.path(forResource: "usage", ofType: "csv")!

    do{

        let csv = try CSV(contentsOfURL: path)
        let rows = csv.rows
        for row in rows {
            let date = row["Date"]!
            let app = row["App"]!
            let event = row["Event"]!
            let latitude = row["Latitude"]!
            let longitude = row["Longitude"]!
            let dataParse = DataModel(Date: date, App: app, Event: event, Latitude: latitude, Longitude: longitude)
            dataModel.append(dataParse)

            

            // createAppData(dataModel: dataParse)

            

        }

        

        

    }

        

   

    catch let err as NSError {

        

        print(err.debugDescription)

        

    }



    return dataModel



}

}
