//
//  CitiesVC.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/6/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import UIKit

class CitiesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties

    var networkManager = NetworkManager()
    var imageManager = ImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cities"
        
        checkInternetConnection()
    }
    
    // Create alert window if internet is not available. Load data if internet is connected.
    
    func checkInternetConnection() {
        
        // If internet is connected, load data.
        
        if NetworkState.isConnected() {
            print("Internet is available.")
            downloadDataFromInternet()
        } else {
            print("Internet is not available.")
            
            // If internet is not connected, create alert window.
            
            let alert = UIAlertController(title: "Error", message: "The Internet connection appears to be offline.", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAct = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let tryAct = UIAlertAction(title: "Try again", style: .default) { UIAlertAction in
                
                // If internet is connected, load data, else check connetcion again.
                
                if NetworkState.isConnected() {
                    print("Internet is available.")
                    self.downloadDataFromInternet()
                } else {
                    self.checkInternetConnection()
                }
            }
            
            alert.addAction(cancelAct)
            alert.addAction(tryAct)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Load data from internet in main queue and reload data in collection view.
    
    func downloadDataFromInternet() {
        networkManager.loadCities() {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    // MARK: - Collection view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networkManager.cities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "cityCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CityCell else {
            fatalError("The dequeued cell is not an instance of CityCell")
        }
        
        let city = networkManager.cities[indexPath.row]
        cell.nameLabel.text = city.title
        imageManager.imageDownloader(urlString: city.url, imageView: cell.imageView)
        
        return cell
    }
    
    // MARK: - Collection view layout

    // Configure the size of items.
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width/3) - 5
        let height: CGFloat = 160.0
        return CGSize(width: width, height: height)
    }
    
    // Configure the spacing between items.
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(4,2,4,2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    // MARK: - Navigation
    
    // Show city on Description View Controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DescriptionVC {
            
            let cell = sender as! CityCell
            let indexPath = collectionView?.indexPath(for: cell)
            let selectedCity = networkManager.cities[(indexPath?.row)!]
            
            if indexPath != nil {
                // City displayed on another screen.
                destination.cityTitle = selectedCity.title
                destination.cityDescription = selectedCity.description
                destination.cityImageURL = selectedCity.url
            }
        }
    }
    
    // Back to CitiesVC.
    @IBAction func unwindtoCitiesVC(segue: UIStoryboardSegue) {
        performSegue(withIdentifier: "unwindtoCitiesVC", sender: self)
    }
}
