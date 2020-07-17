//
//  TaskListCell.swift
//  todoApp-NSUserDefaults-Code
//
//  Created by 千葉大志 on 2018/03/04.
//  Copyright © 2018年 bati. All rights reserved.
//

import Foundation
import UIKit

final class TaskListCell: UITableViewCell {
    
    private var taskLabel: UILabel!
    private var deadlineLabel: UILabel!
    
    var task: Task? {
        ///cell.task = tasks[indexPath.row]という形で使われるので、まずtaskをアンラップしてそれをUILabelへ
        didSet {
            guard let t = task else { return }
            taskLabel.text = t.text
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"

            deadlineLabel.text = formatter.string(from: t.deadline)
        }
    }
    
    ///2つのlabelの色や形を決めている(設置はTaskListVCのregisterにて)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        taskLabel = UILabel()
        taskLabel.textColor = UIColor.black
        taskLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(taskLabel)
        
        deadlineLabel = UILabel()
        deadlineLabel.textColor = UIColor.black
        deadlineLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(deadlineLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        taskLabel.frame = CGRect(x: contentView.bounds.origin.x + 15.0,
                                 y: contentView.bounds.origin.y + 15.0,
                                 width: contentView.frame.width - (15.0 * 2),
                                 height: 15)
        
        deadlineLabel.frame = CGRect(x: taskLabel.frame.origin.x, ///taskLabelとdeadlineLabelのxを揃えてる
                                     y: taskLabel.frame.maxY + 8.0,
                                     width: taskLabel.frame.width,
                                     height: 15.0)
    }
}
