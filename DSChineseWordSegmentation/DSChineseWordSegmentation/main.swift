//
//  main.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/11.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

let dicFileURL = NSURL(fileURLWithPath: "/Users/hezitong/Projects/DSCurriculumDesign/codes/dic")!
let contentFileURL = NSURL(fileURLWithPath: "/Users/hezitong/Projects/DSCurriculumDesign/codes/content/")!
func main() {
    var dic = CWSDictionary()
    var content = CWSContent(dic: dic)
    for (hash, index) in content.indexDic {
        println("\(hash): \(index.key)")
        for item in index.id {
            print(item)
            print(" ")
        }
        print("\n")
    }
    system("say Mission Complete")
}

main()


