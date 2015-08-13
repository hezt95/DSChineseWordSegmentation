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
    init(creatWith firstChar: Character,inout leftStr: String) {
        self.key = firstChar
        trieCounts = 1
        trie = [CWSTrie]()
        var secondChar = leftStr.removeAtIndex(leftStr.startIndex)//the leftStr now lost 2 char
        trie!.append(CWSTrie(creat: secondChar, leftStr: &leftStr))
    }
    
    //actually the second char in the word
    func addChildTire(key: Character, tempStr: String) {
        var leftStr = tempStr
        if trie != nil {
            for item in self.trie! {
                if key == item.key {
                    leftStr.removeAtIndex(leftStr.startIndex)
                }
            }
        }
        leftStr.removeAtIndex(leftStr.startIndex)
        trie!.append(CWSTrie(key: key))
        trieCounts++
    }
    
    
}