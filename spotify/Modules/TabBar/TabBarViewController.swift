//
//  TabBarViewController.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 12.02.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: Properties
    private let titles: [String] = ["Home", "Search", "Library"]
    private let icons: [UIImage?] = [
        UIImage(named: "home_icon"),
        UIImage(named: "search_icon"),
        UIImage(named: "library_icon")
    ]
    
    private var allViewControllers = [
        UINavigationController(rootViewController: MainViewController()),
        UINavigationController(rootViewController: SearchViewController()),
        UINavigationController(rootViewController: LibraryViewController())
    ]
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTabBarViews()
    }
    
    //MARK: Methods
    private func makeTabBarViews(){
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .black
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        view.backgroundColor = .black
        tabBar.tintColor = .white
        tabBar.backgroundColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        setViewControllers(allViewControllers, animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        for i in 0..<items.count {
            items[i].title = titles[i]
            items[i].image = icons[i]
        }
    }
}
