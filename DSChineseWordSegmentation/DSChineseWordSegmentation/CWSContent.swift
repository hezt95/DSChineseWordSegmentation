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
    var id: [String]
    init(dic: CWSDictionary) {
        index = [CWSIndex]()
        id = [String]()
        self.loadFiles()
        for item in id {
            var content = loadContent(item)
            self.segmentContent(dic, content: content)
        }
    }
    
    func loadFiles() {
        let filemanager:NSFileManager = NSFileManager()
        let files = filemanager.enumeratorAtPath("/Users/hezitong/Projects/DSCurriculumDesign/codes/contents/")
        while let file: AnyObject = files?.nextObject() {
            id.append(file as! String)
        }
    }
    
    func loadContent(id: String) -> String {
        var urlStr = "/Users/hezitong/Projects/DSCurriculumDesign/codes/contents/" + id
        let data = NSData(contentsOfFile: urlStr)
        return NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
    }
    
    func segmentContent(dic: CWSDictionary, content: String) {
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
                //useless part
//                index.append(CWSIndex(key: tempWord))
                
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
                    //useless part
//                    index.append(CWSIndex(key: tempWord))
                    
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
                    if !moreCharTrie.isFinal {
                        //useless part in content
//                        index.append(CWSIndex(key: tempWord))
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
            //useless part
//            index.append(CWSIndex(key: tempWord))
        }
    }
    
}