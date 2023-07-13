//
//  TrainViewController.swift
//  MathTrainerApp
//
//  Created by Polina Roo on 13.07.2023.
//

import Foundation
import UIKit

final class TrainViewController: UIViewController {
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }
}
