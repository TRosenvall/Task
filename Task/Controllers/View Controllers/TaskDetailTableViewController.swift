//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Timothy Rosenvall on 6/19/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueTextField.inputView = dueDatePicker
        updateViews()
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    var taskLandingPad: Task? {
        didSet {
            updateViews()
        }
    }
    var dueDateValue: Date?
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            let notes = notesTextField.text
            else {return}
        if let task = self.taskLandingPad {
            TaskController.sharedInstance.updateTask(task: task, name: name, notes: notes, due: dueDateValue)
        } else {
            TaskController.sharedInstance.createTask(name: name, notes: notes, due: dueDateValue)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = dueDatePicker?.date
        dueTextField.text = dueDatePicker?.date.stringValue()
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        nameTextField.resignFirstResponder()
        dueTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
    }
    
    func updateViews() {
        if isViewLoaded {
            nameTextField.text = taskLandingPad?.name
            dueTextField.text = taskLandingPad?.due?.stringValue()
            notesTextField.text = taskLandingPad?.notes
        }
    }
}
