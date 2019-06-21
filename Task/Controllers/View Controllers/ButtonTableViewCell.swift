//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Timothy Rosenvall on 6/19/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate : class {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    @IBAction func buttonTapped(_ sender: Any) {
        if let assignedDelegate = delegate {
            assignedDelegate.buttonCellButtonTapped(self)
        }
        
    }
    
    func updateButton (isComplete: Bool) {
        if isComplete {
            completeButton.setImage(UIImage(named: "complete.png"), for: .normal)
        }
    }
}

extension ButtonTableViewCell {
    func update( task: Task ) {
        primaryLabel.text = task.name
        updateButton(isComplete: task.isComplete)
    }
}


