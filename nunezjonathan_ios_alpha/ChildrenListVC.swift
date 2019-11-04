//
//  ChildrenListVC.swift
//  nunezjonathan_ios_alpha
//
//  Created by Jonathan Nunez on 11/3/19.
//  Copyright © 2019 Jonathan Nunez. All rights reserved.
//

import UIKit
import Firebase

class ChildrenListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        childrenList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableItem", for: indexPath)
        
        cell.textLabel?.text = childrenList[indexPath.row]
        
        return cell
    }
    
    @IBOutlet weak var childrenTableView: UITableView!
    
    var childrenList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        childrenTableView.delegate = self
        childrenTableView.dataSource = self
        
        let user = Auth.auth().currentUser
        if user != nil {
             let db = Firestore.firestore()

            db.collection("users")
                .document(user!.uid)
                .collection("children")
                .getDocuments { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let documentData = document.data()
                            self.childrenList.append(String.init(describing: documentData["name"]!))
                        }
                        
                        self.childrenTableView.reloadData()
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
