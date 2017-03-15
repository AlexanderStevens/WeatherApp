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
    
        
        print(item.date_text)
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

//    static func fetchWeatherResults (location:String,completionHandler : @escaping ([Forcast])->()) {
//        
//              
//        
//        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL) {data,response,error in
//            
//            if error != nil {
//                print(error!)
//                return
//            }
//            
//            do {
//                print("no error")
//                var forcastArray = [Forcast]()
//                
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
//                print("json serialized")
//                let list = json["list"] as! [[String:AnyObject]]
//                let forcast = Forcast()
//                
//                for item in list {
//                    
//                    
//                    let main = item["main"] as! [String:AnyObject]
//                    let temp = main["temp"] as! NSNumber
//                    let mintenp = main["temp_max"] as! NSNumber
//                    let maxtemp = main["temp_min"] as! NSNumber
//                    
//                    
//                    
//                    let weather = item["weather"] as! [[String:AnyObject]]
//                    let weatherSet = weather.first! as [String:AnyObject]
//                    
//                    let weatherMain = weatherSet["main"] as! String
//                    let weatherDescription = weatherSet["description"] as! String
//                    let icon = weatherSet["icon"] as! String
//                    
//                    let clouds = item["clouds"] as! [String:AnyObject]
//                    let clperc = clouds["all"] as! NSNumber
//                    
//                    let wind = item["wind"] as! [String:AnyObject]
//                    let windSpeed = wind["speed"] as! NSNumber
//                    let windDeg = wind["deg"] as! NSNumber
//                    
//                    let date_text = item["dt_txt"] as! String
//                    
//                    
//                    forcast.date_text = date_text
//                    forcast.temperature = temp
//                    forcast.minTemp = mintenp
//                    forcast.maxTemp = maxtemp
//                    forcast.weather = weatherMain
//                    forcast.weatherDescription = weatherDescription
//                    forcast.iconName = icon
//                    forcast.clouds = clperc
//                    forcast.windSpeed = windSpeed
//                    forcast.windDeg = windDeg
//                    print("forcast value set")
//                    
//                    forcastArray.append(forcast)
//                    print("added to forcast array")
//                    print(forcastArray.count)
//                    
//                }
//                
//                DispatchQueue.main.async(execute: { ()-> Void in
//                    
//                    completionHandler(forcastArray)
//                    print("data retuned")
//                })
//                
//            }
//                
//                
//                
//            catch {
//                print(error)
//            }
//            
//            
//            }.resume()
//}
