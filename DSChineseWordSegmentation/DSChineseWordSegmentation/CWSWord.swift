//
//  CWSWord.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/11.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

class CWSWord {
    var wordString: String?
    
    //say hello
    class func sayHello() {
        println("hello, welcome to Zitong's CWSWord")
    }
    
    //the init func
    init(string wordString: String) {
        self.wordString = wordString
    }
    
    //print this word
    func printWord() {
        println(self.wordString!)
    }
}