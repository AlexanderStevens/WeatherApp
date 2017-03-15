//
//  ViewController.swift
//  WeatherApp
//
//  Created by AlexS on 13/01/2017.
//  Copyright © 2017 AStevensProductions. All rights reserved.
//

import UIKit

class WeatherTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Save search location
    
    @IBOutlet weak var serachField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    
    let cellHeadID = "cellHID"
    let weatherID = "cellWID"
    var daysArray = [[Forcast]]()
    var myActivityIndicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(CellHeader.self, forCellReuseIdentifier: cellHeadID)
        tableView.register(WeatherCell.self, forCellReuseIdentifier: weatherID)
        tableView.reloadData()
        // Create and register nibs
        
    }

    @IBAction func searchForResults(_ sender: UIButton) {
        print("reguest made")
        myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator!.center = view.center
        myActivityIndicator!.startAnimating()
        view.addSubview(myActivityIndicator!)
        
        
        let location :String = self.serachField.text!
        
        WeatherObject.fetchWeatherResults(location:location, completionHandler: {forcastArray in
            print("return from Weather Call")
            print(forcastArray.count)
            
            let serialQueue = DispatchQueue(label: "com.queue.Serial")
            serialQueue.sync {
               
                Util.convertToDays(jumbledDays: forcastArray, completionHandler: {convertedDays  in
                    print("Converted Days Array Count")
                    print(convertedDays.count)
                    let firstDay = convertedDays.first
                    let firstForcast = firstDay?.first
                    let date_Time = firstForcast?.date_text!
                    print("First Forcast Time is:\(date_Time)")
                    self.daysArray = convertedDays
                   
                })
               
                
                DispatchQueue.main.async{
                    print("async reload")
                     self.myActivityIndicator?.stopAnimating()
                    self.tableView.reloadData()
                }


            }
            
            
            
            
        
        })
    }
    
    func showDayDetailForApp(_ day:[Forcast]) {
        
        let dayForcastViewController = DayForcastViewController()
        dayForcastViewController.dayForcast = day
        navigationController?.pushViewController(dayForcastViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Segue to day breakdown
        if indexPath.item > 0 {
        showDayDetailForApp(daysArray[indexPath.item])
        
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DayArray Count:")
        print(daysArray.count)
        return daysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("In cell for row")
        if indexPath.item == 0 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier:  cellHeadID) as! CellHeader
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier:  weatherID) as! WeatherCell
            let day = daysArray[indexPath.item-1]
            let forcast = day.first
            print(forcast?.date_text!)
            cell.textLabel?.text = forcast?.weather!
            cell.detailTextLabel?.text = forcast?.weatherDescription!
            
            return cell
        }
    }
}

class CellHeader: UITableViewCell {
    //custom search cell?
    //Display search location plus img?

    
}

class WeatherCell: UITableViewCell {
    // Image 
    
    
    
}
