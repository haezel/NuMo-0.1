//
//  NutrientDetailController.swift
//  CustyTabPractice
//
//  Created by Kathryn Manning on 7/4/15.
//  Copyright (c) 2015 kathrynmanning. All rights reserved.
//

import UIKit

class NutrientDetailController: UIViewController {

    @IBOutlet weak var goBackToMyDayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goBackToMyDayButton.setTitle("\u{f060}", forState:UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
