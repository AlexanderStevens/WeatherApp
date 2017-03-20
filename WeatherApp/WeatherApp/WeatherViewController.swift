//
//  ViewController.swift
//  WeatherApp
//
//  Created by AlexS on 13/01/2017.
//  Copyright © 2017 AStevensProductions. All rights reserved.
//

import UIKit

class WeatherTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Save search locations
    //Location Services
    //Handle no internet connection - error message turn of 3g Data
    //Design and Create Custom Cells 
    
    
    @IBOutlet weak var serachField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var background: UIImageView!
    
    let cellHeadID = "cellHID"
    let weatherID = "cellWID"
    var daysArray = [[Forcast]]()
    var myActivityIndicator : UIActivityIndicatorView?
    let serialQueue = DispatchQueue(label: "com.queue.Serial")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
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
            
            self.serialQueue.sync {
               
                Util.convertToDays(jumbledDays: forcastArray, completionHandler: {convertedDays  in
                    print("Converted Days Array Count")
                    print(convertedDays.count)
                    let firstDay = convertedDays.first
                    let firstForcast = firstDay?.first
                    let date_Time = firstForcast?.date_text!
                    print("First Forcast Time is:\(date_Time)")
                    self.daysArray = convertedDays
                    
                    DispatchQueue.main.async(execute: { ()-> Void in
                        self.myActivityIndicator?.stopAnimating()
                        self.tableView.reloadData()
                        self.cityLabel.text = location
                        self.cityLabel.isHidden = false
                        
                    })
                })
            }
        })
    }
    
    func showDayDetailForApp(_ day:[Forcast]) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        
        let dayForcastViewController = storyBoard.instantiateViewController(withIdentifier: "detailView") as! DayForcastViewController
        dayForcastViewController.dayForcast = day
        dayForcastViewController.location = cityLabel?.text!
        self.present(dayForcastViewController, animated:true, completion:nil)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Segue to day breakdown
        if daysArray.count > 0 {
            showDayDetailForApp(daysArray[indexPath.item])
        
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DayArray Count:")
        print(daysArray.count)
        let rows = daysArray.count
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = Bundle.main.loadNibNamed("WeatherCell", owner: self, options: nil)?.first as! WeatherCell
            cell.backgroundColor = UIColor.clear
        let day = daysArray[indexPath.item]
        
        
        
        if let forcast = day.first {
                
            if forcast.iconName != nil {
                print(forcast.iconName!)
                cell.iconIV?.image = UIImage(named: forcast.iconName!)
            }
            if forcast.temperature != nil {
                if let decimalTemp = forcast.temperature?.doubleValue{
                let temp = String(format: "%.2f", decimalTemp)
                print(temp)
                let finalTemp = temp.appending("°")
                    cell.tempLabel?.text = finalTemp
                }
            }
            
            if forcast.date_text != nil {
                print(forcast.date_text!)
                self.serialQueue.sync {
                    
                    let dayString = Util.convertDateToDay(date: forcast.date_text)
                    DispatchQueue.main.async(execute: { ()-> Void in
                     cell.dayLabel?.text = dayString
                    })
                }
                
            }
            if forcast.weatherDescription != nil {
                    print(forcast.weatherDescription!)
                    cell.descriptionLabel?.text = forcast.weatherDescription!
            }
            if forcast.weather != nil {
                print(forcast.weather!)
                cell.weatherLabel?.text = forcast.weather!
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(160.0)
    }
}

class CellHeader: UITableViewCell {
    //custom search cell?
    //Display search location plus img?

    
}

class WeatherCell: UITableViewCell {
    // Image 
    @IBOutlet weak var iconIV: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    
    
}
