//
//  ShadowContentImage.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/7/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import Foundation
import UIKit

class ShadowContentImage: UIImageView {
    override func awakeFromNib() {
        setup()
    }
    
    func setup(){
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
