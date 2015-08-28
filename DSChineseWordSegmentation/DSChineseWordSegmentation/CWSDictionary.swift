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
        var count = 0
        for item in array {
            for char in array {
                if item.hashValue == char.hashValue {
                    count++
                }
            }
        }
//        for item in array {
//            var hash = UInt64(5381)
//            for char in item.unicodeScalars {
//                hash = ((hash << 5) + hash) + UInt64(char.value)
//                println(hash)
//            }
//           hashArray.append(hash)
//        }
        println(hashArray.count)
//        var count = 0
//        var tempArray = hashArray
//        for item in hashArray {
//            for itema in tempArray {
//                if item == itema {
//                    count++
//                }
//            }
//        }
        println(count)
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

