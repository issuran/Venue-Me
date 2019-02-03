//
//  AppCoordinator.swift
//  Venue Me
//
//  Created by Tiago Oliveira on 15/01/19.
//  Copyright © 2019 Tiago Oliveira. All rights reserved.
//

import Foundation
import UIKit
import RevealingSplashView

class AppCoordinator: Coordinator {
    
    var window: UIWindow
    var navigationController = UINavigationController()
    let splashView = RevealingSplashView.makeSplash()
    
    var searchViewController: SearchViewController!
    
    required init(window: UIWindow) {
        self.window = window
        window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        startSplash()
        startSearch()
    }
    
    func startSplash() {
        window.addSubview(splashView)
        splashView.startAnimation()
    }
    
    func startSearch() {
        removeSplash()
        searchViewController = SearchViewController()
        navigationController.setViewControllers([searchViewController], animated: true)
    }
    
    func removeSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(2)) {
            self.splashView.playTwitterAnimation()
        }
    }
}

extension RevealingSplashView {
    static func makeSplash() -> RevealingSplashView {
        let revealingSplashView = RevealingSplashView(
            iconImage: UIImage(named: "Search")!,
            iconInitialSize: CGSize(width: 200, height: 200),
            backgroundColor: UIColor.white
        )
        
        revealingSplashView.backgroundImageView?.contentMode = .scaleAspectFit
        revealingSplashView.animationType = .swingAndZoomOut
        return revealingSplashView
    }
}
