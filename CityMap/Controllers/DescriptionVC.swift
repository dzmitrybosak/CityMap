//
//  DescriptionVC.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/6/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import UIKit
import AlamofireImage

// MARK: - Constants

private enum Constants {
    static let imageHolder = "imgholdr-horizontal"
}

class DescriptionVC: UIViewController {

    // MARK: - Properties
    
    var city: City?
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Automatic scroll text in text view to top.
        DispatchQueue.main.async {
            self.descriptionTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
        }
    }
    
    // Setup data for city property
    
    private func setupData() {
        guard let city = city else {
            return
        }
        
        self.navigationItem.title = city.title
        self.descriptionTextView.text = city.description
        
        imageView.af_setImage(withURL: city.url, placeholderImage: UIImage(named: Constants.imageHolder))
    }
}
