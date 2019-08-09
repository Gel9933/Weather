//
//  ViewController.swift
//  weather
//
//  Created by Narong Promnuch on 9/8/2562 BE.
//  Copyright © 2562 Narong Promnuch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        //let imageURL = URL(string: "https://lifestyle.campus-star.com/app/uploads/2018/08/cat-world.jpg")!
        guard let apiURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Nakhon%20Si%20Thammarat,th&appid=3ba4b3156030bc893e7d3d474e983e91") else {return}
  
        
        let task = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
        
            if let data = data, error == nil{
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String:Any] else { return }
                    guard let weatherDetails = json["weather"] as? [[String: Any]], let weatherMain = json["main"] as? [String: Any] else { return }
                    
                    let temp = ((weatherMain["temp"] as? Double ?? 0) - 273.15)
                    let description = (weatherDetails.first?["description"] as? String)
                    

                    self.temp.text = String("\(temp)°")
                    self.weatherDescription.text = description
                   // print(description)
                }
                catch{
                    print("error")
                    
                }
            }
        }
        task.resume()
        
        
        
        
    }
    

}


