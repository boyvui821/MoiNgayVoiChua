//
//  AlertService.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/8/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import Foundation
import UIKit

class AlertService{
    private init(){}
    static let shared = AlertService()
    
    func ShowActionSheet(with vc: UIViewController, completion: @escaping ()->Void){
        
        let alertController = UIAlertController(title: "Chia sẻ", message: "Chia sẻ câu chuyện lên Facebook", preferredStyle: .actionSheet);
        
        let actionShare = UIAlertAction(title: "Chia sẻ ngay", style: .default) { (action) in
            completion()
        }
        
        let actionCancel = UIAlertAction(title: "Không chia sẻ", style: .default) { (action) in
        }
        
        alertController.addAction(actionShare)
        alertController.addAction(actionCancel)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    func ShowRequestInternet(with vc: UIViewController){
        let alertController = UIAlertController(title: "Kết nối dữ liệu thất bại", message: "Vui lòng kiểm tra kết nối wifi và dữ liệu di động của bạn rồi thử lại", preferredStyle: .alert);
        
        let actionTryAgain = UIAlertAction(title: "Cài đặt", style: .default) { (action) in
            //            completion()
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        
        alertController.addAction(actionTryAgain)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    func ShowWarning(with vc: UIViewController, message: String){
        let alertController = UIAlertController(title: "Cảnh báo", message: message, preferredStyle: .alert);
        
        let closeAction = UIAlertAction(title: "Đóng", style: .default) { (action) in
        }
        
        alertController.addAction(closeAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    
}
