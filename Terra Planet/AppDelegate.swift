//
//  AppDelegate.swift
//  Terra Planet
//
//  Created by f0go on 22/03/2022.
//

import UIKit
import NodeMobile

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let httpUsername = UUID().uuidString
    let httpPassword = UUID().uuidString
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Network.shared.setCredentials(httpUsername, httpPassword)
        NodeRunner.runNode(httpUsername, withPassword: httpPassword)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        API.shared.status { status in
            if !status {
                NodeRunner.runNode(self.httpUsername, withPassword: self.httpPassword)
            }
        }
        KeyChainManager.shared.loadWallet { status in
            if !status {
                DispatchQueue.main.sync {
                    let vc = UIStoryboard(name: "BlockScreen", bundle: nil).instantiateViewController(withIdentifier: "BlockScreenVC")
                    UIApplication.topViewController()!.present(vc, animated: false)
                }
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

