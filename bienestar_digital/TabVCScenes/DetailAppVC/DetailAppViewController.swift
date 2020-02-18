//
//  DetailAppViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 13/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import UIKit

class DetailAppViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    
    
    public var detailApp:String?
    public var detailTime:String?
    public var detailImage:UIImageView?
    public var appTotalDate = [Date]()
    var appTotalDatesInString = [String]()
    
    var appsCSV: [DataModel] = []
    
    var appTotalUsage = AppTableViewController.GlobalVariable.appTotalUsage
    
    
    
    @IBOutlet weak var imageApp: UIImageView!
    
    @IBOutlet weak var nameApp: UILabel!
    
    @IBOutlet weak var totalTimeApp: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // Función en la cual nada mas aparecer la vista, cargará el csv convertido y setea los valores correspondientes recibidos del perform segue de la VC anterior
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        DataHelpers.loadFile()
        appsCSV = DataHelpers.parseCsvData()
        
        if let appName = detailApp, let image = detailImage {
            setValues(appName: appName, image: image )
        }
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        DatesToString()
    }
    
    // Función propia de tableView donde se setea el numero de eventos correspondientes de la aplicación.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? DetailTableViewCell
        
        
        cell?.totalUsage.text = appTotalDatesInString[indexPath.row]
        
        
        return cell!
    }
    
    // Función propia de tableView para indicar el numero de lineas.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appTotalDatesInString.count
    }
    
    // Función encargada de setear los valores de los elementos de la vista
    func setValues(appName:String, image:UIImageView)
    {
        nameApp.text = appName
        imageApp.image = image.image
        totalTimeApp.text = "\(detailTime!) minutos"
        
    }
    
    // Función que convierte los Dates en strings
    func DatesToString()
    {
        for i in appTotalDate
        {
            appTotalDatesInString.append(DataHelpers.toString(date: i))
        }
    }
}
