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
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var centerLabel: UILabel!
    
    let pathLayer = CAShapeLayer()
    
    var currentPercentage: Int = 0
    var pathColor: UIColor = UIColor.systemBlue
    
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
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setupUI()
        setProgressTo(percentage: 20)
        let tap = UITapGestureRecognizer(target: self, action: #selector(testing))
        containerView.addGestureRecognizer(tap)
    }

    private func setupUI(){
        let center = containerView.center
        let radius = containerView.frame.width / 2
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat.pi / 2, endAngle: 2 * CGFloat.pi + CGFloat.pi / 2, clockwise: true)
        
        pathLayer.path = circularPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = pathColor.cgColor
        pathLayer.lineWidth = 15
        pathLayer.lineCap = .round
        pathLayer.strokeStart = 0
        pathLayer.strokeEnd = 0
        
        containerView.layer.addSublayer(pathLayer)
        
    }
    
    func setProgressTo(percentage: Int) {
        guard let pathLayer = containerView.layer.sublayers?[0] as? CAShapeLayer else { return }
        pathLayer.strokeEnd = CGFloat(Double(percentage) / 100)
        currentPercentage = percentage
    }
    
    @objc
    func testing(){
        setProgressTo(percentage: currentPercentage + 1)
    }
}
