//
//  CWSFirstCharNode.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/12.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation
class CWSFirstCharNode {
    var key: Character
    var trieCounts: Int
    var trie: [CWSTrie]?
    
    //no use init func
    init(key: Character) {
        self.key = key
        trieCounts = 0
        trie = [CWSTrie]()
    }
    
    //init when the first char not in first char nodes
    //creat a branch directly
    init(creat firstChar: Character,inout leftStr: String) {
        self.key = firstChar
        trieCounts = 1
        trie = [CWSTrie]()
        var secondChar = leftStr.removeAtIndex(leftStr.startIndex)//the leftStr now lost 2 char
        trie!.append(CWSTrie(creat: secondChar, leftStr: &leftStr))
    }
    
    //when there have the firstCharNode you should use this func
    func addChildTire(inout leftStr: String) {
        var secondChar = leftStr.removeAtIndex(leftStr.startIndex)
        var secondCharIsAppear = false
        for item in trie! {
            if secondChar == item.key {
                secondCharIsAppear = true
                item.extendBranch(&leftStr)
                break
            }
        }
        if secondCharIsAppear == false {
            trie!.append(CWSTrie(creat: secondChar, leftStr: &leftStr))
            self.trieCounts++
        }
    }
    
    func findSecondCharTrie(key: Character) -> CWSTrie? {
        for item in trie! {
            if key == item.key {
                return item
            } else {
                return nil
            }
        }
        return nil
    }
    
}