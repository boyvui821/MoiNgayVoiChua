//
//  SetupPageControl.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/7/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import UIKit

class SetupPageControl: UIPageControl {
    
    override func awakeFromNib() {
        setup()
    }
    
    func setup(){
        layer.cornerRadius = 10
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
