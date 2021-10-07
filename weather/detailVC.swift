//
//  detailVC.swift
//  weather
//
//  Created by user on 30.09.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class detailVC: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temp_c: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet var viewbg: UIView!
    
    
    var cityName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        currentWeather(city: cityName)
        let colorTop = UIColor(red: 89/255, green: 156/255, blue: 169/255, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        //self.view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            print(self.cityName)
        }
    
    func currentWeather(city: String){
        let url =
        "https://api.weatherapi.com/v1/current.json?key=077ca166c21440c2a55123731212709&q=\(city)"
        
        
        AF.request(url, method: .get).validate().responseJSON { responce in
            switch responce.result {
        case.success(let value):
            let json = JSON(value)
            let name = json["location"]["name"].stringValue
            let temp = json["current"]["temp_c"].doubleValue
            let country = json["location"]["country"].stringValue
            let weatherURLString = "http:\(json["location"][0]["icon"].stringValue)"
            print(temp)
                
            self.cityNameLabel.text = name
            self.temp_c.text = String(temp)
            self.countryLabel.text = country
                
            let weatherURL = URL(string: weatherURLString)
            if let data = try? Data(contentsOf: weatherURL!){
                self.imageWeather.image = UIImage(data: data)
            }
                
            print(value)
        case.failure(let error):
            print(error)
            
            }
        }
    }

}
