//
//  TrainViewController.swift
//  MathTrainerApp
//
//  Created by Polina Roo on 13.07.2023.
//

import Foundation
import UIKit

//для отправки на предыдущий экран
protocol DataDelegate {
    func sendCount(count: String, type: MathTypes)
}

final class TrainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    
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
    
    private var firstNumber: Int = 0
    private var secondNumber: Int = 0
    private var firstNumberDivide: Double = 0
    private var secondNumberDivide: Double = 0
    private var sign: String = ""
    var delegate: DataDelegate? = nil
    
    private var count: Int = 0 {
        didSet {
            print("Count: \(count)")
            countLabel.text = "Count: \(count)"
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
        default:
            return 0
        }
    }
    
    private var answerDivide: Double {
        print("\(firstNumberDivide)    \(secondNumberDivide)   \(firstNumberDivide / secondNumberDivide)       \((firstNumberDivide / secondNumberDivide * 10).rounded() / 10)")
        return (firstNumberDivide/secondNumberDivide * 10).rounded() / 10
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
    
    @IBAction func sendData(_ sender: Any) {
        if (delegate != nil) {
            let countString: String = String(count)
            delegate!.sendCount(count: countString, type: type)
            self.navigationController?.popViewController(animated: true)
        }
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
        
        if type != .divide {
            var randomAnswer: Int
            repeat {
                randomAnswer = Int.random(in: (answer - Int.random(in: 1...9))...(answer + Int.random(in: 1...9)))
            } while randomAnswer == answer
            rightButton.setTitle(isRightButton ? String(Int(randomAnswer)) : String(answer) , for: .normal)
            leftButton.setTitle(isRightButton ? String(answer) : String(Int(randomAnswer)), for: .normal)
        } else {
            var randomAnswerDivide: Double
            repeat {
                randomAnswerDivide = Double.random(in: (answerDivide - Double.random(in: 1.0...9.9))...(answerDivide + Double.random(in: 1.0...9.9)))
            } while randomAnswerDivide == answerDivide
            rightButton.setTitle(isRightButton ? String((randomAnswerDivide * 10).rounded() / 10) : String(answerDivide) , for: .normal)
            leftButton.setTitle(isRightButton ? String(answerDivide) : String((randomAnswerDivide * 10).rounded()/10), for: .normal)
        }
        
    }
    
    private func configureQuestion() {
        var question: String = ""
        if type != .divide {
            firstNumber = Int.random(in: 1...99)
            secondNumber = Int.random(in: 1...99)
            if type == .multiply {
                secondNumber = Int.random(in: 2...9)
            }
            question = "\(firstNumber) \(sign) \(secondNumber) = "
            questionLabel.text = question
        } else {
            firstNumberDivide = Double.random(in: 1...99)
            secondNumberDivide = Double.random(in: 2...9)
            firstNumberDivide.round(.towardZero)
            secondNumberDivide.round(.towardZero)
            question = "\(Int(firstNumberDivide)) \(sign) \(Int(secondNumberDivide)) = "
            questionLabel.text = question
        }
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer: Bool
        if type != .divide {
            isRightAnswer = Int(answer) == self.answer
        } else {
            isRightAnswer = Double(answer) == self.answerDivide
        }
        button.backgroundColor = isRightAnswer ? .green : .red
        if isRightAnswer {
            let isSecondAnswer = rightButton.backgroundColor == .red ||
            leftButton.backgroundColor == .red
            
            count += isSecondAnswer ? 0 : 1
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureButtons()
            }
        }
    }
    
}
