//
//  DetailAppViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 13/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import UIKit

class DetailAppViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    public var detailApp:DataModel?
    public var detailImage:UIImageView?
    var appsCSV: [DataModel] = []
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
    
    var appTotalUsage = [String: Double]()
    
    
    
    @IBOutlet weak var imageApp: UIImageView!
    
    @IBOutlet weak var nameApp: UILabel!
    
    @IBOutlet weak var totalTimeApp: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataHelpers.loadFile()
        appsCSV = DataHelpers.parseCsvData()
        
        appDataWraper()
        stringToDate()
        appDateSum()
        
        if let dataModel = detailApp, let image = detailImage {
            setValues(dataModel: dataModel, image: image )
        }
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? DetailTableViewCell
        
        let date = appRelojOpensDate[indexPath.row]
        cell?.totalUsage.text = DataHelpers.toString(date: date)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appRelojOpensDate.count + appRelojClosesDate.count
    }
    
    
    func setValues(dataModel:DataModel, image:UIImageView)
    {
        nameApp.text = dataModel.App
        imageApp.image = image.image
        totalTimeApp.text = dataModel.Date
    }
    
    func dateToSeconds()
    {
        for index in appsCSV {
            let iApp = index.App
            let iDate = index.Date
            let iEvent = index.Event
            print(iApp,iEvent,iDate)
            
            /*let formateador = DateFormatter()
             formateador.dateFormat = "yyyy-MM-dd HH:mm:ss"
             let fechaEnTexto:Date = formateador.date(from: index.Date)!
             print(fechaEnTexto)*/
        }
        
        
    }
    
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
    
    func appDateSum()
    {
        for i in 0...appRelojOpensDate.count-1
        {
            
            print("appRelojOpensDate",i)
            print("appRelojClosesDate",i)
            let closeDate: Date = appRelojOpensDate[i]
            let farDate: Date = appRelojClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeReloj:Double = 0
            totalTimeReloj += timeInterval
            print("Soy total time: ",totalTimeReloj)
            appTotalUsage["Reloj"] = totalTimeReloj
            
        }
        
        
        for i in 0...appInstagramOpensDate.count-1
        {
            
            print("appInstagramOpensDate",i)
            print("appInstagramClosesDate",i)
            let closeDate: Date = appInstagramOpensDate[i]
            let farDate: Date = appInstagramClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeInstagram:Double = 0
            totalTimeInstagram += timeInterval
            print(timeInterval)
            appTotalUsage["Instagram"] = totalTimeInstagram
            
        }
       
        for i in 0...appFacebookOpensDate.count-1
        {
            
            print("appFacebookOpensDate",i)
            print("appFacebookClosesDate",i)
            let closeDate: Date = appFacebookOpensDate[i]
            let farDate: Date = appFacebookClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeFacebook:Double = 0
            totalTimeFacebook += timeInterval
            print(timeInterval)
            appTotalUsage["Facebook"] = totalTimeFacebook
            
        }
        
        for i in 0...appGmailOpensDate.count-1
        {
            
            print("appGmailOpensDate",i)
            print("appGmailClosesDate",i)
            let closeDate: Date = appGmailOpensDate[i]
            let farDate: Date = appGmailClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeGmail:Double = 0
            totalTimeGmail += timeInterval
            print(timeInterval)
            appTotalUsage["Gmail"] = totalTimeGmail
            
        }
        
        for i in 0...appChromeOpensDate.count-1
        {
            
            print("appChromeOpensDate",i)
            print("appChromeClosesDate",i)
            let closeDate: Date = appChromeOpensDate[i]
            let farDate: Date = appChromeClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeChrome:Double = 0
            totalTimeChrome += timeInterval
            print(timeInterval)
            appTotalUsage["Chrome"] = totalTimeChrome
            
        }
        
        for i in 0...appWhatsappOpensDate.count-1
        {
            
            print("appWhatsappOpensDate",i)
            print("appWhatsappClosesDate",i)
            let closeDate: Date = appWhatsappOpensDate[i]
            let farDate: Date = appWhatsappClosesDate[i]
            let timeInterval = farDate.timeIntervalSince(closeDate)
            var totalTimeWhatsapp:Double = 0
            totalTimeWhatsapp += timeInterval
            print(timeInterval)
            appTotalUsage["Whatsapp"] = totalTimeWhatsapp
            
        }
        
        print(appTotalUsage)
    }
    
    
}
