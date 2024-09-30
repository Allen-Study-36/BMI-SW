//
//  ViewController.swift
//  BMI
//
//  Created by 강소원 on 9/30/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    var bmi: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    func makeUI() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        heightTextField.placeholder = "cm단위로 입력해주세요"
        weightTextField.placeholder = "kg단위로 입력해주세요"
    }

    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        guard let h = heightTextField.text, let w =
                weightTextField.text else { return }
        bmi = calculateBMI(heihgt: h, weight: w)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text == "" {
            mainLabel.text = "키를 입력해주세요"
            mainLabel.textColor = .red
            return false
        } else if weightTextField.text == "" {
            mainLabel.text = "몸무게를 입력해주세요"
            mainLabel.textColor = .red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해주세요"
        mainLabel.textColor = .black
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            
            secondVC.bmi = self.bmi!
            secondVC.color = getUserBMIData().color
            secondVC.adviceString = getUserBMIData().adviceString
        }
        
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    func calculateBMI(heihgt: String, weight: String) -> Double {
        guard let h = Double(heihgt), let w = Double(weight) else { return 0.0 }
        var bmi = w / (h * h) * 10000
        bmi = round(bmi * 10) / 10
        return bmi
    }
    
    func getUserBMIData() -> (color: UIColor, adviceString: String) {
        guard let bmi = bmi else { return (UIColor.black, "") }
        switch bmi {
        case ..<18.6:
            return (UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1), "저체중")
        case 18.6..<23.0:
            return (UIColor(displayP3Red: 22/255, green: 251/255, blue: 121/255, alpha: 1), "표준")
        case 23.0..<25.0:
            return (UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1), "과체중")
        case 25.0..<30.0:
            return (UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1), "중도비만")
        case 30.0...:
            return (UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1), "고도비만")
        default:
            return (UIColor.black, "")
            
        }
    }
}

extension ViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
}
