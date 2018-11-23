//
//  UNService.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/7/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class UNService:NSObject{
    private override init() {}
    static let shared = UNService()
    
    let unCenter = UNUserNotificationCenter.current()
    
    func authorize(){
        let options = UNAuthorizationOptions(arrayLiteral: [.alert,.sound,.badge,.carPlay])
        unCenter.requestAuthorization(options: options) { (granted, error) in
            guard granted else {
                print("USER DENIED ACCESS")
                return
            }
            
            DispatchQueue.main.async {
                self.configure()
            }
        }
    }
    
    func configure(){
        self.unCenter.delegate = self;
        
        let application = UIApplication.shared
        application.registerForRemoteNotifications()
    }
}

extension UNService: UNUserNotificationCenterDelegate{
    
    // The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        print("UN WILL PRESENT")
        print(notification.request.content.userInfo)
        completionHandler([.sound,.alert])
    }
    
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from application:didFinishLaunchingWithOptions:.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
        print("UN DID RECEIVE")
        completionHandler();
    }
    
}
