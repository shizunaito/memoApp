//
//  NewTaskViewController.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/01/22.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class NewTaskViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!

    private var lastId: Int = 0
    private var minTitleLength = 3
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.setTitleColor(UIColor.lightGray, for: .disabled)

        titleTextField.rx.text.orEmpty
            .map { $0.count >= self.minTitleLength }
            .share(replay: 1)
            .bind(to: addButton.rx.isEnabled)
            .disposed(by: disposeBag)
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

        dismiss(animated: true, completion: nil)
    }
}
