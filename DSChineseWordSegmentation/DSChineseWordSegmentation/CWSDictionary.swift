//
//  CWSDictionary.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/11.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

class CWSDictionary {
    var fullArray: [String]
    var fullDic: Dictionary<Int, CWSFirstCharNode>

    class func readDicFile() -> String {
        println("Read from: " + String(stringInterpolationSegment: dicFileURL))
        let data = NSData(contentsOfURL: dicFileURL)
        return NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
    }
    
    func displayNumOfDic() {
        var index = 0
        for item in fullArray {
            index++
        }
        println("There are \(index) items in dictionary")
    }
    
    init() {
        let fullString = CWSDictionary.readDicFile()
        fullArray = fullString.componentsSeparatedByString("\n")
        fullDic = [:]
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

