//
//  ViewController.swift
//  Simple Pomodoro
//
//  Created by Alejandro Mendoza on 14/06/20.
//  Copyright © 2020 Alejandro Mendoza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bottomPanelMenuContainerView: UIView!
    @IBOutlet weak var bottomPanelMenuTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var circularProgressBarView: CircularProgressBarView!
    
    var bottomPanelMenuVC: BottomPanelMenuViewController?
    var bottomPanelMenuPositionAtBegginingOfDraggGesture: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupBottomPanelMenu()
        circularProgressBarView.setProgressTo(percentage: 80)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bottomPanelMenuSegue"{
            bottomPanelMenuVC = segue.destination as? BottomPanelMenuViewController
        }
    }
}

extension ViewController {
    func setupBottomPanelMenu(){
        guard let _ = bottomPanelMenuVC else { return }
        
        bottomPanelMenuContainerView.layer.cornerRadius = 8.0
        bottomPanelMenuContainerView.layer.masksToBounds = true
        
        moveBottomPanelMenuToPosition(.second)
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(userDraggedBottomPanelMenu(_:)))
        bottomPanelMenuContainerView.addGestureRecognizer(dragGesture)
        
    }
    
    @objc func userDraggedBottomPanelMenu(_ sender: UIPanGestureRecognizer){
        
        if(sender.state == .ended || sender.state == .cancelled){
            bottomPanelMenuPositionAtBegginingOfDraggGesture = nil
            if let updatedPosition = getFinalPositionForBottomPanelView(withPosition: bottomPanelMenuContainerView.frame) {
                moveBottomPanelMenuToPosition(updatedPosition)
            }
            
            return
        }
        else if(sender.state == .began){
            bottomPanelMenuPositionAtBegginingOfDraggGesture = bottomPanelMenuContainerView.frame
            return
        }
        
        guard let initialPosition = bottomPanelMenuPositionAtBegginingOfDraggGesture else { return }
        
        let yTranslation = sender.translation(in: self.view).y
        let finalYPosition = initialPosition.minY + yTranslation
        let bottomMinPosition = view.frame.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top
        let topMaxPosition = view.safeAreaInsets.top
        
        if(finalYPosition < topMaxPosition || finalYPosition > bottomMinPosition){ return }
        
        let finalHeight = initialPosition.minY + yTranslation - view.safeAreaInsets.top
        
        bottomPanelMenuTopConstraint.constant = finalHeight
    }
    
    func getFinalPositionForBottomPanelView(withPosition position: CGRect) -> BottomPanelMenuPositions?{
        guard let bottomPanelMenuVC = bottomPanelMenuVC else { return nil }
        
        var heightsForPositions = [BottomPanelMenuPositions : CGFloat]()
        
        for position in BottomPanelMenuPositions.allCases {
            let height = bottomPanelMenuVC.getPositionHeightForPosition(position)
            heightsForPositions[position] = height
        }
        
        let bottomPanelMenuPosition = view.frame.height - position.minY
        let viewSafeUpperLimit = view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom
        
        switch bottomPanelMenuPosition {
        case 0.0..<heightsForPositions[.first, default: 10.0] * 2:
            return .first
        case heightsForPositions[.first, default: 150.0]..<heightsForPositions[.second, default: 0.0] * 2.3:
            return .second
        case (viewSafeUpperLimit * 0.8)..<viewSafeUpperLimit * 1.5:
            return .fourth
        default:
            return .third
        }
        
    }
    
    func moveBottomPanelMenuToPosition(_ position: BottomPanelMenuPositions){
        guard let bottomPanelMenuVC = bottomPanelMenuVC else { return }
        let positionHeight = bottomPanelMenuVC.getPositionHeightForPosition(position)
        
        let constraintHeightForPosition: CGFloat
        switch position {
        case .first, .second:
            constraintHeightForPosition = view.frame.height - positionHeight - view.safeAreaInsets.bottom - view.safeAreaInsets.top
        case .third:
            let safeSectionView = view.frame.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top
            constraintHeightForPosition = safeSectionView * 0.40
        case .fourth:
            constraintHeightForPosition = 0
        }
        
        self.bottomPanelMenuTopConstraint.constant = constraintHeightForPosition
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
