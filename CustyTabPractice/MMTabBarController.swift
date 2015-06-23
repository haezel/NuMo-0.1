//
//  MMTabBarController.swift
//  CustyTabPractice
//
//  Created by Kathryn Manning on 6/18/15.
//  Copyright (c) 2015 kathrynmanning. All rights reserved.
//

import UIKit

class MMTabBarController: UIViewController {
    
    var currentViewController: UIViewController?
    
    //placeholder view that will contain the controller's view
    @IBOutlet var placeholderView: UIView!
    
    @IBOutlet var tabBarButtons: Array<UIButton>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(tabBarButtons.count > 0)
        {
            performSegueWithIdentifier("FirstVcIdentifier", sender: tabBarButtons[0])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let availableIdentifiers = ["FirstVcIdentifier", "SecondVcIdentifier", "SettingsVcIdentifier"]
        
        if (contains(availableIdentifiers, segue.identifier!))
        {
            for btn in tabBarButtons
            {
                btn.selected = false
            }
            
            //highlight the correct button
            let senderBtn = sender as! UIButton
            senderBtn.selected = true
        }
    }

}
