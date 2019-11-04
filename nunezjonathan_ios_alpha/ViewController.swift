//
//  ViewController.swift
//  nunezjonathan_ios_alpha
//
//  Created by Jonathan Nunez on 11/2/19.
//  Copyright © 2019 Jonathan Nunez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class ViewController: UIViewController, FUIAuthDelegate {
    
    let providers: [FUIAuthProvider] = [
        FUIEmailAuth(),
        FUIGoogleAuth()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if Auth.auth().currentUser == nil {
            //FirebaseApp.configure()
            let authUI = FUIAuth.defaultAuthUI()
            // You need to adopt a FUIAuthDelegate protocol to receive callback
            authUI?.delegate = self
            
            authUI?.providers = providers
            
            let authViewController = authUI?.authViewController()
            
            if authViewController != nil {
                present(authViewController!, animated: true, completion: nil)
            }
        }
    }

    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
      if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
        return true
      }
      // other URL handling goes here.
      return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
      // handle user and error as necessary
    }
    
}

