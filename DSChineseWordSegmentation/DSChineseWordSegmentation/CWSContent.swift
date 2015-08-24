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
    case MoreChar
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
        var secondCharTrie: CWSTrie?
        var moreCharTrie = CWSTrie(key: "A")
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
                secondCharTrie = firstCharNode!.findSecondCharTrie(char)
                if secondCharTrie != nil {
                    tempWord.append(char)
                    moreCharTrie = secondCharTrie!
                    status = SegmentStatus.MoreChar
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
                
            case .MoreChar:
                //the first moreCharTrie is secondCharTrie
                var resultTrie = moreCharTrie.findMoreCharTrie(char)//the resultTrie is child of moreCharTrie
                if resultTrie != nil {
                    tempWord.append(char)
                    moreCharTrie = resultTrie!
                    status = SegmentStatus.MoreChar
                } else {
                    if moreCharTrie.isWord {
                        index.append(CWSIndex(key: tempWord))
                        charHash = char.unicodeScalarCodePoint()
                        if dic.fullDic[charHash] == nil {
                            status = SegmentStatus.NotFoundInFirstCharNode
                            tempWord = String(char)
                        } else {
                            status = SegmentStatus.TwoChar
                            tempWord = String(char)
                        } 
                        break
                    }
                    var deWord = String()
                    deWord.append(tempWord.removeAtIndex(tempWord.startIndex))//tempWord head char is the temp whole word's second char
                    deWord.append(tempWord.removeAtIndex(tempWord.startIndex))//tempWord head char is the temp whole word's third char
                    if secondCharTrie!.isWord {
                        index.append(CWSIndex(key: deWord))
                        deWord = String()
                    }
                    var branchTrie = secondCharTrie
                    for character in tempWord {
                        branchTrie = branchTrie!.findMoreCharTrie(character)
                        if branchTrie!.isWord {
                            deWord.append(character)
                            index.append(CWSIndex(key: deWord))
                            deWord = String()
                        } else {
                            deWord.append(character)
                        }
                    }
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