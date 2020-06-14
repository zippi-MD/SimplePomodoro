//
//  AddTaskView.swift
//  Simple Pomodoro
//
//  Created by Alejandro Mendoza on 14/06/20.
//  Copyright © 2020 Alejandro Mendoza. All rights reserved.
//

import UIKit

@IBDesignable
class AddTaskView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var addTaskTextField: UITextField!
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       customInit()
    }
       
    required init?(coder: NSCoder) {
       super.init(coder: coder)
       customInit()
    }
    
    private func customInit(){
        let bundle = Bundle(for: AddTaskView.self)
        bundle.loadNibNamed(String(describing: AddTaskView.self), owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addTaskTextField.delegate = self
    }
    
}


extension AddTaskView: UITextFieldDelegate {
    
}
