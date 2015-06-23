//
//  SearchNavigationSegue.swift
//  CustyTabPractice
//
//  Created by Kathryn Manning on 6/19/15.
//  Copyright (c) 2015 kathrynmanning. All rights reserved.
//

import UIKit

class SearchNavigationSegue: UIStoryboardSegue {
    
    override func perform() {
        let searchBarController = self.sourceViewController as! SearchTabController
        let destinationController = self.destinationViewController as! UIViewController
        
        for view in searchBarController.placeholderView.subviews as! [UIView]
        {
            view.removeFromSuperview()
        }
        //set destination controller to search bar's current view controller
        searchBarController.currentViewController = destinationController
        //add new view to container view
        searchBarController.placeholderView.addSubview(destinationController.view)
        
        //set autoresizing
        searchBarController.placeholderView.setTranslatesAutoresizingMaskIntoConstraints(false)
        destinationController.view.setTranslatesAutoresizingMaskIntoConstraints(false)

        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
        
        searchBarController.placeholderView.addConstraints(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
        
        searchBarController.placeholderView.addConstraints(verticalConstraint)
        searchBarController.placeholderView.layoutIfNeeded()

        //notify the destination controller
        destinationController.didMoveToParentViewController(searchBarController)

        
    }
   
}


