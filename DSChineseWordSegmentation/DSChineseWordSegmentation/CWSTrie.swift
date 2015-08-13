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
    var trieCounts: Int
    init(key: Character) {
        self.key = key
        children = [CWSTrie]()
        isFinal = true
        trieCounts = 0
    }
    
    init(creat secondChar: Character,inout leftStr: String) {
        self.key = secondChar
        children = [CWSTrie]()
        if leftStr.isEmpty {
            isFinal = true
            trieCounts = 0
        } else {
            isFinal = false
            trieCounts = 1
            self.creatNewBranch(&leftStr)
        }
    }
    
    func creatNewBranch(inout leftChar: String) {
        var newNode = CWSTrie(key: leftChar.removeAtIndex(leftChar.startIndex))
        if leftChar.isEmpty {
            newNode.isFinal = true
            newNode.trieCounts = 0
            self.children!.append(newNode)
        } else {
            newNode.isFinal = false
            newNode.trieCounts = 1
            self.children!.append(newNode)
            for char in leftChar {
                newNode.children!.append(CWSTrie(key: char))
                newNode = newNode.children![0]
                newNode.isFinal = false
                newNode.trieCounts = 1
            }
            //to the end
            newNode.isFinal = true
            newNode.trieCounts = 0
        }
        
    }
    
    //this node is final in this branch
    func setFinal() {
        children = nil
        isFinal = true
        trieCounts = 0
    }
    //add a child node on this node
    func addChild(key: Character, leftStr: String) {
        for char in leftStr {
            
        }
        if children != nil {
            for item in self.children! {
                if key == item.key {
                    return
                }
            }
        }
        children!.append(CWSTrie(key: key))
        isFinal = false
        trieCounts++
    }
    
}