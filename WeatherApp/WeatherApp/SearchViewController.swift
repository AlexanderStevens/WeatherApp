//
//  ViewController.swift
//  WeatherApp
//
//  Created by AlexS on 18/03/2017.
//  Copyright © 2017 AStevensProductions. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


    @IBAction func goPressed(_ sender: Any) {
        if searchField?.text != nil {
            
        }
    }


}
