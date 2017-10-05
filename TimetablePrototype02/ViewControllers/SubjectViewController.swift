//
//  SubjectViewController.swift
//  TimetablePrototype02
//
//  Created by Thomas Houghton on 03/10/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var subject = TimetableSlot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displaySubject()
    }

    func displaySubject() {
        nameLabel.text = subject.name // This is to make sure that the subject name is assigned to the name label.
        teacherLabel.text = subject.teacher // This is to make sure that the teacher name is assigned to the teacher label.
        roomLabel.text = subject.room
        timeLabel.text = subject.time
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
