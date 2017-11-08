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
    @IBOutlet weak var loginSelectBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewSetup()
    }

    func viewSetup() {
        SignUpSelectBtn.layer.cornerRadius = 10
        loginSelectBtn.layer.cornerRadius = 10
    }
    
    @IBAction func loginSelected(_ sender: Any) {
        performSegue(withIdentifier: "loginSignUpSegue", sender: "login")
    }
    
    @IBAction func signUpSelect(_ sender: Any) {
        performSegue(withIdentifier: "loginSignUpSegue", sender: "signUp")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "loginSignUpSegue") {
            let nextVC = segue.destination as! SignInLoginViewController
            nextVC.optionIdentifier = sender as! String
        }
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
