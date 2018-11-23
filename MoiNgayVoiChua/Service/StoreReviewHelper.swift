//
//  StoreReviewHelper.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/13/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import Foundation
import StoreKit

enum UserDefaultsKeys:String{
    case APP_OPENED_COUNT = "AppOpenCout"
}

struct StoreReviewHelper {
    static func incrementAppOpenedCount() { // called from appdelegate didfinishLaunchingWithOptions:
        guard var appOpenCount = UserDefaults.standard.value(forKey: UserDefaultsKeys.APP_OPENED_COUNT.rawValue) as? Int else {
            UserDefaults.standard.set(1, forKey: UserDefaultsKeys.APP_OPENED_COUNT.rawValue)
            return
        }
        appOpenCount += 1
        UserDefaults.standard.set(appOpenCount, forKey: UserDefaultsKeys.APP_OPENED_COUNT.rawValue)
    }
    static func checkAndAskForReview() { // call this whenever appropriate
        // this will not be shown everytime. Apple has some internal logic on how to show this.
        guard let appOpenCount = UserDefaults.standard.value(forKey: UserDefaultsKeys.APP_OPENED_COUNT.rawValue) as? Int else {
            UserDefaults.standard.set(1, forKey: UserDefaultsKeys.APP_OPENED_COUNT.rawValue)
            return
        }
        
        switch appOpenCount {
        case 2,5:
            StoreReviewHelper().requestReview()
        case _ where appOpenCount % 7 == 0 :
            StoreReviewHelper().requestReview()
        default:
            print("App run count is : \(appOpenCount)")
            break;
        }
        
    }
    fileprivate func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            guard let writeReviewURL = URL(string: "https://itunes.apple.com/app/id1442478538?action=write-review")
                else { fatalError("Expected a valid URL") }
            UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
        }
    }
}
