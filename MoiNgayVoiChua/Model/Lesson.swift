//
//  Lesson.swift
//  MoiNgayVoiChua
//
//  Created by Nguyen Hieu Trung on 11/7/18.
//  Copyright © 2018 OneSignal. All rights reserved.
//

import Foundation

class Lesson{
    var stt:Int
    var lesson:String
    var godWord:String
    var content:String
    var imageLink:String
    
    init(stt:Int, lesson:String, godWord:String, content:String, imageLink:String) {
        self.stt = stt
        self.lesson = lesson
        self.godWord = godWord
        self.content = content
        self.imageLink = imageLink
    }
}
