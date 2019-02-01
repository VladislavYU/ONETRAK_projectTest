//
//  AppDelegate.swift
//  ONETRAK_TEST
//
//  Created by Vladislav Zakharchenko on 31/01/2019.
//  Copyright © 2019 Vladislav Zakharchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
    
        let view = MetricViewController(nibName: "MetricViewController", bundle: nil)
        let metricService = MetricServiceImp()
        let preseter = MetricPresenter(view: view, metricService: metricService)
        view.presenter = preseter
        let nc = UINavigationController(rootViewController: view)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        return true
    }



}

