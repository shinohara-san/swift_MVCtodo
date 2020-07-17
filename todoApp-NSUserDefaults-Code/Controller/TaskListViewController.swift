//
//  TaskListViewController.swift
//  todoApp-NSUserDefaults-Code
//
//  Created by 千葉大志 on 2018/03/04.
//  Copyright © 2018年 bati. All rights reserved.
//

import Foundation
import UIKit

final class TaskListViewController: UIViewController {
    
    fileprivate var dataSource: TaskDataSource!
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        dataSource = TaskDataSource() ///ModelのTaskDataSourceを使う
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "Cell") /// ViewのTaskListを引っ張ってくる
        view.addSubview(tableView)
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(barButtonTapped(sender:)))
        navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.loadData() ///Model経由でデータを引っ張ってくる
        tableView.reloadData() ///Viewに更新指示(tableViewにはViewのTaskListが紐づいている)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: view.safeAreaInsets.left,
                                 y: view.safeAreaInsets.top,
                                 width: view.bounds.size.width,
                                 height: view.bounds.size.height - view.safeAreaInsets.bottom)
    }
    
    @objc func barButtonTapped(sender: UIBarButtonItem) {
        let controller = CreateTaskViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count() ///Modelを経由してデータの数を取得しそれをViewに反映させる
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TaskListCell
        cell.task = dataSource.data(at: indexPath.row) ///Modelを経由してtaskデータを取得しそれをViewに反映させる
        return cell
    }
}
