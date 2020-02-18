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
        

        relojDataEntry.value = 0.25
        relojDataEntry.label = "Reloj"
        instagramDataEntry.value = 110.27
        instagramDataEntry.label = "Instagram"
        facebookDataEntry.value = 89.02
        facebookDataEntry.label = "Facebook"
        whatsappDataEntry.value = 16.47
        whatsappDataEntry.label = "Whatsapp"
        gmailDataEntry.value = 91.95
        gmailDataEntry.label = "Gmail"
        chromeDataEntry.value = 53.95
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
            relojDataEntry.value = 0.25
            relojDataEntry.label = "Reloj"
            instagramDataEntry.value = 110.27
            instagramDataEntry.label = "Instagram"
            facebookDataEntry.value = 89.02
            facebookDataEntry.label = "Facebook"
            whatsappDataEntry.value = 16.47
            whatsappDataEntry.label = "Whatsapp"
            gmailDataEntry.value = 91.95
            gmailDataEntry.label = "Gmail"
            chromeDataEntry.value = 53.95
            chromeDataEntry.label = "Chrome"
            
            usageTimeApps = [relojDataEntry,instagramDataEntry,facebookDataEntry,whatsappDataEntry,gmailDataEntry,chromeDataEntry]
            
            updateChartData()
            break
        case 1:
            relojDataEntry.value = 1.75
            relojDataEntry.label = "Reloj"
            instagramDataEntry.value = 771.89
            instagramDataEntry.label = "Instagram"
            facebookDataEntry.value = 632.14
            facebookDataEntry.label = "Facebook"
            whatsappDataEntry.value = 115.29
            whatsappDataEntry.label = "Whatsapp"
            gmailDataEntry.value = 643.65
            gmailDataEntry.label = "Gmail"
            chromeDataEntry.value = 377.65
            chromeDataEntry.label = "Chrome"
            
            usageTimeApps = [relojDataEntry,instagramDataEntry,facebookDataEntry,whatsappDataEntry,gmailDataEntry,chromeDataEntry]
            
            updateChartData()
            break
        case 2:
            relojDataEntry.value = 7.75
            relojDataEntry.label = "Reloj"
            instagramDataEntry.value = 3418.37
            instagramDataEntry.label = "Instagram"
            facebookDataEntry.value = 2759.62
            facebookDataEntry.label = "Facebook"
            whatsappDataEntry.value = 510.57
            whatsappDataEntry.label = "Whatsapp"
            gmailDataEntry.value = 2850.45
            gmailDataEntry.label = "Gmail"
            chromeDataEntry.value = 1672.45
            chromeDataEntry.label = "Chrome"
            
            usageTimeApps = [relojDataEntry,instagramDataEntry,facebookDataEntry,whatsappDataEntry,gmailDataEntry,chromeDataEntry]
            
            updateChartData()
            break
        default:
            break
        }
    }
}
