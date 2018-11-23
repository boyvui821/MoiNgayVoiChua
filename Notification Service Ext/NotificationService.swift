//
//  NotificationService.swift
//  Notification Service Ext
//
//  Created by Nguyen Hieu Trung on 11/12/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            //            // Modify the notification content here...
            //            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            
            guard let imageUrl = bestAttemptContent.userInfo["imageUrl"] as? String else {
                contentHandler(request.content)
                return
            }
            
            //Tải hình ảnh
            DownloadService.shared.downloadImage(with: imageUrl) { (url) in
                do{
                    let attachment = try UNNotificationAttachment(identifier: "image", url: url, options: nil)
                    bestAttemptContent.attachments = [attachment]
                    contentHandler(bestAttemptContent)
                }catch{
                    print("Error: \(error.localizedDescription)")
                    contentHandler(bestAttemptContent)
                }
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
}
