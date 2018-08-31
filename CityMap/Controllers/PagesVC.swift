//
//  PagesVC.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/30/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import UIKit

// MARK: - Constant

private enum Constant {
    static let descriptionVC = "DescriptionViewController"
}

class PagesVC: UIPageViewController {
    
    // MARK: - Properties
    
    var cities: [City] = []
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        dataSource = self
        
        if let viewController = descriptionController(currentIndex ?? 0, cities[currentIndex].title) {
            let viewControllers = [viewController]
            setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.lightGray
    }
    
    private func updateNavigationTitle(title: String) {
        navigationItem.title = title
    }
    
    private func descriptionController(_ index: Int, _ title: String) -> DescriptionVC? {
        guard let storyboard = storyboard, let page = storyboard.instantiateViewController(withIdentifier: Constant.descriptionVC) as? DescriptionVC else {
                return nil
        }
        
        page.city = cities[index]
        updateNavigationTitle(title: title)
        
        return page
    }
}

// MARK: - Page View Controller Data Source

extension PagesVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? DescriptionVC, let index = viewController.city?.id, index > 0, let title = viewController.city?.title {
            return descriptionController(index - 1, title)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? DescriptionVC, let index = viewController.city?.id, (index + 1) < cities.count, let title = viewController.city?.title {
            return descriptionController(index + 1, title)
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cities.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
}
