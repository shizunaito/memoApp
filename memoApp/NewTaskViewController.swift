//
//  NewTaskViewController.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/01/22.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.layer.cornerRadius = 10.0
        addButton.layer.borderWidth = 2.0
        addButton.layer.borderColor = UIColor.gray.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addButtonTapped(_ sender: Any) {
    }
}
