//
//  LoginSelectViewController.swift
//  TimetablePrototype02
//
//  Created by Thomas Houghton on 01/11/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit

class LoginSelectViewController: UIViewController {

    @IBOutlet weak var SignUpSelectBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func viewSetup() {
        SignUpSelectBtn.layer.cornerRadius = 10
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
