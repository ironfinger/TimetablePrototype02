//
//  SettingsRootViewController.swift
//  TimetablePrototype02
//
//  Created by Thomas Houghton on 07/10/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SettingsRootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let settings = ["Reset Timetable", "Set Persistance", "Theme: Light"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = settings[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            performSegue(withIdentifier: "SelectedSettingSegue", sender: "Clear")
        }else if (settings[indexPath.row] == "Set Persistance") {
            //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
        }else if (settings[indexPath.row] == "Theme: Light") {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newColor = Settings(context: context)
            newColor.colorTheme = "Dark"
            settings[indexPath.row] == "Theme: Dark"
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }else if (settings[indexPath.row] == "Theme: Dark") {
        }
    }
    /*
     if comicBook != nil {
         comicBook!.title = titleTextField.text!
         comicBook!.image = UIImagePNGRepresentation(comicBookImage.image!)
         navigationController?.popViewController(animated: true)
         (UIApplication.shared.delegate as! AppDelegate).saveContext()
     }else{
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     let comicBook = ComicBook(context: context)
     comicBook.title = titleTextField.text!
     comicBook.image = UIImagePNGRepresentation(comicBookImage.image!)
     comicBook.comicComplete = false
     navigationController?.popViewController(animated: true)
     (UIApplication.shared.delegate as! AppDelegate).saveContext()
     }
     */
    // MARK: - CoreData Sync
    func dataSync() {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SelectedSettingSegue") {
            let nextVC = segue.destination as! SelectedSettingViewController
            nextVC.selectedSetting = "Clear"
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
