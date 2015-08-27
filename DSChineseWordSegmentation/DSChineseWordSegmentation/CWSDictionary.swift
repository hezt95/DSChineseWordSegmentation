//
//  CWSDictionary.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/11.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

@objc class CWSDictionary:NSObject, NSCoding {
    var fullDic: Dictionary<Int, CWSFirstCharNode>

    required init(coder decoder: NSCoder) {
        self.fullDic = (decoder.decodeObjectForKey("fullDic") as? Dictionary<Int, CWSFirstCharNode>)!
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(self.fullDic, forKey: "fullDic")
    }
    
    class func readDicFile() -> String {
        println("Read from: " + String(stringInterpolationSegment: dicFileURL))
        let data = NSData(contentsOfURL: dicFileURL)
        return NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
    }
    
    func displayNumOfDic(array: [String]) {
        var index = 0
        for item in array {
            index++
        }
        println("There are \(index) items in dictionary")
    }
    
    override init() {
        fullDic = [:]
        super.init()
        let fullString = CWSDictionary.readDicFile()
        var fullArray = fullString.componentsSeparatedByString("\n")
        for wordStr in fullArray {
            var tempStr = wordStr
            var firstChar = tempStr.removeAtIndex(tempStr.startIndex)
            var firstCharHash = firstChar.unicodeScalarCodePoint()
            
            if fullDic[firstCharHash] == nil {
                fullDic[firstCharHash] = CWSFirstCharNode(creat: firstChar, leftStr: &tempStr)
            } else {
                fullDic[firstCharHash]!.addChildTire(&tempStr)
            }
            
        }
    }
}

