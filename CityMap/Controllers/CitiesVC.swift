//
//  CitiesVC.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/6/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import UIKit

// MARK: - Constants

private enum ConstantsCollectionViewLayout {
    static let cellsInRow: CGFloat = 3
    static let cellAspectRatio: CGFloat = 16 / 12
    static let cellSpacing: CGFloat = 4
}

private enum Constants {
    static let navTitle = "Cities"
    static let cellID = "cityCell"
    static let unwindSegueID = "unwindtoCitiesVC"
}

private enum Segues: String {
    case showDescription = "showDescription"
    case showMap = "showMap"
}

class CitiesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {

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
        
        navigationController?.delegate = self
        
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
        
        let cellWidth = collectionView.bounds.size.width / ConstantsCollectionViewLayout.cellsInRow - ConstantsCollectionViewLayout.cellSpacing
        let cellHeight = cellWidth * ConstantsCollectionViewLayout.cellAspectRatio
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // Configure the spacing between items.
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ConstantsCollectionViewLayout.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ConstantsCollectionViewLayout.cellSpacing
    }
    
    // MARK: - Navigation Controller Delegate
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return FadeAnimationController(presenting: true)
        } else {
            return FadeAnimationController(presenting: false)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = segue.identifier else { return }
        
        switch segueIdentifier {
            
        case Segues.showDescription.rawValue:
            guard let cityCell = sender as? CityCell, let pagesController = segue.destination as? PagesVC else {
                return
            }
            // Show city on Pages View Controller.
            pagesController.cities = cities
            pagesController.currentIndex = cityCell.city?.id
    
        case Segues.showMap.rawValue:
            guard let mapController = segue.destination as? MapVC else {
                return
            }
            // Show cities on Map View Controller.
            mapController.cities = cities
        
        default:
            break
        }
    }
    
    // Back to CitiesVC.
    @IBAction func unwindtoCitiesVC(segue: UIStoryboardSegue) {
        performSegue(withIdentifier: Constants.unwindSegueID, sender: self)
    }
}
