//
//  StatisticsViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 11/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {
    @IBOutlet weak var graphic: PieChartView!
    
    @IBOutlet weak var rangeSelector: UISegmentedControl!
    
    var relojDataEntry = PieChartDataEntry(value: 0)
    var instagramDataEntry = PieChartDataEntry(value: 0)
    var facebookDataEntry = PieChartDataEntry(value: 0)
    var whatsappDataEntry = PieChartDataEntry(value: 0)
    var gmailDataEntry = PieChartDataEntry(value: 0)
    var chromeDataEntry = PieChartDataEntry(value: 0)
    
    var usageTimeApps = [PieChartDataEntry]()
    
    
    // Función que al cargar la vista setea unos valores default de la gráfica de estadísticas.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphic.chartDescription?.text = ""
        

        relojDataEntry.value = 0.17
        relojDataEntry.label = "Reloj"
        instagramDataEntry.value = 0.36
        instagramDataEntry.label = "Instagram"
        facebookDataEntry.value = 0.33
        facebookDataEntry.label = "Facebook"
        whatsappDataEntry.value = 0.7
        whatsappDataEntry.label = "Whatsapp"
        gmailDataEntry.value = 0.31
        gmailDataEntry.label = "Gmail"
        chromeDataEntry.value = 0.11
        chromeDataEntry.label = "Chrome"
        
        usageTimeApps = [relojDataEntry,instagramDataEntry,facebookDataEntry,whatsappDataEntry,gmailDataEntry,chromeDataEntry]
        
        updateChartData()
        
        
    }
    
    // Función encargada de actualizar los datos de la gráfica de estadísticas
    func updateChartData()
    {
        let chartDataSet = PieChartDataSet(entries: usageTimeApps, label:nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.init(red: 128/255, green: 115/255, blue: 255/255, alpha: 1),UIColor.init(red: 104/255, green: 126/255, blue: 232/255, alpha: 1),UIColor.init(red: 128/255, green: 183/255, blue: 255/255, alpha: 1),UIColor.init(red: 128/255, green: 193/255, blue: 232/255, alpha: 1),UIColor.init(red: 104/255, green: 249/255, blue: 255/255, alpha: 1),UIColor.init(red: 178/255, green: 249/255, blue: 255/255, alpha: 1)]
        
        chartDataSet.colors = colors
        chartDataSet.valueTextColor = UIColor.black
        
        
        graphic.data = chartData
        graphic.holeColor = UIColor.clear
        graphic.legend.textColor = UIColor.white
        
    
        
    }
    
    // Función encargada de setear los datos (FALSOS) en la gráfica de estadísticas dependiendo del index del selector.
    @IBAction func rangeChange(_ sender: Any) {
        switch rangeSelector.selectedSegmentIndex {
        case 0:
            relojDataEntry.value = 0.17
            relojDataEntry.label = "Reloj"
            instagramDataEntry.value = 0.36
            instagramDataEntry.label = "Instagram"
            facebookDataEntry.value = 0.33
            facebookDataEntry.label = "Facebook"
            whatsappDataEntry.value = 0.7
            whatsappDataEntry.label = "Whatsapp"
            gmailDataEntry.value = 0.31
            gmailDataEntry.label = "Gmail"
            chromeDataEntry.value = 0.11
            chromeDataEntry.label = "Chrome"
            
            usageTimeApps = [relojDataEntry,instagramDataEntry,facebookDataEntry,whatsappDataEntry,gmailDataEntry,chromeDataEntry]
            
            updateChartData()
            break
        case 1:
            relojDataEntry.value = 0.47
            relojDataEntry.label = "Reloj"
            instagramDataEntry.value = 0.76
            instagramDataEntry.label = "Instagram"
            facebookDataEntry.value = 0.73
            facebookDataEntry.label = "Facebook"
            whatsappDataEntry.value = 1.3
            whatsappDataEntry.label = "Whatsapp"
            gmailDataEntry.value = 0.71
            gmailDataEntry.label = "Gmail"
            chromeDataEntry.value = 0.51
            chromeDataEntry.label = "Chrome"
            
            usageTimeApps = [relojDataEntry,instagramDataEntry,facebookDataEntry,whatsappDataEntry,gmailDataEntry,chromeDataEntry]
            
            updateChartData()
            break
        case 2:
            relojDataEntry.value = 10.47
            relojDataEntry.label = "Reloj"
            instagramDataEntry.value = 14.76
            instagramDataEntry.label = "Instagram"
            facebookDataEntry.value = 15.73
            facebookDataEntry.label = "Facebook"
            whatsappDataEntry.value = 40.3
            whatsappDataEntry.label = "Whatsapp"
            gmailDataEntry.value = 7.71
            gmailDataEntry.label = "Gmail"
            chromeDataEntry.value = 38.51
            chromeDataEntry.label = "Chrome"
            
            usageTimeApps = [relojDataEntry,instagramDataEntry,facebookDataEntry,whatsappDataEntry,gmailDataEntry,chromeDataEntry]
            
            updateChartData()
            break
        default:
            break
        }
    }
}
