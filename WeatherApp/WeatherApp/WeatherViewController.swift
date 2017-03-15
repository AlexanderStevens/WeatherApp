//
//  ViewController.swift
//  WeatherApp
//
//  Created by AlexS on 13/01/2017.
//  Copyright © 2017 AStevensProductions. All rights reserved.
//

import UIKit

class WeatherTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var serachField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    
    let cellHeadID = "cellHID"
    let weatherID = "cellWID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(CellHeader.self, forCellReuseIdentifier: cellHeadID)
        tableView.register(WeatherCell.self, forCellReuseIdentifier: weatherID)
        
        // Create and register nibs
        
    }

    @IBAction func searchForResults(_ sender: UIButton) {
        
        let location :String = self.serachField.text!
        
        WeatherObject.fetchWeatherResults(location:location, completionHandler: {forcastArray in
            
        
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier:  cellHeadID)
            return cell!
        
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier:  weatherID)
            return cell!
            
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
