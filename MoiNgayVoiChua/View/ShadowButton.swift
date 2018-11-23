//
//  ShadowButton.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/14/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import Foundation
import UIKit

class ShadowButton: UIButton {
    
    override func awakeFromNib() {
        setupview()
    }
    
    func setupview(){
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.clipsToBounds = true
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
