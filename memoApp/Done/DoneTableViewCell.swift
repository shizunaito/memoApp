//
//  DoneTableViewCell.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/01/30.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit
import RealmSwift

class DoneTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!

    var task: Task?

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.text = task?.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkButtonTapped(_ sender: UIButton) {
        guard let task = task else {
            return
        }
        Task.todo(id: task.id)
    }
}
