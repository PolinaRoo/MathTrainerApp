//
//  TrainViewController.swift
//  MathTrainerApp
//
//  Created by Polina Roo on 13.07.2023.
//

import Foundation
import UIKit

final class TrainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var buttonsAnswer: [UIButton]!
    
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureButtons()
    }
    
    //MARK: Methods
    private func configureButtons() {
        // add shadow
        buttonsAnswer.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}
