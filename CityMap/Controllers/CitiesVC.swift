//
//  CitiesVC.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/6/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let navTitle = "Cities"
    static let cellID = "cityCell"
    static let imageHolder = "imgholdr-vertical"
    static let unwindSegueID = "unwindtoCitiesVC"
}

class CitiesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties

    private let citiesService = CitiesService.shared
    
    private var cities: [City] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Constants.navTitle
        
        setupData()
    }
    
    // Setup data for cities inside CitiesVC.
    private func setupData() {
        citiesService.cities { [weak self] cities in
            self?.cities = cities
        }
    }

    // MARK: - Collection view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as? CityCell else {
            return UICollectionViewCell()
        }
        
        let city = cities[indexPath.row]
        cell.city = city
        
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
            let selectedCity = cities[(indexPath?.row)!]
            
            if indexPath != nil {
                // City displayed on another screen.
                destination.city = selectedCity
            }
        }
    }
    
    // Back to CitiesVC.
    @IBAction func unwindtoCitiesVC(segue: UIStoryboardSegue) {
        performSegue(withIdentifier: Constants.unwindSegueID, sender: self)
    }
}
