//
//  BottomPanelMenuViewController.swift
//  Simple Pomodoro
//
//  Created by Alejandro Mendoza on 14/06/20.
//  Copyright © 2020 Alejandro Mendoza. All rights reserved.
//

import UIKit

enum BottomPanelMenuPositions: CaseIterable {
    case first, second, third
}

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
    
    
    func getPositionHeightForPosition(_ position: BottomPanelMenuPositions) -> CGFloat{
        let tipSectionHeight = upperTipSectionView.frame.height
        let addTaskSectionHeight = addTaskView.frame.height + 1
        let nextTaskSectionHeight = addTaskView.frame.height
        switch position {
        case .first:
            return tipSectionHeight + addTaskSectionHeight + 10
        case .second, .third:
            return tipSectionHeight + addTaskSectionHeight + nextTaskSectionHeight + 30
        }
    }


}
