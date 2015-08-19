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
    
}