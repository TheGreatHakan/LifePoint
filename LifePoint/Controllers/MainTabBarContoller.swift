//
//  MAinViewController.swift
//  LifePoint
//
//  Created by HAKAN on 8.02.2025.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let habitTrackingVC = createVC(title: "Habits", imageName: "figure.disc.sports", selectedImage: "figure.disc.sports", rootVC: HabitTrackingViewController())
        let profileVC = createVC(title: "Profile", imageName: "person", selectedImage: "oerson.fill", rootVC: ProfileViewController())
        let homeVC = createVC(title: "Home", imageName: "house", selectedImage: "house.fill", rootVC: HomeViewController())
        let authVC = createVC(title: "", imageName: "plus", rootVC: AuthenticationViewController())
        
        viewControllers = [authVC,habitTrackingVC, homeVC, profileVC]
    
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .gray
        
        selectedIndex = 1
    }
    

    private func createVC(
        title: String,
        imageName: String,
        selectedImage: String? = nil,
        rootVC: UIViewController
    ) -> UINavigationController {
        
        let newVC = UINavigationController(rootViewController: rootVC)
//        newVC.tabBarItem.title = title
        newVC.tabBarItem.image = UIImage(systemName: imageName)
        newVC.tabBarItem.selectedImage = UIImage(systemName: selectedImage ?? imageName)
//        newVC.navigationBar.prefersLargeTitles = true
        rootVC.navigationItem.title = title
        
        return newVC
    }

}
