//
//  BottomPanelMenuViewController.swift
//  Simple Pomodoro
//
//  Created by Alejandro Mendoza on 14/06/20.
//  Copyright © 2020 Alejandro Mendoza. All rights reserved.
//

import UIKit

class BottomPanelMenuViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var upperTipSectionView: UIView!
    @IBOutlet weak var addTaskView: AddTaskView!
    @IBOutlet weak var nextTaskSectionView: UIView!
    
    var firstPositionHeight: CGFloat {
        get {
            return upperTipSectionView.frame.height + addTaskView.frame.height + 1
        }
    }
    
    var secondPositionHeight: CGFloat {
        get {
            return firstPositionHeight + nextTaskSectionView.frame.height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }


}
