//
//  ViewController.swift
//  TwitterApp
//
//  Created by Enes Sancar on 27.06.2023.
//

import UIKit

final class MainTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    private func configureVC() {
        viewControllers = [
            createNavController(for: HomeVC(), imageName: "house", selectedImageName: "house.fill"),
            createNavController(for: SearchVC(), imageName: "magnifyingglass", selectedImageName: "magnifyingglass"),
            createNavController(for: NotificationsVC(), imageName: "bell", selectedImageName: "bell.fill"),
            createNavController(for: DirectMessagesVC(), imageName: "envelope", selectedImageName: "envelope.fill")
        ]
    }
    
    fileprivate func createNavController(for viewController: UIViewController, imageName: String, selectedImageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.view.backgroundColor = .systemBackground
        viewController.navigationItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        navController.tabBarItem.selectedImage = UIImage(systemName: selectedImageName)
        return navController
    }
}

