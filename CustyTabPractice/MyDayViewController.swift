//
//  MyDayViewController.swift
//  usdaSqlPractice
//
//  Created by Kathryn Manning on 6/4/15.
//  Copyright (c) 2015 kathrynmanning. All rights reserved.
//

import UIKit

class MyDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //hardcoded nutrients to show
    var nutrientsToShow = [255, 208, 318, 621, 629, 304, 305, 306, 307, 573, 601]
    
    var itemOrNutrientFlag = "item"
    
    //need to use a UI element to chose this String date
    var dateChosen = "2015-06-30"
    
    @IBOutlet weak var itemNutrientSegControl: UISegmentedControl!

    @IBOutlet weak var tableView: UITableView!
    
    //holds (FoodItems for the table, numberOfItems)
    var logInfo : ([FoodForTable], Int)?
    
    //holds (Nutrient, totalRightNow)
    var nutrientTotals : Dictionary<Int, (nutrient:Nutrient, total:Double)>?
    
    
    //--------Lifecycle Methods----------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //in order to use our custom nutrient cell nib
        var nib = UINib(nibName: "nutrientTableCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "nutrientCell")
        
       // tableView.backgroundColor = UIColor.grayColor()
        tableView.tableFooterView = UIView(frame:CGRectZero)
       // tableView.separatorColor = UIColor.clearColor()
        
        //get rid of 1 cell space at top and bottom of tableview - not best solution
        self.automaticallyAdjustsScrollViewInsets = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        tableView.reloadData()
        
        self.nutrientTotals = ModelManager.instance.getNutrientTotals(dateChosen)
    }
    
    
    //--------Table View Methods---------//
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if itemOrNutrientFlag == "item"
        {
            self.tableView.separatorColor = UIColor.colorFromCode(0xDBE6EC)
            //get the logged food items from the db
            self.logInfo =  ModelManager.instance.getLoggedItems(dateChosen)
            if self.logInfo != nil
            {
                let count = self.logInfo!.1
                return count
            }
            else //have not logged any foods
            {
                return 0
            }
        }
        else if itemOrNutrientFlag == "nutrient"
        {
            self.tableView.separatorColor = UIColor.clearColor()
            self.nutrientTotals = ModelManager.instance.getNutrientTotals(dateChosen)
           
            return nutrientsToShow.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if itemOrNutrientFlag == "nutrient"
        {
            var cell : NutrientTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("nutrientCell") as! NutrientTableViewCell
            
            //grab nutrient from of array of nutrients to show
            var nutrientId = self.nutrientsToShow[indexPath.row]
            
            //grab associated element from dictionary of all nutrient totals
            //**** this dictionary should start out with all totals being 0
            var nutrientCellInfo = self.nutrientTotals![nutrientId]
            
            //grab the title String from nutrientTotals
            var title = nutrientCellInfo!.nutrient.name
            
            var unit = nutrientCellInfo!.nutrient.units
            var totalAmount = nutrientCellInfo!.total
            
            cell.nutrientNameLabel.text = title
            cell.percentNutrientLabel.text = String(format: "%.0f \(unit)", totalAmount)

            cell.backgroundColor = UIColor.clearColor()
    
            
            return cell
        }
        
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
            
            let foodItem = self.logInfo!.0[indexPath.row]
            
            cell.textLabel?.text = foodItem.foodDesc
            cell.backgroundColor = UIColor.clearColor()
            
            var wholeNum : Int = Int(foodItem.wholeNumber)
            
            let frac : String = fracToString(foodItem.fraction)
            let measure = foodItem.measureDesc
            
            if wholeNum != 0
            {
                cell.detailTextLabel?.text = "\(wholeNum) \(frac) \(measure)"
            }
            else
            {
                cell.detailTextLabel?.text = "\(frac) \(measure)"
            }
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //delete item from sql food_log table
            
            let time = self.logInfo!.0[indexPath.row].time
            
            ModelManager.instance.deleteItemFromFoodLog(dateChosen , time: time)
            
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if itemOrNutrientFlag == "nutrient" {
            return false
        } else {
            return true
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //for testing of custom nutrient cell
        if itemOrNutrientFlag == "nutrient" {
            return 54.0
        }
        else {
            return 43.0
        }
    }
    
    //---------Segmented Control Changed---------//
    
    @IBAction func itemNutrientChanged(sender: UISegmentedControl) {
    
        switch itemNutrientSegControl.selectedSegmentIndex
        {
        case 0:
            itemOrNutrientFlag = "item"
        case 1:
            itemOrNutrientFlag = "nutrient"
        default:
            break
        }
        tableView.reloadData()
        
    }
    
    //----------Helper Methods---------//
    
    func fracToString(fraction : Double) -> String
    {
        switch fraction
        {
        case 0.0:
            return ""
        case 0.125:
            return "1/8"
        case 0.25:
            return "1/4"
        case 0.333:
            return "1/3"
        case 0.5:
            return "1/2"
        case 0.666:
            return "2/3"
        case 0.75:
            return "3/4"
        default:
            return ""
        }
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
