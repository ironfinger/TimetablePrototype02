//
//  SubjectViewController.swift
//  TimetablePrototype02
//
//  Created by Thomas Houghton on 03/10/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var actualTimeLabel: UILabel!
    
    var subject = TimetableSlot()
    
    // Date Time
    let currentDate = Date() // Gets the current date.
    let dateFormatter = DateFormatter() // Gets the date formatter.
    
    // Timer
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displaySubject()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        displayTime() // Displays the current user time.
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            
        }
    }

    func displaySubject() {
        nameLabel.text = subject.name // This is to make sure that the subject name is assigned to the name label.
        teacherLabel.text = subject.teacher // This is to make sure that the teacher name is assigned to the teacher label.
        roomLabel.text = subject.room
        timeLabel.text = subject.time
    }
    
    func displayTime() {
        dateFormatter.dateFormat = "HH:mm"
        var convertedDate = dateFormatter.string(from: currentDate)
        actualTimeLabel.text = convertedDate
        
        //var counter = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
            var refreshedDate = Date()
            convertedDate = self.dateFormatter.string(from: refreshedDate) // Refreshes the converted date string each half a second.
            self.actualTimeLabel.text = convertedDate // This then displays the refreshed date into the time label.
            
            if (convertedDate == "22:45") {
                print("22:43") // This prints if the converted date is equal to the time I selected, this is to test to see if the checking time component will work.
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
