//
//  CWSDictionary.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/11.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

class CWSDictionary {
    var fullDic: Dictionary<Int, CWSFirstCharNode>

    required init(coder decoder: NSCoder) {
        self.fullDic = (decoder.decodeObjectForKey("fullDic") as? Dictionary<Int, CWSFirstCharNode>)!
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(self.fullDic, forKey: "fullDic")
    }
    
    class func hashable() {
        var str = readDicFile()
        var array = str.componentsSeparatedByString("\n")
        var hashArray = [UInt64]()
        for item in array {
            var i = 0
            var hash = UInt64(0)
            for scalar in item.unicodeScalars {
                if (i & 1) == 0 {
                    hash ^= ((hash << 7) ^ UInt64(scalar.hashValue) ^ (hash >> 3))
                } else {
                    hash ^= (~((hash << 11) ^ UInt64(scalar.hashValue) ^ (hash >> 5)))
                }
                i++
                hash = hash & 0x7FFFFFFF
            }
            hashArray.append(hash)
        }
        println(hashArray.count)
        
        for var i = 0; i < hashArray.count; i++ {
            for var j = 0; j < hashArray.count; j++ {
                if i != j {
                    if hashArray[i] == hashArray[j] {
                        println("Error")
                    }
                }
            }
        }
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
    
    init() {
        fullDic = [:]
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

