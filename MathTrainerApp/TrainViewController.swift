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
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .divide:
                sign = "/"
            case .multiply:
                sign = "*"
            case .subtract:
                sign = "-"
            }
        }
    }
    
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign: String = ""
    private var count: Int = 0 {
        didSet {
            print("Count: \(count)")
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureQuestion()
        configureButtons()
    }
    
    // MARK: IBActions
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    //MARK: Methods
    private func configureButtons() {
        let buttonsAnswer = [leftButton,rightButton]
        
        //color
        buttonsAnswer.forEach { button in
            button?.backgroundColor = .systemYellow
        }
        // add shadow
        buttonsAnswer.forEach { button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 2)
            button?.layer.shadowOpacity = 0.4
            button?.layer.shadowRadius = 3
        }
        
        let isRightButton = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer+10))
        } while randomAnswer == answer
        
        
        rightButton.setTitle(isRightButton ? String(randomAnswer) : String(answer) , for: .normal)
        leftButton.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
       
    }
    
    private func configureQuestion() {
        firstNumber = Int.random(in: 1...99)
        secondNumber = Int.random(in: 1...99)
        let question: String = "\(firstNumber) \(sign) \(secondNumber) = "
        questionLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .green : .red
        
        if isRightAnswer {
            var isSecondAnswer = rightButton.backgroundColor == .red ||
            leftButton.backgroundColor == .red
            
            count += isSecondAnswer ? 0 : 1
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureButtons()
            }
        }
    }
    
}
