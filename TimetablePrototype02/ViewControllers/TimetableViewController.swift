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

class TimetableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var timetableSlots = [TimetableSlot]()
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"] // Stores the data for the picker view.
    var selectedDay = "Monday" // Holds the current day that the user has selected.
    var selectedWeek = "WeekA" //  Placeholder for the selected week.
    
    var selectedSubjet = TimetableSlot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        populateTimetable()
    }
    
    func populateTimetable() {
        let user = Auth.auth().currentUser!.uid
        Database.database().reference().child("Users").child(user).child("Timetable").child("Monday").observe(DataEventType.childAdded) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let subject = value?["subject"] as? String ?? ""
            let teacherName = value?["teacherName"] as? String ?? ""
            let roomNum = value?["roomNum"] as? String ?? ""
            let subjectTime = value?["time"] as? String ?? ""
            
            let newSubject = TimetableSlot()
            newSubject.name = subject
            newSubject.teacher = teacherName
            newSubject.room = roomNum
            newSubject.time = subjectTime
            
            self.timetableSlots.append(newSubject)
            self.tableView.reloadData()
        }
    }
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
