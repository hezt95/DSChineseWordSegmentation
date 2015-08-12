//
//  CWSCharacter.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/12.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

extension Character {
    func unicodeScalarCodePoint() -> Int {
        let charactorString = String(self)
        let scalars = charactorString.unicodeScalars
        let value = scalars[scalars.startIndex].value
        return Int(value)
    }
}