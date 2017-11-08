//
//  SignInLoginViewController.swift
//  TimetablePrototype02
//
//  Created by Thomas Houghton on 02/11/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignInLoginViewController: UIViewController {

    @IBOutlet weak var signInStatusLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var subView: UIView!
    
    var optionIdentifier = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signInStatusLabel.text = ""
        viewSetup()
    }

    func viewSetup() { // Sets up the view for the rounded corners and label.
        subView.layer.cornerRadius = 10
        
        emailTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        
        if (optionIdentifier == "signUp") {
            signInStatusLabel.text = "Sign Up"
        }else if (optionIdentifier == "login") {
            signInStatusLabel.text = "Login"
        }
    }
    
    @IBAction func signInLoginButtonTapped(_ sender: Any) {
        if (optionIdentifier == "signUp") {
            signUp()
        }else if (optionIdentifier == "login") {
            login()
        }
    }
    
    func signUp() { // Creates a new user.
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if (error != nil) {
                print("Couldn't create user \(error)")
            }else{
                Database.database().reference().child("Users").child(user!.uid).child("Email").setValue(self.emailTextField.text!)
                self.performSegue(withIdentifier: "mainAppSegue", sender: nil)
            }
        }
    }
    
    func login() { // Logs a user in.
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if (error != nil) {
                print("We couldn't log in\(error)")
            }else{
                print("Successfully logged in.")
                self.performSegue(withIdentifier: "mainAppSegue", sender: nil)
            }
        }
    }
}
