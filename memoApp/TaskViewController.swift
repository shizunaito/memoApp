//
//  TaskViewController.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/01/24.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    var task: Task?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = task?.title ?? ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
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
