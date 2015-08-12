//
//  CWSDictionary.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/11.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

class CWSDictionary {
    var fullArray: Array<String>
    var fullDic: Dictionary<Int, CWSFirstCharNode>

    class func readDicFile() -> String {
        let url = NSURL(fileURLWithPath: "/Users/hezitong/Projects/DSCurriculumDesign/codes/dic")!
        println("Read from: " + String(stringInterpolationSegment: url))
        let data = NSData(contentsOfURL: url)
        return NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
    }
    
    func displayNumOfDic() {
        var index = 0
        for item in fullArray {
            index++
        }
        println("There are \(index) items in dictionary")
    }
    
    func getFirstCharFromWord(wordString: String) -> Character{
        if wordString.isEmpty {
            fatalError("No string input to this func")
        } else {
            var firstChar = wordString[wordString.startIndex]
            return firstChar
        }
    }
    
    init() {
        let fullString = CWSDictionary.readDicFile()
        fullArray = fullString.componentsSeparatedByString("\n")
        //the last item in the array is no use
        fullArray.removeAtIndex(fullArray.count - 1)
        fullDic = [:]
        for item in fullArray {
            var firstChar = getFirstCharFromWord(item)
            var firstCharHash = firstChar.unicodeScalarCodePoint()
            if fullDic[firstCharHash] == nil {
                fullDic[firstCharHash] = CWSFirstCharNode(char: firstChar)
                fullDic[firstCharHash]!.trieCounts++
            } else {
                fullDic[firstCharHash]!.trieCounts++
            }
        }
    }
    
}

