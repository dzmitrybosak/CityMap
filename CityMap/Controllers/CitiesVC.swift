//
//  CitiesVC.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/6/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import UIKit

class CitiesVC: UITableViewController {

    // MARK: - Properties
    
    var city = City()
    var cities = Cities().cities
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cities"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(55)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cityCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CityCell else {
            fatalError("The dequeued cell is not an instance of CityCell")
        }
        
        let city = cities[indexPath.row]
        cell.nameLabel.text = city.name
        cell.descriptionLabel.text = city.description

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DescriptionVC {
            let index = tableView.indexPathForSelectedRow?.row
            if index != nil {
                
                // City displayed on another screen.
                destination.city = cities[index!]
            }
        }
    }
    
    // Back to CitiesVC.
    @IBAction func unwindtoCitiesVC(segue: UIStoryboardSegue) { }

}
