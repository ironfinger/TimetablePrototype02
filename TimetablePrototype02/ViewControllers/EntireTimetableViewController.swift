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

class EntireTimetableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    var timetableSlots = [TimetableSlot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.layer.cornerRadius = 16
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let dateString = sendDate(i: segmentController.selectedSegmentIndex)
        timetableSlots.removeAll()
        pullData(selectedDay: dateString)
    }

    // MARK: - Table View.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timetableSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let currentSubject = timetableSlots[indexPath.row]
        cell.textLabel?.text = currentSubject.name
        return cell
    }
    
    // MARK: - Pull Values From Database.
    func pullData(selectedDay: String) {
        let currentUserUUID = Auth.auth().currentUser!.uid
        Database.database().reference().child("Users").child(currentUserUUID).child("Timetable").child("WeekA").child(selectedDay).observe(DataEventType.childAdded) { (snapshot) in
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
    
    // MARK: - Segment Controller.
    @IBAction func segmentController(_ sender: Any) {
        let selectedDay = sendDate(i: segmentController.selectedSegmentIndex)
        print("Old Count: \(timetableSlots.count)")
        timetableSlots.removeAll()
        print("Everything should have been removed: \(timetableSlots.count)")
        pullData(selectedDay: selectedDay)
        tableview.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
