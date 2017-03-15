//
//  Models.swift
//  WeatherApp
//
//  Created by AlexS on 13/01/2017.
//  Copyright © 2017 AStevensProductions. All rights reserved.
//

import Foundation

class WeatherObject:NSObject {
    
    
    static func fetchWeatherResults (location:String,completionHandler : @escaping ([Forcast])->()) {
        
        let appKey = "223ae3b1b25cc6eddaa67ea08943b218"
        var urlString :String {
            return "http://api.openweathermap.org/data/2.5/forecast?APPID=\(appKey)&q=\(location)&mode=json"
        }
 
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL) {data,response,error in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                print("no error")
                var forcastArray = [Forcast]()
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                print("json serialized")
                let list = json["list"] as! [[String:AnyObject]]
               
                
                for item in list {
                     var forcast = Forcast()
                    
                    let main = item["main"] as! [String:AnyObject]
                    let temp = main["temp"] as! NSNumber
                    let mintenp = main["temp_max"] as! NSNumber
                    let maxtemp = main["temp_min"] as! NSNumber
                    
                    
                    
                    let weather = item["weather"] as! [[String:AnyObject]]
                    let weatherSet = weather.first! as [String:AnyObject]
                    
                    let weatherMain = weatherSet["main"] as! String
                    let weatherDescription = weatherSet["description"] as! String
                    let icon = weatherSet["icon"] as! String
                    
                    let clouds = item["clouds"] as! [String:AnyObject]
                    let clperc = clouds["all"] as! NSNumber
                    
                    let wind = item["wind"] as! [String:AnyObject]
                    let windSpeed = wind["speed"] as! NSNumber
                    let windDeg = wind["deg"] as! NSNumber
                    
                    let date_text = item["dt_txt"] as! String
                    
                    
                    forcast.date_text = date_text
                    forcast.temperature = temp
                    forcast.minTemp = mintenp
                    forcast.maxTemp = maxtemp
                    forcast.weather = weatherMain
                    forcast.weatherDescription = weatherDescription
                    forcast.iconName = icon
                    forcast.clouds = clperc
                    forcast.windSpeed = windSpeed
                    forcast.windDeg = windDeg
                    print("forcast value set")
                    
                    forcastArray.append(forcast)
                    print("added to forcast array")
                    print(forcastArray.count)
                    
                }
                
                DispatchQueue.main.async(execute: { ()-> Void in
                    
                    completionHandler(forcastArray)
                    print("data retuned")
                })
              
            }
                
            
            
            catch {
                print(error)
            }
            
            
            }.resume()
    }

}


class Forcast :NSObject {
 
    var date_text : String?
    var temperature : NSNumber?
    var maxTemp : NSNumber?
    var minTemp : NSNumber?
    var weather : String?
    var weatherDescription : String?
    var iconName : String?
    var clouds: NSNumber?
    var windSpeed : NSNumber?
    var windDeg : NSNumber?
    
}
//{
//    dt: 1486080000,
//    main: {
//        temp: 283.02,
//        temp_min: 282.641,
//        temp_max: 283.02,
//        pressure: 985.45,
//        sea_level: 999.3,
//        grnd_level: 985.45,
//        humidity: 89,
//        temp_kf: 0.38
//    },
//    weather: [
//    {
//    id: 500,
//    main: "Rain",
//    description: "light rain",
//    icon: "10n"
//    }
//    ],
//    clouds: {
//        all: 92
//    },
//    wind: {
//        speed: 9.21,
//        deg: 182.503
//    },
//    rain: {
//        3h: 0.195
//    },
//    sys: {
//        pod: "n"
//    },
//    dt_txt: "2017-02-03 00:00:00"
//},
