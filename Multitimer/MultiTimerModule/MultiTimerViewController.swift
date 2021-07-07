//
//  ViewController.swift
//  Multitimer
//
//  Created by Милена on 05.07.2021.
//

import UIKit
import SnapKit

class MultiTimerViewController: UIViewController, MultiTimerViewInput {
    var output: MultiTimerViewOutput!
    
    var nameTimerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = String.timerName
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor.veryLightGray
        return textField
    }()
    
    var timeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = String.timeOfSeconds
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor.veryLightGray
        return textField
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        button.setTitle(String.add, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 10
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(addTimer), for: .touchUpInside)
        return button
    }()
    
    var timersTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        output = MultiTimerPresenter(view: self)
        layoutViews()
        setUpTableView()
        setUpInitialState()
    }
    
    private func setUpInitialState() {
        title = String.multiTimer
        view.backgroundColor = .white
    }
    
    private func setUpTableView() {
        timersTableView.dataSource = self
        timersTableView.register(TimerCell.self, forCellReuseIdentifier: TimerCell.identifier)
        timersTableView.tableFooterView = UIView()
    }
    
    private func layoutViews() {
        let sizeTextField = view.bounds.width * (2/3)
        
        view.addSubview(nameTimerTextField)
        nameTimerTextField.snp.makeConstraints { make in
            make.top.equalTo(view).inset(120)
            make.left.equalTo(view).inset(25)
            make.height.equalTo(32)
            make.width.equalTo(sizeTextField)
        }
        
        view.addSubview(timeTextField)
        timeTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTimerTextField).inset(55)
            make.left.equalTo(view).inset(25)
            make.height.equalTo(32)
            make.width.equalTo(sizeTextField)
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(timeTextField).inset(70)
            make.left.equalTo(view).inset(15)
            make.centerX.equalTo(view)
            make.height.equalTo(70)
        }
        
        view.addSubview(timersTableView)
        timersTableView.snp.makeConstraints { (make) in
            make.top.equalTo(addButton).inset(100)
            make.left.equalTo(view).inset(0)
            make.right.equalTo(view).inset(0)
            make.bottom.equalTo(view).inset(15)
        }
    }
    
    @objc func addTimer(sender: UIButton!) {
        let name = nameTimerTextField.text ?? ""
        let time = timeTextField.text ?? ""
        output.add(nameTimer: name, time: time)
        nameTimerTextField.text = ""
        timeTextField.text = ""
    }
}

extension MultiTimerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimerCell.identifier) as? TimerCell
        let timer = output.timers[indexPath.row]
        cell?.fill(timer: timer)
        cell?.backgroundColor = UIColor.veryLightGray
        return cell ?? UITableViewCell()
    }
    
    func show(error: Error) {
        let alert = UIAlertController(title: String.Error.error, message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: String.Error.ok, style: .default, handler: .none)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func insertNewTimer() {
        let indexPath = IndexPath(row: output.timers.count - 1, section: 0)
        timersTableView.insertRows(at: [indexPath], with: .none)
    }
    
    func reloadTableView() {
        self.timersTableView.reloadData()
    }
}
