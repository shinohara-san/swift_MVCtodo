//
//  CreateTaskViewController.swift
//  todoApp-NSUserDefaults-Code
//
//  Created by 千葉大志 on 2018/03/14.
//  Copyright © 2018年 bati. All rights reserved.
//

import Foundation
import UIKit

final class CreateTaskViewController: UIViewController {
    
    fileprivate var createTaskView: CreateTaskView!
    
    fileprivate var dataSource: TaskDataSource!
    fileprivate var taskText: String?
    fileprivate var taskDeadline: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        createTaskView = CreateTaskView() ///Viewを引っ張ってきている
        createTaskView.delegate = self ///引っ張ってきたViewの処理・関数を行うのは、このファイル自身だと宣言
        view.addSubview(createTaskView)
        
        dataSource = TaskDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createTaskView.frame = CGRect(x: view.safeAreaInsets.left,
                                      y: view.safeAreaInsets.top,
                                      width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                                      height: view.frame.size.height - view.safeAreaInsets.bottom)
        ///createTaskViewをこのControllerに持ってきている
    }
    
    // 保存が成功した時のアラート
    fileprivate func showSaveAlert() {
        let alertController = UIAlertController(title: "保存しました", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            _ = self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    // タスクが未入力の時のアラート
    fileprivate func showMissingTaskTextAlert() {
        let alertController = UIAlertController(title: "タスクを入力してください", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    // 締切日が未入力の時のアラート
    fileprivate func showMissingTaskDeadlineAlert() {
        let alertController = UIAlertController(title: "締切日を入力してください", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

extension CreateTaskViewController: CreateTaskViewDelegate {
    func createView(taskEditting view: CreateTaskView, text: String) {
        taskText = text
        ///CreateTaskViewに入力されたtextを, CreatTaskVCのtaskTextに代入
    }
    
    func createView(deadlineEditting view: CreateTaskView, deadline: Date) {
        taskDeadline = deadline
        ///そもそもCreateTaskViewでdatePickerValueChanged関数で発動するもの
        ///それをdelegateをこちらのVCに設定することでVC内で動作させる(taskDeadline(VCの変数)に新しいdeadlineを代入)
        ///CreateTaskViewに入力されたdeadlineを, CreatTaskVCのtaskDeadlineに代入
    }
    
    ///保存するボタンを押した時の関数
    func createView(saveButtonDidTap view: CreateTaskView) {
        guard let taskText = taskText else {
            showMissingTaskTextAlert()
            return
        }
        guard let taskDeadline = taskDeadline else {
            showMissingTaskDeadlineAlert()
            return
        }
        ///上記アンラップ全てOKだったら保存
        let task = Task(text: taskText, deadline: taskDeadline)
        dataSource.save(task: task)
        
        showSaveAlert()
    }
}
