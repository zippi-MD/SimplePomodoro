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
    
    var bottomPanelMenuVC: BottomPanelMenuViewController?
    var bottomPanelMenuPositionAtBegginingOfDraggGesture: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupBottomPanelMenu()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bottomPanelMenuSegue"{
            bottomPanelMenuVC = segue.destination as? BottomPanelMenuViewController
        }
    }
}

extension ViewController {
    func setupBottomPanelMenu(){
        guard let bottomPanelMenuVC = bottomPanelMenuVC else { return }
        
        bottomPanelMenuContainerView.layer.cornerRadius = 8.0
        bottomPanelMenuContainerView.layer.masksToBounds = true
        
        bottomPanelMenuTopConstraint.constant = view.frame.height - bottomPanelMenuVC.firstPositionHeight - view.safeAreaInsets.bottom - view.safeAreaInsets.top
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(userDraggedBottomPanelMenu(_:)))
        bottomPanelMenuContainerView.addGestureRecognizer(dragGesture)
        
    }
    
    @objc func userDraggedBottomPanelMenu(_ sender: UIPanGestureRecognizer){
        
        if(sender.state == .ended || sender.state == .cancelled){
            bottomPanelMenuPositionAtBegginingOfDraggGesture = nil
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
        
        bottomPanelMenuContainerView.frame = CGRect(x: initialPosition.minX,
                                                    y: initialPosition.minY + yTranslation,
                                                    width: initialPosition.width,
                                                    height: initialPosition.height)
    }
}
