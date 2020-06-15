//
//  ConfigurationMenuTableViewController.swift
//  Simple Pomodoro
//
//  Created by Alejandro Mendoza on 15/06/20.
//  Copyright © 2020 Alejandro Mendoza. All rights reserved.
//

import UIKit

enum ConfigurationOptions: Int, CaseIterable {
    case WorkPeriods = 0
    case WorkTime
    case SmallRestTime
    case LongRestTime
}

class ConfigurationMenuTableViewController: UITableViewController {

    @IBOutlet var configurationOptionsValueLabels: [UILabel]!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didChangeValueFor(_ sender: UIStepper) {
        
        guard let _ = ConfigurationOptions(rawValue: sender.tag),
              let configurationValueLabel = configurationOptionsValueLabels?[sender.tag] else { return }
        
        configurationValueLabel.text = "\(Int(sender.value))"
        
    }
    

}

// MARK: - Data Source
extension ConfigurationMenuTableViewController {
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


// MARK: - Delegate

