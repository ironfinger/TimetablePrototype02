//
//  SelectedSettingViewController.swift
//  TimetablePrototype02
//
//  Created by Thomas Houghton on 07/10/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class SelectedSettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var settingTitleLabel: UILabel!
    @IBOutlet weak var settingInfoLabel: UILabel!
    @IBOutlet weak var settingPickerView: UIPickerView!
    
    var selectedSetting = ""
    
    let daysOfweek = ["Monday", "Tuesday", "Wednesday", "Thurday", "Friday", "Saturday", "Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settingPickerView.dataSource = self
        settingPickerView.delegate = self
        
        if (selectedSetting == "Clear") {
            clear()
        }
    }
    
    func clear() {
        
    }
    
    // Picker View.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysOfweek.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return daysOfweek[row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
