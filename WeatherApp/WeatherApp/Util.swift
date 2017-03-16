//
//  Util.swift
//  WeatherApp
//
//  Created by AlexS on 15/03/2017.
//  Copyright © 2017 AStevensProductions. All rights reserved.
//

import Foundation

class Util{
//,completionHandler : @escaping ([Forcast])->())
    static func convertToDays(jumbledDays:[Forcast],completionHandler : @escaping (([[Forcast]])->())) {
       
        var daysArray = [[Forcast]]()
        print("In sort days function, Jumbled Count:")
        print(jumbledDays.count)
        var dayForcastArray = [Forcast]()
        
        //Last Dict is not added
        
        
    for item in jumbledDays {
        
        if (item.date_text?.contains("00:00:00"))! {
            print("new day, forcast count:")
            print(dayForcastArray.count)
            
            if (dayForcastArray.count > 0){
                print("day appended to array")
                
                daysArray.append(dayForcastArray)
                dayForcastArray = [Forcast]()
            }
        }else{
            print("Forcast added to day array")
            dayForcastArray.append(item)
        }
    }
        
        DispatchQueue.main.async(execute: { ()-> Void in
            print("Day count")
            print(daysArray.count)
            completionHandler(daysArray)
       
        })
    }
}
