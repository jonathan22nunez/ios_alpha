//
//  FeedingMasterVC.swift
//  nunezjonathan_ios_alpha
//
//  Created by Jonathan Nunez on 11/2/19.
//  Copyright © 2019 Jonathan Nunez. All rights reserved.
//

import UIKit

class FeedingMasterVC: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
    }
    
    func setupView() {
        segmentControl.removeAllSegments()
        segmentControl.insertSegment(withTitle: "Bottle", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "Nursing", at: 1, animated: false)
        segmentControl.addTarget(self, action: #selector(selectionChanged(_:)), for: .valueChanged)
        
        if UserDefaults.standard.bool(forKey: "bottleFedActive") == true {
            segmentControl.selectedSegmentIndex = 0
        }
        else {
            segmentControl.selectedSegmentIndex = 1
        }
        
        updateView()
    }
    
    @objc func selectionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(true, forKey: "bottleFedActive")
        case 1:
            UserDefaults.standard.set(false, forKey: "bottleFedActive")
        default:
            break
        }
        updateView()
    }
    
    func updateView() {
        if segmentControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: nursingViewController)
            add(asChildViewController: bottleFedViewController)
        } else {
            remove(asChildViewController: bottleFedViewController)
            add(asChildViewController: nursingViewController)
        }
    }
    
    lazy var bottleFedViewController: BottleVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "bottleVC") as! BottleVC
        
        self.addChild(viewController)
        
        return viewController
    }()
    lazy var nursingViewController: NurseVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "nurseVC") as! NurseVC
        
        self.addChild(viewController)
        
        return viewController
    }()
    
    func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
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
