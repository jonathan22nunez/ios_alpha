//
//  ChildDetailsVC.swift
//  nunezjonathan_ios_alpha
//
//  Created by Jonathan Nunez on 11/3/19.
//  Copyright © 2019 Jonathan Nunez. All rights reserved.
//

import UIKit
import Firebase

class ChildDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return picker[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var dob: UIDatePicker!
    @IBOutlet weak var sex: UIPickerView!
    
    let picker = ["Select a Sex", "Male", "Female"]
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        name.delegate = self
        sex.delegate = self
        sex.dataSource = self
    }
    
    @IBAction func saveChild(_ sender: UIButton) {
        if name.text == "" {
            let emptyFieldAlert = UIAlertController(title: "Whoops", message: "You must at least provide a name for your child", preferredStyle: .alert)
            emptyFieldAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(emptyFieldAlert, animated: true, completion: nil)
        } else {
            let user = Auth.auth().currentUser
            if user != nil {
                var ref: DocumentReference? = nil
                ref = db.collection("users")
                    .document(user!.uid)
                    .collection("children")
                    .addDocument(data: [
                        "name": name.text!,
                        "dob": dob.date,
                        "sex": sex.selectedRow(inComponent: 0)
                    ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
