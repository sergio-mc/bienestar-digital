//
//  AppsCollectionViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 08/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import UIKit
import HGCircularSlider
import Alamofire

class AppsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    let apps = ["Instagram","Whatsapp","Facebook","Chrome","Gmail","Reloj"]
    
    var appsCSV: [DataModel] = []
    
    
    
    @IBOutlet weak var minutesCircularSlider: CircularSlider!
    @IBOutlet weak var minutesCircularSlider2: CircularSlider!
    
    @IBOutlet weak var hoursCircularSlider: CircularSlider!
    @IBOutlet weak var hoursCircularSlider2: CircularSlider!
    
    
    @IBOutlet weak var selectorReference: UISegmentedControl!
    
    
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var minutesLabel2: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var hoursLabel2: UILabel!
    
    @IBOutlet weak var selectedApp: UIImageView!
    var selectedImage:String? = "Instagram"
    
    @IBOutlet weak var appCV: UICollectionView!
    @IBOutlet weak var dots: UILabel!
    @IBOutlet weak var clockView: UIView!
    
    
    // Función que dependiendo del index del selector oculta los relojes o los muestra.
    @IBAction func selectorChange(_ sender: Any) {
        switch selectorReference.selectedSegmentIndex {
        case 0:
            clockView.isHidden = true
            break
        case 1:
            clockView.isHidden = false
            break
        default:
            clockView.isHidden = true
        }
    }
    
    // Función que envía los datos correspondientes dependiendo de el index del selector.
    @IBAction func saveChanges(_ sender: Any) {
        switch selectorReference.selectedSegmentIndex {
        case 0:
            self.sendData(time: "App: \(selectedImage!) Tiempo diario establecido: \(hoursLabel.text!):\(minutesLabel.text!)")
            break
        case 1:
            if let horasInt = Int(hoursLabel.text!),let horas2Int = Int(hoursLabel2.text!),let minutosInt = Int(minutesLabel.text!),let minutos2Int = Int(minutesLabel2.text!) {
                if(horasInt < horas2Int){
                    
                    self.sendData(time: "App: \(selectedImage!) Tiempo franja establecido desde: \(hoursLabel.text!):\(minutesLabel.text!), hasta: \(hoursLabel2.text!):\(minutesLabel2.text!)")
                }else if(horasInt == horas2Int && minutosInt < minutos2Int){
                    self.sendData(time: "App: \(selectedImage!) Tiempo franja establecido desde: \(hoursLabel.text!):\(minutesLabel.text!), hasta: \(hoursLabel2.text!):\(minutesLabel2.text!)")
                }else{
                    self.present(DataHelpers.displayAlert(userMessage:"Tiempo del segundo reloj es menor que el primer reloj, no se ha podido crear franja.", alertType: 0), animated: true, completion: nil)
                }
            }
            
            break
        default:
            break
        }
    }
    
    // Función donde se carga el csv convertido y se define los delegates y datasource del collectionView.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appCV.dataSource = self
        self.appCV.delegate = self
        
        setupSliders()
        DataHelpers.loadFile()
        appsCSV = DataHelpers.parseCsvData()
        selectedApp.image = UIImage.init(imageLiteralResourceName: selectedImage!)
    }
    
    // Función propia del collectionView para indicar el numero de elementos por sección.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    // Función propia del collectionView donde se setean las propiedades de cada app en el numero de celdas.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.appCV.dequeueReusableCell(withReuseIdentifier: "AppCell", for: indexPath) as! AppsCollectionViewControllerCell
        
        let imagen = apps[indexPath.item]
        cell.appImage.image = UIImage.init(imageLiteralResourceName: imagen)
        return cell
    }
    
    // Función propia del collectionView donde se identifica que celda se ha seleccionado y se setean las propiedades de este en otros elementos.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = apps[indexPath.row]
        selectedApp.image = UIImage.init(imageLiteralResourceName: selectedImage!)
    }
    
    // Función de la configuración de los relojes.
    func setupSliders() {
        // hours
        hoursCircularSlider.minimumValue = 0
        hoursCircularSlider.maximumValue = 23
        hoursCircularSlider.endPointValue = 6
        hoursCircularSlider.addTarget(self, action: #selector(updateHours), for: .valueChanged)
        hoursCircularSlider.addTarget(self, action: #selector(adjustHours), for: .editingDidEnd)
        
        // minutes
        minutesCircularSlider.minimumValue = 0
        minutesCircularSlider.maximumValue = 60
        minutesCircularSlider.endPointValue = 35
        minutesCircularSlider.addTarget(self, action: #selector(updateMinutes), for: .valueChanged)
        minutesCircularSlider.addTarget(self, action: #selector(adjustMinutes), for: .editingDidEnd)
        
        hoursCircularSlider2.minimumValue = 0
        hoursCircularSlider2.maximumValue = 23
        hoursCircularSlider2.endPointValue = 6
        hoursCircularSlider2.addTarget(self, action: #selector(updateHours2), for: .valueChanged)
        hoursCircularSlider2.addTarget(self, action: #selector(adjustHours2), for: .editingDidEnd)
        
        // minutes
        minutesCircularSlider2.minimumValue = 0
        minutesCircularSlider2.maximumValue = 60
        minutesCircularSlider2.endPointValue = 35
        minutesCircularSlider2.addTarget(self, action: #selector(updateMinutes2), for: .valueChanged)
        minutesCircularSlider2.addTarget(self, action: #selector(adjustMinutes2), for: .editingDidEnd)
    }
    
    // MARK: user interaction methods
    // Función que actualiza las horas del primer reloj cuando el usuario interactua con el.
    @objc func updateHours() {
        var selectedHour = Int(hoursCircularSlider.endPointValue)
        // TODO: use date formatter
        selectedHour = (selectedHour == 0 ? 12 : selectedHour)
        hoursLabel.text = String(format: "%02d", selectedHour)
    }
    
    // Función que actualiza las horas del segundo reloj cuando el usuario interactua con el.
    @objc func updateHours2() {
        var selectedHour = Int(hoursCircularSlider2.endPointValue)
        // TODO: use date formatter
        selectedHour = (selectedHour == 0 ? 12 : selectedHour)
        hoursLabel2.text = String(format: "%02d", selectedHour)
    }
    
    // Función que ajusta las horas del primer reloj
    @objc func adjustHours() {
        let selectedHour = round(hoursCircularSlider.endPointValue)
        hoursCircularSlider.endPointValue = selectedHour
        updateHours()
    }
    // Función que ajusta las horas del primer reloj
    @objc func adjustHours2() {
        let selectedHour = round(hoursCircularSlider2.endPointValue)
        hoursCircularSlider2.endPointValue = selectedHour
        updateHours()
    }
    
    // Función que actualiza los minutos del primer reloj cuando el usuario interactua con el.
    @objc func updateMinutes() {
        var selectedMinute = Int(minutesCircularSlider.endPointValue)
        // TODO: use date formatter
        selectedMinute = (selectedMinute == 60 ? 0 : selectedMinute)
        minutesLabel.text = String(format: "%02d", selectedMinute)
    }
    // Función que actualiza los minutos del segundo reloj cuando el usuario interactua con el.
    @objc func updateMinutes2() {
        var selectedMinute = Int(minutesCircularSlider2.endPointValue)
        // TODO: use date formatter
        selectedMinute = (selectedMinute == 60 ? 0 : selectedMinute)
        minutesLabel2.text = String(format: "%02d", selectedMinute)
    }
    
    // Función que ajusta los minutos del primer reloj
    @objc func adjustMinutes() {
        let selectedMinute = round(minutesCircularSlider.endPointValue)
        minutesCircularSlider.endPointValue = selectedMinute
        updateMinutes()
    }
    // Función que ajusta los minutos del segundo reloj
    @objc func adjustMinutes2() {
        let selectedMinute = round(minutesCircularSlider2.endPointValue)
        minutesCircularSlider2.endPointValue = selectedMinute
        updateMinutes()
    }
    
    // Función que hace una petición tipo post (FALSA) donde se mandan los datos de los tiempos obtenidos en los relojes
    func sendData(time:String)  {
        let url = URL(string:"http://0.0.0.0:8888/bienestar/public/api/")
        
        
        AF.request(url!,
                   method: .post,
                   parameters:time,
                   encoder: JSONParameterEncoder.default
            
        ).response { response in
            do{
                let responseData:RegisterResponse = RegisterResponse(code: 500)
                if(responseData.code==500) {
                    print(time)
                    self.present(DataHelpers.displayAlert(userMessage:"Restringido!", alertType: 1), animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    
    
}
