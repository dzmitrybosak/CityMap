//
//  DescriptionVC.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/6/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController {

    // MARK: - Properties
    
    var imageManager = ImageManager()
    
    var cityTitle: String = ""
    var cityDescription: String = ""
    var cityImageURL: String = ""
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = cityTitle
        descriptionTextView.text = cityDescription
        
        // Download image and save it in cache.
        imageManager.imageDownloader(urlString: cityImageURL, imageView: imageView)
    }
}
