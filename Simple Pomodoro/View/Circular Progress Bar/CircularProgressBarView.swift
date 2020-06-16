//
//  CircularProgressBarView.swift
//  Simple Pomodoro
//
//  Created by Alejandro Mendoza on 15/06/20.
//  Copyright © 2020 Alejandro Mendoza. All rights reserved.
//

import UIKit

@IBDesignable
class CircularProgressBarView: UIView {
    @IBOutlet private var containerView: UIView!
    @IBOutlet weak private var circularPathView: UIView!
    @IBOutlet weak private var centerLabel: UILabel!
    
    var currentPercentage: Int = 0
    var pathColor: UIColor = UIColor.systemBlue
    var centerLabelTextColor: UIColor = UIColor.black {
        willSet {
            centerLabel.textColor = newValue
        }
    }
    var centerLabelText: String = "" {
        willSet {
            centerLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       customInit()
    }
       
    required init?(coder: NSCoder) {
       super.init(coder: coder)
       customInit()
    }
    
    private func customInit(){
        let bundle = Bundle(for: CircularProgressBarView.self)
        bundle.loadNibNamed(String(describing: CircularProgressBarView.self), owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        circularPathView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    private func setupPathLayer(){
        let pathLayer = CAShapeLayer()
        
        let center = circularPathView.center
        let radius = circularPathView.frame.width / 2
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat.pi / 2, endAngle: 2 * CGFloat.pi + CGFloat.pi / 2, clockwise: true)
        
        pathLayer.path = circularPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = pathColor.cgColor
        pathLayer.lineWidth = 15
        pathLayer.lineCap = .round
        pathLayer.strokeStart = 0
        pathLayer.strokeEnd = 0
        
        circularPathView.layer.addSublayer(pathLayer)
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let _ = circularPathView.layer.sublayers?[0] as? CAShapeLayer else {
            setupPathLayer()
            return
        }
        
    }
    
    func setProgressTo(percentage: Int) {
        guard let pathLayer = circularPathView.layer.sublayers?[0] as? CAShapeLayer else { return }
        pathLayer.strokeEnd = CGFloat(Double(percentage) / 100)
        currentPercentage = percentage
    }
}
