//
//  DayForcastViewController.swift
//  WeatherApp
//
//  Created by AlexS on 15/03/2017.
//  Copyright © 2017 AStevensProductions. All rights reserved.
//

import UIKit

class DayForcastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var dayForcast : [Forcast]?
    var location: String?
    let weatherID = "cellWID"
    
    override func viewDidLoad() {
        if dayForcast != nil {
            dateLabel?.text = dayForcast?.first?.date_text
        }
        if location != nil {
            cityLabel?.text = location!
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherCell.self, forCellReuseIdentifier: weatherID)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(160.0)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dayForcast?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("WeatherCell", owner: self, options: nil)?.first as! WeatherCell
        let forcast = (dayForcast?[indexPath.row])! as Forcast
        cell.dayLabel?.text = forcast.date_text!
        cell.descriptionLabel?.text = forcast.weatherDescription!
        cell.iconIV?.image = UIImage(named: forcast.iconName!)
        cell.tempLabel?.text = String(describing: forcast.temperature!)
        cell.weatherLabel?.text = forcast.weather!
        
        return cell
    }
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
