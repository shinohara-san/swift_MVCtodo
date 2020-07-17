 //
//  TaskDataSource.swift
//  todoApp-NSUserDefaults-Code
//
//  Created by 千葉大志 on 2018/03/04.
//  Copyright © 2018年 bati. All rights reserved.
//

import Foundation

 final class TaskDataSource: NSObject {
    
    private var tasks = [Task]()
    
    func loadData() {
        let userDefaults = UserDefaults.standard
        let taskDictionaries = userDefaults.object(forKey: "tasks") as? [[String: Any]]
        guard let t = taskDictionaries else { return }
        for dic in t {
            let task = Task(from: dic)
            tasks.append(task)
        }
    }
    
    func save(task: Task) {
        tasks.append(task)
        
        var taskDictionaries = [[String: Any]]()
        for t in tasks {
            let taskDictionary: [String: Any] = ["text": t.text,
                                                 "deadline": t.deadline]
            taskDictionaries.append(taskDictionary)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(taskDictionaries, forKey: "tasks")
        userDefaults.synchronize()
    }
    
    func count() ->Int {
        return tasks.count
    }

    func data(at index: Int) ->Task? {
        if (tasks.count > index) {
            return tasks[index]
        }
        return nil
    }
}
