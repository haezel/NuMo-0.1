//
//  MMNavigationSegue.swift
//  CustyTabPractice
//
//  Created by Kathryn Manning on 6/18/15.
//  Copyright (c) 2015 kathrynmanning. All rights reserved.
//

import UIKit

class MMNavigationSegue: UIStoryboardSegue {
    
    //swapping the vc's happens when custom segue is performed
    //override the perform method to do this
    override func perform()
    {
        let tabBarController = self.sourceViewController as! MMTabBarController
        let destinationController = self.destinationViewController as! UIViewController
        
        for view in tabBarController.placeholderView.subviews as! [UIView]
        {
            //remove all currently added subviews from container view
            view.removeFromSuperview()
        }
        
        //set the currentViewController to destination
        tabBarController.currentViewController = destinationController
        //add new view to container view
        tabBarController.placeholderView.addSubview(destinationController.view)
        
        //set autoresizing
        tabBarController.placeholderView.setTranslatesAutoresizingMaskIntoConstraints(false)
        destinationController.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
        
        tabBarController.placeholderView.addConstraints(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
        
        tabBarController.placeholderView.addConstraints(verticalConstraint)
        
        tabBarController.placeholderView.layoutIfNeeded()
        
        //notify view controller that it was added to the container view
        destinationController.didMoveToParentViewController(tabBarController)
        
    }
   

}
