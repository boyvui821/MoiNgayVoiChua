//
//  AppDelegate.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/6/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Request Notification
        UNService.shared.authorize()
        
        //Facebook SDK setting
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //Back4App Setting
        let configuration = ParseClientConfiguration {
            $0.applicationId = BACK4APP_APPID
            $0.clientKey = BACK4APP_CLIENTKEY
            $0.server = BACK4APP_SERVER
        }
        Parse.initialize(with: configuration)
        
        //saveInstallationObject()
        
        // Initialize the Google Mobile Ads SDK.
        // Sample AdMob app ID: ca-app-pub-3940256099942544~1458002511
        // My AdMob app ID: ca-app-pub-3167518105754283~7946353801
        GADMobileAds.configure(withApplicationID: "ca-app-pub-3167518105754283~7946353801")
        
        //Kiểm tra số lần mở app để request review
        StoreReviewHelper.incrementAppOpenedCount()
        return true
    }
    
    func saveInstallationObject(){
        if let installation = PFInstallation.current(){
            installation.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("You have successfully connected your app to Back4App!")
                } else {
                    if let myError = error{
                        print(myError.localizedDescription)
                    }else{
                        print("Uknown error")
                    }
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("--didReceiveRemoteNotification--")
        print(userInfo)
        completionHandler(.newData)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Token: \(deviceToken)")
        //Lấy device token
        let token = deviceToken.reduce(""){$0 + String(format: "%02X", $1)}
        
        print("Token 1: \(deviceToken.map { String(format: "%02.2hhx", $0) }.joined())")
        print("Token 2: \(token)");
        
        createInstallationOnParse(deviceTokenData: deviceToken)
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    //Cấu hình theo parseserver của back4app
    func createInstallationOnParse(deviceTokenData:Data){
        if let installation = PFInstallation.current(){
            installation.setDeviceTokenFrom(deviceTokenData)
            installation.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("You have successfully saved your push installation to Back4App!")
                } else {
                    if let myError = error{
                        print("Error saving parse installation \(myError.localizedDescription)")
                    }else{
                        print("Uknown error")
                    }
                }
            }
        }
    }
    
    //MARK: - Dùng cho FB SDK
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool{
        
        let hadnled = FBSDKApplicationDelegate.sharedInstance()?.application(app, open: url, options: options)
        // Add any custom logic here.
        return hadnled!;
    }
    
    //MARK: - Dùng cho FB SDK
    func applicationDidBecomeActive(_ application: UIApplication){
        FBSDKAppEvents.activateApp()
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
    }
    
    //    func applicationDidBecomeActive(_ application: UIApplication) {
    //        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

