//
//  CWSIndex.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/19.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

class CWSIndex {
    var key: String
    var id: [String]
    init(creat key: String, with id: String) {
        self.key = key
        self.id = [String]()
        self.id.append(id)
    }
    
    func addID(id: String) {
        var isExist = false
        for item in self.id {
            if item == id {
                isExist = true
            }
        }
        if isExist == false {
            self.id.append(id)
        }
    }
    
    func displayHtmlID() {
        for item in id {
            println(item)
        }
    }
    
}