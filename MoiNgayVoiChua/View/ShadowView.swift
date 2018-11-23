//
//  ShadowView.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/6/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        setupview()
    }
    
    func setupview(){
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
