//
//  ToDoTableViewCell.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/01/24.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var task: Task?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.text = task?.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        guard let task = task else {
            return
        }
        Task.done(id: task.id)
    }
}
