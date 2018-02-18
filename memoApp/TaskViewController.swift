//
//  TaskViewController.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/01/24.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit
import RealmSwift

class TaskViewController: UIViewController {
    
    var task: Task?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var changeStateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = task?.title ?? ""
        if task?.status == 1 {
            changeStateButton.setTitle("ToDo", for: .normal)
        }

        deleteButton.layer.cornerRadius = 10.0
        deleteButton.layer.borderWidth = 2.0
        deleteButton.layer.borderColor = UIColor.gray.cgColor

        changeStateButton.layer.cornerRadius = 10.0
        changeStateButton.layer.borderWidth = 2.0
        changeStateButton.layer.borderColor = UIColor.gray.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeStateButtonTapped(_ sender: UIButton) {
        guard let task = task else {
            return
        }

        if task.status == 0 {
            Task.done(id: task.id)
            navigationController?.popViewController(animated: true)
        } else {
            Task.todo(id: task.id)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        guard let task = task else {
            return
        }

        Task.delete(task: task)
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
