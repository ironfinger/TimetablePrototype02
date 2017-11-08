//
//  EntireTimetableViewController.swift
//  TimetablePrototype02
//
//  Created by Thomas Houghton on 12/10/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import CoreData

class EntireTimetableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var weekSegmentControl: UISegmentedControl!
    
    var timetableSlots = [TimetableSlot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.delegate = self
        tableview.layer.cornerRadius = 16
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default) // Removes the shadow line underneath the navigation view.
        self.navigationController?.navigationBar.shadowImage = UIImage() // This sets the shadow image.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let dateString = sendDate(i: segmentController.selectedSegmentIndex)
        timetableSlots.removeAll()
        pullData(selectedDay: dateString, selectedWeek: sendWeek())
    }

    // MARK: - Table View.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timetableSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        // MARK: - Cell.
        /*
        cell.mainBackground.layer.cornerRadius = 8
        cell.mainBackground.layer.masksToBounds = true
        
        cell.shadowLayer.layer.masksToBounds = false
        cell.shadowLayer.layer.shadowOffset = CGSizeMake(0, 0)
        cell.shadowLayer.layer.shadowColor = UIColor.blackColor().CGColor
        cell.shadowLayer.layer.shadowOpacity = 0.23
        cell.shadowLayer.layer.shadowRadius = 4
        */
        
        /*
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        */
        let currentSubject = timetableSlots[indexPath.row]
        cell.textLabel?.text = currentSubject.name
        return cell
    }
    
    // MARK: - Pull Values From Database.
    func pullData(selectedDay: String, selectedWeek: String) {
        let currentUserUUID = Auth.auth().currentUser!.uid
        let selectedWeek = sendWeek()
        Database.database().reference().child("Users").child(currentUserUUID).child("Timetable").child(selectedWeek).child(selectedDay).observe(DataEventType.childAdded) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let subject = value?["subject"] as? String ?? ""
            let teacherName = value?["teacherName"] as? String ?? ""
            let roomNum = value?["roomNum"] as? String ?? ""
            let subjectTime = value?["time"] as? String ?? ""
            let subjectDay = value?["day"] as? String ?? ""
            
            let newSubject = TimetableSlot()
            newSubject.name = subject
            newSubject.teacher = teacherName
            newSubject.room = roomNum
            newSubject.time = subjectTime
            newSubject.day = subjectDay
            
            self.timetableSlots.append(newSubject)
            self.tableview.reloadData()
        }
    }
    
    // MARK: - Fit array when the contents didn't change.
    func checkArrayData() {
        let emptyArrayPlaceholder = TimetableSlot() // This is used to force the table view to display timetable is empty when there isn't any data for that week day.
        emptyArrayPlaceholder.name = "Timetable is empty"
        timetableSlots.append(emptyArrayPlaceholder)
    }
    
    // MARK: - Figure out selected date
    func sendDate(i:Int) -> String {
        var rtn = ""
        if (i == 0) {
            rtn = "Monday"
        }else if (i == 1) {
            rtn = "Tuesday"
        }else if (i == 2) {
            rtn = "Wednesday"
        }else if (i == 3) {
            rtn = "Thursday"
        }else if (i == 4) {
            rtn = "Friday"
        }else if (i == 5) {
            rtn = "Saturday"
        }else if (i == 6) {
            rtn = "Sunday"
        }
        return rtn
    }
    
    // MARK: - Figure out selected week.
    func sendWeek() -> String {
        var returnValue = ""
        if (weekSegmentControl.selectedSegmentIndex == 0) {
            returnValue = "WeekA"
        }else if (weekSegmentControl.selectedSegmentIndex == 1) {
            returnValue = "WeekB"
        }
        return returnValue
    }
    
    // MARK: - Segment Controller.
    @IBAction func segmentController(_ sender: Any) {
        let selectedDay = sendDate(i: segmentController.selectedSegmentIndex)
        timetableSlots.removeAll()
        pullData(selectedDay: selectedDay, selectedWeek: sendWeek())
        tableview.reloadData()
    }
    
    // MARK: - Week Segment Controller.
    @IBAction func weekSegmentContollerTapped(_ sender: Any) {
        timetableSlots.removeAll()
        tableview.reloadData()
        let selectedDay = sendDate(i: segmentController.selectedSegmentIndex)
        pullData(selectedDay: selectedDay, selectedWeek: sendWeek())
        print("Count before hand \(timetableSlots.count)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
