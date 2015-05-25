//
//  TableViewController.swift
//  WeatherForecast
//
//  Created by Hongbin Yang on 5/11/15.
//  Copyright (c) 2015 Hongbin Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    

    var report: [WeatherData] = []
    let appId:String = "cf8b229fef4dd9c6a7daa3d44c6dcbe7"
    let apiUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?q=Bellevue,US&mode=json&units=imperial&cnt=7"
    
    func forecast() {
        
        let endpoint = apiUrl + "&APPID=" + appId
        
        Alamofire.request(.GET, endpoint)
            .responseJSON { (request, response, data, error) in
                if let anError = error
                {
                    println("error calling GET")
                    println(error)
                }
                else
                {
                    var data = JSON(data!)
                    // handle the results as JSON, without a bunch of nested if loops
                    self.report = []
                    for (index: String, subJson: JSON) in data["list"] {
                        NSLog(index)
                        self.report.append(WeatherData(
                            day: index,
                            minTemp: subJson["temp"]["min"].floatValue,
                            maxTemp: subJson["temp"]["max"].floatValue,
                            description: subJson["weather"][0]["main"].string!,
                            wind: subJson["speed"].floatValue))
                    }
                    
                }
                self.tableView.reloadData();
        }
    }
    
    override func viewDidLoad() {
        forecast()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        NSLog("Total num of rows: %d", self.report.count)
        return self.report.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StringCell", forIndexPath: indexPath) as! UITableViewCell

        let weatherData = self.report[indexPath.row]
        let calendar = NSCalendar.currentCalendar()
        let date = calendar.dateByAddingUnit(.CalendarUnitDay, value: weatherData.day.toInt()!, toDate: NSDate(), options: nil)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        cell.textLabel?.text = formatter.stringFromDate(date!)
        cell.detailTextLabel?.text = "\(weatherData.maxTemp)(hi) -- \(weatherData.minTemp) (low), \(weatherData.description!), \(weatherData.wind) (wind)"
        return cell
    }

    @IBAction func updateWeatherData(sender: AnyObject) {
        forecast()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
