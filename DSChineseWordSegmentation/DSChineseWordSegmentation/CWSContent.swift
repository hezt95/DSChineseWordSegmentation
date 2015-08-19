//
//  CWSContent.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/19.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

enum SegmentStatus {
    case NotFoundInFirstCharNode
    case OneCharWord
    case TwoChar
    case WillFindWord
}

class CWSContent {
    var index: [CWSIndex]
    var content: String
    
    init(dic: CWSDictionary) {
        index = [CWSIndex]()
        content = CWSContent.loadContent()
        self.segmentContent(dic)
    }
    
    func segmentContent(dic: CWSDictionary) {
        var status = SegmentStatus.WillFindWord
        var tempWord = String()
        var charHash: Int
        
        for char in content {
            switch status {
            case .WillFindWord:
                charHash = char.unicodeScalarCodePoint()
                if dic.fullDic[charHash] == nil {
                    status = SegmentStatus.NotFoundInFirstCharNode
                    tempWord = String(char)
                } else {
                    status = SegmentStatus.TwoChar
                    tempWord = String(char)
                }
                
            case .NotFoundInFirstCharNode:
                index.append(CWSIndex(key: tempWord))
                charHash = char.unicodeScalarCodePoint()
                if dic.fullDic[charHash] == nil {
                    status = SegmentStatus.NotFoundInFirstCharNode
                    tempWord = String(char)
                } else {
                    status = SegmentStatus.TwoChar
                    tempWord = String(char)
                }
            case .TwoChar:
                var charHash = Character(tempWord).unicodeScalarCodePoint()
                var firstCharNode = dic.fullDic[charHash]
                var secondCharTrie = firstCharNode!.findSecondCharTrie(char)
                if secondCharTrie != nil {
                    tempWord.append(char)
                    index.append(CWSIndex(key: tempWord))
                    status = SegmentStatus.WillFindWord
                } else {
                    index.append(CWSIndex(key: tempWord))
                    charHash = char.unicodeScalarCodePoint()
                    if dic.fullDic[charHash] == nil {
                        status = SegmentStatus.NotFoundInFirstCharNode
                        tempWord = String(char)
                    } else {
                        status = SegmentStatus.TwoChar
                        tempWord = String(char)
                    }
                }
            default:
                break
            }
        }
        if !tempWord.isEmpty {
            index.append(CWSIndex(key: tempWord))
        }
    }
    
    class func loadContent() -> String {
        var data = NSData(contentsOfURL: contentFileURL)
        var str = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
        println(str)
        return str
    }
}