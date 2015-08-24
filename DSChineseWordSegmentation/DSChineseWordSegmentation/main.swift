//
//  main.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/11.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

let dicFileURL = NSURL(fileURLWithPath: "/Users/hezitong/Projects/DSCurriculumDesign/codes/testDic")!
let contentFileURL = NSURL(fileURLWithPath: "/Users/hezitong/Projects/DSCurriculumDesign/codes/testContent")!
func main() {
    var dic = CWSDictionary()
    var content = CWSContent(dic: dic)
    for item in content.index {
        print(item.key)
        print(" ")
    }
    system("say Mission Complete")
}
main()


