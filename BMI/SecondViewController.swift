//
//  SecondViewController.swift
//  BMI
//
//  Created by 강소원 on 9/30/24.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var bmi: Double?
    var color: UIColor?
    var adviceString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
    }
    
    func makeUI() {
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        backButton.setTitle("다시 계산하기", for: .normal)
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 5
        
        guard let bmi = bmi else { return }
        bmiNumberLabel.text = String(bmi)
        bmiNumberLabel.backgroundColor = color
        adviceLabel.text = adviceString
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
