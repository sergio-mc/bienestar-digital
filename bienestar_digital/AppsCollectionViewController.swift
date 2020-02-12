//
//  AppsCollectionViewController.swift
//  bienestar_digital
//
//  Created by Sergio on 08/02/2020.
//  Copyright © 2020 sergio-mc. All rights reserved.
//

import UIKit
import HGCircularSlider

class AppsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    let apps = ["instagram","whatsapp","facebook","chrome","gmail","reloj"]
    
    @IBOutlet weak var minutesCircularSlider: CircularSlider!
    
    @IBOutlet weak var hoursCircularSlider: CircularSlider!
    
    
    @IBOutlet weak var AMPMLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    @IBOutlet weak var selectedApp: UIImageView!
    
    @IBOutlet weak var appCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appCV.dataSource = self
        self.appCV.delegate = self
        
        setupSliders()
        
        
        
        DataHelpers.loadFile()
        print(DataHelpers.parseCsvData())
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.appCV.dequeueReusableCell(withReuseIdentifier: "AppCell", for: indexPath) as! AppsCollectionViewControllerCell
        
        let imagen = apps[indexPath.item]
        cell.appImage.image = UIImage.init(imageLiteralResourceName: imagen)
        return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = apps[indexPath.row]
        selectedApp.image = UIImage.init(imageLiteralResourceName: selectedImage)
    }
    
    
    func setupSliders() {
        // hours
        hoursCircularSlider.minimumValue = 0
        hoursCircularSlider.maximumValue = 12
        hoursCircularSlider.endPointValue = 6
        hoursCircularSlider.addTarget(self, action: #selector(updateHours), for: .valueChanged)
        hoursCircularSlider.addTarget(self, action: #selector(adjustHours), for: .editingDidEnd)
        
        // minutes
        minutesCircularSlider.minimumValue = 0
        minutesCircularSlider.maximumValue = 60
        minutesCircularSlider.endPointValue = 35
        minutesCircularSlider.addTarget(self, action: #selector(updateMinutes), for: .valueChanged)
        minutesCircularSlider.addTarget(self, action: #selector(adjustMinutes), for: .editingDidEnd)
    }
    
    // MARK: user interaction methods
    
    @objc func updateHours() {
        var selectedHour = Int(hoursCircularSlider.endPointValue)
        // TODO: use date formatter
        selectedHour = (selectedHour == 0 ? 12 : selectedHour)
        hoursLabel.text = String(format: "%02d", selectedHour)
    }
    
    @objc func adjustHours() {
        let selectedHour = round(hoursCircularSlider.endPointValue)
        hoursCircularSlider.endPointValue = selectedHour
        updateHours()
    }
    
    @objc func updateMinutes() {
        var selectedMinute = Int(minutesCircularSlider.endPointValue)
        // TODO: use date formatter
        selectedMinute = (selectedMinute == 60 ? 0 : selectedMinute)
        minutesLabel.text = String(format: "%02d", selectedMinute)
    }
    
    @objc func adjustMinutes() {
        let selectedMinute = round(minutesCircularSlider.endPointValue)
        minutesCircularSlider.endPointValue = selectedMinute
        updateMinutes()
    }

    @IBAction func switchBetweenAMAndPM(_ sender: UISegmentedControl) {
        AMPMLabel.text = sender.selectedSegmentIndex == 0 ? "AM" : "PM"
    }
    
    
}
