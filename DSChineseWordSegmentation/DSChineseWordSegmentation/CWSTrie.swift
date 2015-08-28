//
//  CWSTrie.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/12.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

class CWSTrie {
    var key: Character
    var children: [CWSTrie]?
    var isFinal: Bool
    var isWord: Bool
    var trieCounts: Int
    
    required init(coder decoder: NSCoder) {
        key = Character(decoder.decodeObjectForKey("key_") as! String)
        isFinal = decoder.decodeBoolForKey("isFinal")
        isWord = decoder.decodeBoolForKey("isWord")
        children = (decoder.decodeObjectForKey("children") as? [CWSTrie])!
        trieCounts = Int(decoder.decodeIntForKey("trieCounts_"))
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(children, forKey: "children")
        encoder.encodeObject(String(key), forKey: "key_")
        encoder.encodeBool(isFinal, forKey: "isFinal")
        encoder.encodeBool(isWord, forKey: "isWord")
        encoder.encodeInt(Int32(trieCounts), forKey: "trieCounts_")
    }
    
    init(key: Character) {
        self.key = key
        children = [CWSTrie]()
        isFinal = true
        isWord = false
        trieCounts = 0
    }
    
    init(creat anotherChar: Character,inout leftStr: String) {
        self.key = anotherChar
        children = [CWSTrie]()
        if leftStr.isEmpty {
            isFinal = true
            isWord = true
            trieCounts = 0
        } else {
            isFinal = false
            isWord = false
            trieCounts = 1
            self.creatNewBranch(&leftStr)
        }
    }
    
    func creatNewBranch(inout leftStr: String) {
        var newNode = CWSTrie(key: leftStr.removeAtIndex(leftStr.startIndex))
        if leftStr.isEmpty {
            newNode.isFinal = true
            newNode.isWord = true
            newNode.trieCounts = 0
            self.children!.append(newNode)
        } else {
            newNode.isFinal = false
            newNode.trieCounts = 1
            self.children!.append(newNode)
            for char in leftStr {
                newNode.children!.append(CWSTrie(key: char))
                newNode = newNode.children![0]
                newNode.isFinal = false
                newNode.trieCounts = 1
            }
            //to the end
            newNode.isFinal = true
            newNode.isWord = true
            newNode.trieCounts = 0
        }
        
    }
    
    func extendBranch(inout leftStr:String) {
        if leftStr.isEmpty {
            self.isWord = true
        }
        //self is the second char trie node
        if self.isFinal == true {
            //this moreChar is the 3rd char in a word
            var moreChar = leftStr.removeAtIndex(leftStr.startIndex)
            self.children!.append(CWSTrie(creat: moreChar, leftStr: &leftStr))
            self.isFinal = false
            self.trieCounts++
        } else {
            var leftTrie = self
            var isSecondChar = true
            for char in leftStr {
                var charIsExist = false
                if leftTrie.children!.isEmpty {
                    leftTrie.children!.append(CWSTrie(key: char))
                    leftTrie.isFinal = false
                    leftTrie.trieCounts++
                }
                for item in leftTrie.children! {
                    if char == item.key {
                        leftTrie = item
                        charIsExist = true
                        isSecondChar = false
                        break
                    }
                }
                if !charIsExist {
                    var moreChar = leftStr.removeAtIndex(leftStr.startIndex)
                    leftTrie.children!.append(CWSTrie(creat: moreChar, leftStr: &leftStr))
                    leftTrie.isFinal = false
                    leftTrie.trieCounts++
                    break
                }
            }
            if !isSecondChar {
                leftTrie.isWord = true
            }
        }
    }
    
    func findMoreCharTrie(key: Character) -> CWSTrie? {
        for item in children! {
            if item.key == key {
                return item
            }
        }
        return nil
    }
    
}