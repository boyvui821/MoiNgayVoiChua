//
//  ShadowContentView.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/7/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import Foundation
import UIKit
class ShadowContentView: UIView{
    
    override func awakeFromNib() {
        setupview()
    }
    
    func setupview(){
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
