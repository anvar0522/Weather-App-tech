//
//  WeatherTableViewController.swift
//  Weather App tech
//
//  Created by anvar on 12/04/22.
//

import UIKit

class WeatherTableViewController: UIViewController, UISearchResultsUpdating {
    var timer = Timer()
    private var weatherModel: WeatherModel?

    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        return tableView
    }()
   
    private var isFiltering = true
    
    
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
        let livetext = searchController.searchBar.text!
        timer.invalidate()
        if livetext.count > 1  {
            let url =
            "https://api.openweathermap.org/data/2.5/forecast?q=\(livetext)&appid=643af76231454dfa6de370101f37b7c4"
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
                
                NetworkManager.shared.fetchData(from:url) { model in
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
/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


