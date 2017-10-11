//
//  TimetableViewController.swift
//  TimetablePrototype02
//
//  Created by Thomas Houghton on 01/10/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TimetableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate { // Add the time checking component so the user can then see what lesson they have got.

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var weeksSegmentControl: UISegmentedControl!
    
    var timetableSlots = [TimetableSlot]()
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"] // Stores the data for the picker view.
    var selectedDay = "Monday" // Holds the current day that the user has selected.
    //var selectedWeek = "WeekA" //  Placeholder for the selected week.
    var selectedSubjet = TimetableSlot()
    var currentDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        populateTimetable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navBar.title = getCurrentDay() // Set the title of the navigation controller.
    }
    
    // Pulling data.
    
    func populateTimetable() {
        let user = Auth.auth().currentUser!.uid
        let currentDay = getCurrentDay()
        Database.database().reference().child("Users").child(user).child("Timetable").child("WeekA").child(currentDay).observe(DataEventType.childAdded) { (snapshot) in
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
            self.tableView.reloadData()
        }
    }
    
    func getCurrentDay() -> String {
        let weekday = Calendar.current.component(.weekday, from: currentDate)
        var currentDay = ""
        print("The current week day is: \(weekday)")
        if (weekday == 2) { // This needs to be fixed, it isnt sending the correct day..
            currentDay = "Monday"
        }else if (weekday == 3) {
            currentDay = "Tuesday"
        }else if (weekday == 4) {
            currentDay = "Wednesday"
        }else if (weekday == 5) {
            currentDay = "Thursday"
        }else if (weekday == 6) {
            currentDay = "Friday"
        }else if (weekday == 7) {
            currentDay = "Saturday"
        }else if (weekday == 8) {
            currentDay = "Sunday"
        }
        return currentDay
    }
    
    // Table View.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timetableSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let retreivedSlot = timetableSlots[indexPath.row]
        let name = retreivedSlot.name
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "SubjectInfoSegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SubjectInfoSegue") {
            let nextVC = segue.destination as! SubjectViewController
            nextVC.subject = timetableSlots[sender as! Int]
        }
    }
    
    // Segment Controller.
    
    @IBAction func weekSegmentControllerChanged(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
