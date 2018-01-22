//
//  NewTaskViewController.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/01/22.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
