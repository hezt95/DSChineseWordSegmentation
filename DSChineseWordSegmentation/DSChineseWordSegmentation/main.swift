//
//  main.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/11.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation


func main() {
    var dic = CWSDictionary()
    dic.displayNumOfDic()
    for (key, value) in dic.fullDic {
        println((key, value.char))
    }
    system("say Mission Complete")
}

main()


