//
//  ViewController.swift
//  MathTrainerApp
//
//  Created by Polina Tereshchenko on 12.07.2023.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController, DataDelegate {
    // MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    
    @IBOutlet weak var countAdd: UILabel!
    @IBOutlet weak var countSubtract: UILabel!
    @IBOutlet weak var countMultiply: UILabel!
    @IBOutlet weak var countDivide: UILabel!
    
    // MARK: Properties
    private var selectedType: MathTypes = .add
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureButtons()
    }
 
    //MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        
    }
    
    // MARK: Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
            viewController.delegate = self
        }
    }
    private func configureButtons() {
        // add shadow
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
    
    func sendCount(count: String, type: MathTypes) {
        switch type {
        case .add:
            countAdd.text = "Result: \(count)"
        case .subtract:
            countSubtract.text = "Result: \(count)"
        case .multiply:
            countMultiply.text = "Result: \(count)"
        case .divide:
            countDivide.text = "Result: \(count)"
        }
    }


}

