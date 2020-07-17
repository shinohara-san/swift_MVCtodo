//
//  Task.swift
//  todoApp-NSUserDefaults-Code
//
//  Created by 千葉大志 on 2018/03/04.
//  Copyright © 2018年 bati. All rights reserved.
//

import Foundation

final class Task {
    var text: String // タスクの内容
    var deadline: Date // 締切
    
    // textとdeadlineを引数にとるイニシャライザメソッド
    init (text: String, deadline: Date) {
        self.text = text
        self.deadline = deadline
    }
    
    // dictionaryを引数にとるイニシャライザメソッド。
    init(from dictionary: [String: Any]) {
        text = dictionary["text"] as! String
        deadline = dictionary["deadline"] as! Date
    }
}
