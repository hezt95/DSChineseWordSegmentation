//
//  main.swift
//  DSChineseWordSegmentation
//
//  Created by He Zitong on 15/8/11.
//  Copyright (c) 2015年 He Zitong. All rights reserved.
//

import Foundation

let dicFileURL = NSURL(fileURLWithPath: "/Users/hezitong/Projects/DSCurriculumDesign/codes/dic")!
let contentFileURL = NSURL(fileURLWithPath: "/Users/hezitong/Projects/DSCurriculumDesign/codes/content_1")!
func main() {
    println("Start")
    system("date +%s")
//    var dic = CWSDictionary()
    
//    NSKeyedArchiver.archiveRootObject(dic, toFile: "/Users/hezitong/Projects/DSCurriculumDesign/codes/hahaha")
    var dica = NSKeyedUnarchiver.unarchiveObjectWithFile("/Users/hezitong/Projects/DSCurriculumDesign/codes/hahaha") as! CWSDictionary
    println("dic finish")
    system("date +%s")

    var content = CWSContent(dic: dica)
//    for item in content.index {
//        print(item.key)
//        print(" ")
//    }
    println("content finish")
    system("date +%s")
    system("say Mission Complete")
}
main()


