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
    var url: [String]
    init(key: String) {
        self.key = key
        url = [String]()
        id = [String]()
    }
    
    func displayHtmlURL() {
        for item in url {
            println(item)
        }
    }
    
    func displayHtmlID() {
        for item in id {
            println(item)
        }
    }
    
}