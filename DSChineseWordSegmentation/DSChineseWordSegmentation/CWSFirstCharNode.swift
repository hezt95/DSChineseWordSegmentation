//
//  CWSFirstCharNode.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/12.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation
class CWSFirstCharNode {
    var char: Character
    var trieCounts: Int
    var trie: CWSTrie?
    init(char: Character) {
        self.char = char
        trieCounts = 0
        trie = nil
    }
    
}