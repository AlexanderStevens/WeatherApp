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
    
    static func convertDateToDay(date:String?)-> String {
        print("In convert Date")
        var returnString = ""
        if date != nil {
            if let day = date {
                returnString = day
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
                if let newDate = dateFormatter.date(from: day) {
                    print("Date\(newDate)")
                    returnString = dateFormatter.string(from: newDate)
                    print(returnString)
                }
            }
        }
        return returnString
        
    }
    
    //Convert date to day
    //Convert to celcius
}

