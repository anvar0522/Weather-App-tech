//
//  WeatherTableViewController.swift
//  Weather App tech
//
//  Created by anvar on 12/04/22.
//

import UIKit

class WeatherTableViewController: UIViewController, UISearchResultsUpdating {
    let url = "https://api.openweathermap.org/data/2.5/forecast?id=524901&appid=643af76231454dfa6de370101f37b7c4"
    var timer = Timer()
    
    private var weatherModel: WeatherModel?
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
       configureTableView()
        setTableViewDelegate()
        initialize()
    }
       override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tableView.frame = view.bounds
        }
    func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 100
        
    }
    func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
     private func initialize() {
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        }
        
    func updateSearchResults(for searchController: UISearchController) {
        let city = searchController.searchBar.text!
        timer.invalidate()
        if city != "" {
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
                NetworkManager.shared.fetchData(from:self.url) { model in
                    self.weatherModel = model
                    self.tableView.reloadData()
                }
                
            })
        }
    }
}
        

    // MARK: - Table view data source
extension WeatherTableViewController: UITableViewDataSource, UITableViewDelegate {
 
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             weatherModel?.list!.count ?? 0
    }
        
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell 
          cell.configureCity(with:weatherModel?.city ?? .init(id: 1, name: "1", country: "2"))
          cell.configureTemp(from: weatherModel?.list![indexPath.row].main.temp ?? 0.0)
          cell.configureTime(from: weatherModel?.list![indexPath.row].dtTxt ?? "0")
          cell.configureLowestTemp(from: weatherModel?.list![indexPath.row].main.tempMin ?? 0.0)
          cell.configureHighestTemp(from: weatherModel?.list![indexPath.row].main.tempMax ?? 0.0)
    
    
        return cell
      }
}

