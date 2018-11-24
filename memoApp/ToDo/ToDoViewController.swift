//
//  ToDoTableViewController.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/01/24.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class ToDoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTaskButton: UIBarButtonItem!

    private var tasks: Results<Task>?{
        do{
            let realm = try Realm()
            return realm.objects(Task.self).filter("status = 0")
        } catch {
        }
        return nil
    }

    private var isEditting = Variable<Bool>(false)

    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.withoutUnderline()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "toDoTableViewCell")
        tableView.register(UINib(nibName: "AddTaskTableViewCell", bundle: nil), forCellReuseIdentifier: "AddTaskTableViewCell")

        addTaskButton.rx.tap
            .map { [weak self] _ in
                guard let self = self else { return false }
                return !self.isEditting.value
            }
            .bind(to: isEditting)
            .disposed(by: disposeBag)

        isEditting.asObservable()
            .distinctUntilChanged()
            .skip(1)
            .subscribe(onNext: { [weak self] isEditing in
                guard let self = self else { return }
                self.tableView.beginUpdates()

                if isEditing {
                    self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
                } else {
                    self.tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .top)
                }
                self.tableView.endUpdates()
            })
            .disposed(by: disposeBag)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let taskVC as TaskViewController:
            guard let row = sender as? Int else { break }
            taskVC.task = tasks?[row]
        default:
            break
        }
    }
}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let editCellCount = isEditting.value ? 1 : 0
        return (tasks?.count ?? 0) + editCellCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AddTaskTableViewCell", for: indexPath) as? AddTaskTableViewCell, indexPath.row == 0 && isEditting.value {
            cell.textField.text = ""
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoTableViewCell", for: indexPath) as? ToDoTableViewCell, let task = tasks?[indexPath.row] else {
            return UITableViewCell()
        }

        cell.task = task
        cell.titleLabel.text = task.title

        cell.checkButton.rx.tap
            .subscribe { _ in
                tableView.reloadData()
            }
            .disposed(by: disposeBag)

        return cell
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
