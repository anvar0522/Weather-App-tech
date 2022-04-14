//
//  TabBarViewController.swift
//  Weather App tech
//
//  Created by anvar on 14/04/22.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var tabBarVC: UITabBarController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
          createTabBarcontroller()
    }
    func createTabBarcontroller () {
        let weatherCurrentVC = WeatherInfoViewController()
        weatherCurrentVC.title = "Current Weather"
        
        let weatherTableVC = UINavigationController(rootViewController: WeatherTableViewController())
        weatherTableVC.title = "Global Weather"
        
        viewControllers = [weatherCurrentVC, weatherTableVC]
    }
}
