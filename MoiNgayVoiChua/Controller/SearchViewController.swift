//
//  SearchViewController.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/13/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import UIKit
import ProgressHUD

class SearchViewController: UIViewController {
    
    @IBOutlet weak var txtNumberIndex: UITextField!
    
    var totalLesson:Int!
    
    @IBOutlet weak var lblTotalLesson: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTotalLesson.text = "Số bài học hiện tại là \(totalLesson!)"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func PressCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func PressStartSearch(_ sender: Any) {
        if txtNumberIndex.text == "" {
            //AlertService.shared.ShowWarning(with: self, message: "Số bài học cần tìm không được trống")
            ProgressHUD.showError("Số bài học cần tìm không được trống")
            return
        }
        
        if Int(txtNumberIndex.text!)! <= 1 || Int(txtNumberIndex.text!)! > totalLesson {
            //AlertService.shared.ShowWarning(with: self, message: "Số bài học chỉ từ 1 - \(totalLesson)")
            ProgressHUD.showError("Số bài học chỉ từ 1 - \(totalLesson!)")
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("searchNotification"), object: Int(txtNumberIndex.text!))
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func TapToView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
