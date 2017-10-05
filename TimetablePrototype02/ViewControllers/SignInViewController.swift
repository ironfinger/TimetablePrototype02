//
//  ViewController.swift
//  TimetablePrototype02
//
//  Created by Thomas Houghton on 25/09/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginSignUpBtn: UIButton!
    
    var selectionOption = 0 // This is to determine if the user is loggin in or creating an account.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stylesSetup()
    }

    func stylesSetup() { // Setup for the looks of the view.
        // Subviews.
        self.subView.layer.cornerRadius = 16;
        self.subView.layer.borderWidth = 2.5;
        self.subView.layer.borderColor =  UIColor.black.cgColor
        // Text Fields.
        self.emailTextField.layer.borderWidth = 2.5
        self.passwordTextField.layer.borderWidth = 2.5
    }
    
    @IBAction func LoginOptionButtonTapped(_ sender: Any) {
        loginSignUpBtn.titleLabel?.text = "Login"
        selectionOption = 0
    }
    
    @IBAction func signUpOptionTapped(_ sender: Any) {
        loginSignUpBtn.titleLabel?.text = "Sign Up"
        selectionOption = 1
    }
    
    @IBAction func loginSignUpTapped(_ sender: Any) {
        if (selectionOption == 0) { // Login
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if (error != nil) {
                    print("We couldn't login the user \(String(describing: error))")
                }else{
                    print("We successfully logged in")
                    self.performSegue(withIdentifier: "mainAppSegue", sender: nil)
                }
            })
        }else if (selectionOption == 1) { // Sign Up
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if (error != nil) {
                    print("We couldn't create an account \(String(describing: error))")
                }else{
                    print("We successfully created an account")
                    Database.database().reference().child("Users").child(user!.uid).child("Email").setValue(self.emailTextField.text!)
                    self.performSegue(withIdentifier: "mainAppSegue", sender: nil)
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

