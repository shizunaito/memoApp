//
//  NewTaskViewController.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/01/22.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit
import RealmSwift

class NewTaskViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!

    private var lastId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.layer.cornerRadius = 10.0
        addButton.layer.borderWidth = 2.0
        addButton.layer.borderColor = UIColor.gray.cgColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        let realm = try! Realm()
        lastId = realm.objects(Task.self).last?.id ?? -1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        if let text = titleTextField.text, !text.isEmpty {
            Task.save(id: lastId + 1,title: text, deadline: nil)
        }

        titleTextField.text = ""
    }
}
