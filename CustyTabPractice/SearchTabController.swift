//
//  SearchTabController.swift
//  CustyTabPractice
//
//  Created by Kathryn Manning on 6/19/15.
//  Copyright (c) 2015 kathrynmanning. All rights reserved.
//

import UIKit

class SearchTabController: UIViewController {

    
    var currentViewController: UIViewController?
    
    //placeholder view that will contain the controller's view
    @IBOutlet var placeholderView: UIView!
    
    @IBOutlet var tabBarButtons: Array<UIButton>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //give the buttons names and add set their unicode character for fontawesome
        
        let mainSearchTabBarButton : UIButton = tabBarButtons[0]
        mainSearchTabBarButton.setTitle("\u{f0f5}", forState:UIControlState.Normal)
        
        let barcodeSearchTabBarButton : UIButton = tabBarButtons[1]
        barcodeSearchTabBarButton.setTitle("\u{f02a}", forState:UIControlState.Normal)
        
        let pictureSaveTabBarButton : UIButton = tabBarButtons[2]
        pictureSaveTabBarButton.setTitle("\u{f030}", forState:UIControlState.Normal)
        
        let addItemTabBarButton : UIButton = tabBarButtons[3]
        addItemTabBarButton.setTitle("\u{f055}", forState:UIControlState.Normal)

 
        if(tabBarButtons.count > 0)
        {
            performSegueWithIdentifier("Search1", sender: tabBarButtons[0])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let availableIdentifiers = ["Search1", "Search2", "Search3", "Search4", "Test"]
        
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
