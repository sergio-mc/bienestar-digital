//
//  AppTableViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 29/01/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import UIKit

class AppTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let apps = ["Instagram","Whatsapp","Facebook","Chrome","Gmail","Reloj"]
    
    var appsCSV: [DataModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    
    var appRelojOpens = [DataModel]()
    var appRelojCloses = [DataModel]()
    var appInstagramOpens = [DataModel]()
    var appInstagramCloses = [DataModel]()
    var appWhatsappOpens = [DataModel]()
    var appWhatsappCloses = [DataModel]()
    var appFacebookOpens = [DataModel]()
    var appFacebookCloses = [DataModel]()
    var appGmailOpens = [DataModel]()
    var appGmailCloses = [DataModel]()
    var appChromeOpens = [DataModel]()
    var appChromeCloses = [DataModel]()
    
    var appRelojOpensDate = [Date]()
    var appRelojClosesDate = [Date]()
    var appInstagramOpensDate = [Date]()
    var appInstagramClosesDate = [Date]()
    var appWhatsappOpensDate = [Date]()
    var appWhatsappClosesDate = [Date]()
    var appFacebookOpensDate = [Date]()
    var appFacebookClosesDate = [Date]()
    var appGmailOpensDate = [Date]()
    var appGmailClosesDate = [Date]()
    var appChromeOpensDate = [Date]()
    var appChromeClosesDate = [Date]()
    
    var secToMinReloj:String = ""
    var secToMinInstagram:String = ""
    var secToMinWhatsapp:String = ""
    var secToMinGmail:String = ""
    var secToMinFacebook:String = ""
    var secToMinChrome:String = ""
    
    
    
    // Variable global para poder acceder a ella desde los distintos Controllers
    struct GlobalVariable{
        static var appTotalUsage = [String: Double]()
    }
    
    
    override func viewDidLoad() {
        DataHelpers.loadFile()
        
        appsCSV = DataHelpers.parseCsvData()
        appDataWraper()
        stringToDate()
        appDateSum()
    }
    
    
    // Función propia del tableView donde se hace un set de cada propiedad de las app.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = appTableView.dequeueReusableCell(withIdentifier: "AppCell") as? AppTableViewCell
        
        let imagen = apps[indexPath.item]
        cell?.appImage.image = UIImage.init(imageLiteralResourceName: imagen)
        
        let appName = apps[indexPath.row]
        cell?.appName.text = appName
        
        
        for (key,value) in AppTableViewController.GlobalVariable.appTotalUsage
        {
            switch appName {
            case "Reloj":
                if(key == "Reloj")
                {
                    secToMinReloj = String(format: "%.2f",(DataHelpers.secToMin(seconds: value)))
                    cell?.appTodayTime.text = "Uso de hoy: " + secToMinReloj + " minutos"
                    
                }
                break
            case "Instagram":
                if(key == "Instagram")
                {
                    secToMinInstagram = String(format: "%.2f",(DataHelpers.secToMin(seconds: value)))
                    cell?.appTodayTime.text = "Uso de hoy: " + secToMinInstagram + " minutos"
                }
                break
            case "Whatsapp":
                if(key == "Whatsapp")
                {
                    secToMinWhatsapp = String(format: "%.2f",(DataHelpers.secToMin(seconds: value)))
                    cell?.appTodayTime.text = "Uso de hoy: " + secToMinWhatsapp + " minutos"
                }
                break
            case "Facebook":
                if(key == "Facebook")
                {
                    secToMinFacebook = String(format: "%.2f",(DataHelpers.secToMin(seconds: value)))
                    cell?.appTodayTime.text = "Uso de hoy: " + secToMinFacebook + " minutos"
                }
                break
            case "Gmail":
                if(key == "Gmail")
                {
                    secToMinGmail = String(format: "%.2f",(DataHelpers.secToMin(seconds: value)))
                    cell?.appTodayTime.text = "Uso de hoy: " + secToMinGmail + " minutos"
                }
                break
            case "Chrome":
                if(key == "Chrome")
                {
                    secToMinChrome = String(format: "%.2f",(DataHelpers.secToMin(seconds: value)))
                    cell?.appTodayTime.text = "Uso de hoy: " + secToMinChrome + " minutos"
                }
                break
                
            default:
                break
            }
        }
        
        
        
        return cell!
    }
    
    // Función propia de tableView para indiciar el numero de lineas.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    
    
    
    @IBOutlet weak var appTableView: UITableView!
    
    // Función en la cual se setea la bar de navigationController a hidden
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // Función para enviar los datos a DetailAppViewController en la cual dependiendo de la app seleccionada enviará unos datos u otros.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = (sender as? AppTableViewCell)
        let indexPath = self.tableView.indexPath(for: item!)
        let cell = tableView.cellForRow(at: indexPath!) as? AppTableViewCell
        let selectedApp=apps[indexPath?.row ?? 0]
        let detailPetView = segue.destination as! DetailAppViewController
        detailPetView.detailApp = selectedApp
        detailPetView.detailImage=cell?.appImage
        switch selectedApp {
        case "Reloj":
            detailPetView.detailTime = secToMinReloj
            detailPetView.appTotalDate = appRelojOpensDate + appRelojClosesDate
            break
        case "Instagram":
            detailPetView.detailTime = secToMinInstagram
            detailPetView.appTotalDate = appInstagramOpensDate + appInstagramClosesDate
            break
        case "Whatsapp":
            detailPetView.detailTime = secToMinWhatsapp
           detailPetView.appTotalDate = appWhatsappOpensDate + appWhatsappClosesDate
            break
        case "Facebook":
            detailPetView.detailTime = secToMinFacebook
            detailPetView.appTotalDate = appFacebookOpensDate + appFacebookOpensDate
            break
        case "Gmail":
            detailPetView.detailTime = secToMinGmail
           detailPetView.appTotalDate = appGmailOpensDate + appGmailClosesDate
            break
        case "Chrome":
            detailPetView.detailTime = secToMinChrome
            detailPetView.appTotalDate = appChromeOpensDate + appChromeClosesDate
            break
            
        default:
            break
        }
    }
    
    // Función que almacenara cada app del csv en arrays distintos dependiendo de sus eventos.
    func appDataWraper()
    {
        for i in appsCSV
        {
            
            switch i.App {
            case "Reloj":
                if(i.Event == "opens")
                {
                    appRelojOpens.append(i)
                    
                }else if(i.Event == "closes")
                {
                    appRelojCloses.append(i)
                    
                }
                break
            case "Instagram":
                if(i.Event == "opens")
                {
                    appInstagramOpens.append(i)
                    
                }else if(i.Event == "closes")
                {
                    appInstagramCloses.append(i)
                }
                break
            case "Whatsapp":
                if(i.Event == "opens")
                {
                    appWhatsappOpens.append(i)
                }else if(i.Event == "closes")
                {
                    appWhatsappCloses.append(i)
                }
                break
            case "Facebook":
                if(i.Event == "opens")
                {
                    appFacebookOpens.append(i)
                }else if(i.Event == "closes")
                {
                    appFacebookCloses.append(i)
                }
                break
            case "Gmail":
                if(i.Event == "opens")
                {
                    appGmailOpens.append(i)
                }else if(i.Event == "closes")
                {
                    appGmailCloses.append(i)
                }
                break
            case "Chrome":
                if(i.Event == "opens")
                {
                    appChromeOpens.append(i)
                }else if(i.Event == "closes")
                {
                    appChromeCloses.append(i)
                }
                break
                
            default:
                break
            }
        }
    }
    
    // Función que convierte los strings en un date de un formato en concreto
    func stringToDate()
    {
        let formateador = DateFormatter()
        formateador.dateFormat = "yyyy-MM-dd HH:mm:ss"
        for i in appRelojOpens
        {
            let appRelojOpen = formateador.date(from: i.Date)
            appRelojOpensDate.append(appRelojOpen!)
        }
        for i in appRelojCloses
        {
            let appRelojClose = formateador.date(from: i.Date)
            appRelojClosesDate.append(appRelojClose!)
        }
        for i in appInstagramOpens
        {
            let appInstagramOpen = formateador.date(from: i.Date)
            appInstagramOpensDate.append(appInstagramOpen!)
        }
        for i in appInstagramCloses
        {
            let appInstagramClose = formateador.date(from: i.Date)
            appInstagramClosesDate.append(appInstagramClose!)
        }
        for i in appWhatsappOpens
        {
            let appWhatsappOpen = formateador.date(from: i.Date)
            appWhatsappOpensDate.append(appWhatsappOpen!)
        }
        for i in appWhatsappCloses
        {
            let appWhatsappClose = formateador.date(from: i.Date)
            appWhatsappClosesDate.append(appWhatsappClose!)
        }
        for i in appGmailOpens
        {
            let appGmailOpen = formateador.date(from: i.Date)
            appGmailOpensDate.append(appGmailOpen!)
        }
        for i in appGmailCloses
        {
            let appGmailClose = formateador.date(from: i.Date)
            appGmailClosesDate.append(appGmailClose!)
        }
        for i in appFacebookOpens
        {
            let appFacebookOpen = formateador.date(from: i.Date)
            appFacebookOpensDate.append(appFacebookOpen!)
        }
        for i in appFacebookCloses
        {
            let appFacebookClose = formateador.date(from: i.Date)
            appFacebookClosesDate.append(appFacebookClose!)
        }
        for i in appChromeOpens
        {
            let appChromeOpen = formateador.date(from: i.Date)
            appChromeOpensDate.append(appChromeOpen!)
        }
        for i in appChromeCloses
        {
            let appChromeClose = formateador.date(from: i.Date)
            appChromeClosesDate.append(appChromeClose!)
        }
        
        
    }
    
    // Función que hace el sumatorio del intervalo entre cuando una aplicación se abre y su próximo cierre.
    func appDateSum()
    {
        for i in 0...appRelojOpensDate.count-1
        {
            let closeDate: Date = appRelojOpensDate[i]
            let farDate: Date = appRelojClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeReloj:Double = 0
            totalTimeReloj += timeInterval
            AppTableViewController.GlobalVariable.appTotalUsage["Reloj"] = totalTimeReloj
            
        }
        
        
        for i in 0...appInstagramOpensDate.count-1
        {
            let closeDate: Date = appInstagramOpensDate[i]
            let farDate: Date = appInstagramClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeInstagram:Double = 0
            totalTimeInstagram += timeInterval
            AppTableViewController.GlobalVariable.appTotalUsage["Instagram"] = totalTimeInstagram
            
        }
        
        for i in 0...appFacebookOpensDate.count-1
        {
            let closeDate: Date = appFacebookOpensDate[i]
            let farDate: Date = appFacebookClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeFacebook:Double = 0
            totalTimeFacebook += timeInterval
            AppTableViewController.GlobalVariable.appTotalUsage["Facebook"] = totalTimeFacebook
            
        }
        
        for i in 0...appGmailOpensDate.count-1
        {
            let closeDate: Date = appGmailOpensDate[i]
            let farDate: Date = appGmailClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeGmail:Double = 0
            totalTimeGmail += timeInterval
            AppTableViewController.GlobalVariable.appTotalUsage["Gmail"] = totalTimeGmail
            
        }
        
        for i in 0...appChromeOpensDate.count-1
        {
            let closeDate: Date = appChromeOpensDate[i]
            let farDate: Date = appChromeClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeChrome:Double = 0
            totalTimeChrome += timeInterval
            AppTableViewController.GlobalVariable.appTotalUsage["Chrome"] = totalTimeChrome
            
        }
        
        for i in 0...appWhatsappOpensDate.count-1
        {
            let closeDate: Date = appWhatsappOpensDate[i]
            let farDate: Date = appWhatsappClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeWhatsapp:Double = 0
            totalTimeWhatsapp += timeInterval
            AppTableViewController.GlobalVariable.appTotalUsage["Whatsapp"] = totalTimeWhatsapp
            
        }
    }
    
    
    
    
    
}
