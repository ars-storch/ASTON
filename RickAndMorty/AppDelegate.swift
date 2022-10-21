//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 13.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let ud = UserDefaults.standard
        let session = ud.bool(forKey: UserDefaultKeys.isLoggedIn.rawValue)
        
        let viewModel: CharacterListViewModel = CharacterListDefaultViewModel(networkService: DefaultNetworkService())
        
        if session == true {
            let charVC = CharachtersViewController(viewModel: viewModel)
            charVC.title = "Characters"
            let navigationController = UINavigationController(rootViewController: charVC)
            navigationController.modalPresentationStyle = .fullScreen

            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        } else {
            window?.rootViewController = LoginViewController()
            window?.makeKeyAndVisible()
        }

        
        return true
        
    }
}

