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
import ReactorKit

final class NewTaskViewController: UIViewController, StoryboardView {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.setTitleColor(UIColor.lightGray, for: .disabled)
        self.reactor = NewTaskViewReactor(realmService: RealmService())
        titleTextField.becomeFirstResponder()
    }

    func bind(reactor: NewTaskViewReactor) {
        titleTextField.rx.text
            .map { Reactor.Action.updateTitle($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        addButton.rx.tap
            .map { Reactor.Action.addTask() }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isTaskAuthenticated }
            .bind(to: addButton.rx.isEnabled)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isTaskSaved }
            .filter { $0 }
            .subscribe { _ in
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
