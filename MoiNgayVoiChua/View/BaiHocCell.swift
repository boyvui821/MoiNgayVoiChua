//
//  BaiHocCell.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/7/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import UIKit
import SnapKit

class BaiHocCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
        setupImage()
    }
    
    func setupView(){
        viewCell.layer.cornerRadius = 10
        viewCell.layer.shadowRadius = 10
        viewCell.layer.shadowColor = UIColor.black.cgColor
        viewCell.layer.shadowOpacity = 1;
        viewCell.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func setupImage(){
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(lesson:Lesson){
        let url = URL(string: lesson.imageLink)
        imgView.sd_setImage(with:url)
    }
    
}
