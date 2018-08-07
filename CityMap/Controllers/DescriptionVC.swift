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
    
    var city = City()
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = city.name
        descriptionTextView.text = city.description
    }

}
