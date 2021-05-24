//
//  CalculatorViewController.swift
//  Tip Cal V2
//
//  Created by Alex Truong on 5/22/21.
//  Copyright © 2021 Alex Truong. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController
{
    @IBOutlet weak var totalResultLabel: UILabel!
    @IBOutlet weak var amountBeforeTaxTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var numberOfPeopleSlider: UISlider!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var eachPersonLabel: UILabel!
    
    var tipCalculator = TipCalculator(amountBeforeTax: 0, tipPercentage: 0.1)
    
    let corners = UIRectCorner (arrayLiteral: [
        UIRectCorner.topLeft,
        UIRectCorner.topRight,
        UIRectCorner.bottomLeft,
        UIRectCorner.bottomRight
    ])

    override func viewDidLoad() {
        super.viewDidLoad()
        amountBeforeTaxTextField.becomeFirstResponder()
        self.hideKeyBoardWhenTapped()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // Call the roundCorners() func right there.
//        amountBeforeTaxTextField.roundCorners(corners: [.bottomRight, .topRight], radius: 5)
    }
    
    func calculateBill(){
        tipCalculator.tipPercentage = Double (tipPercentageSlider.value) / 100.0
        tipCalculator.amountBeforeTax = (amountBeforeTaxTextField.text! as NSString).doubleValue
        tipCalculator.calculateTip()
        updateUI()
    }
    
    func updateUI(){
//        totalResultLabel.text = String(format: "$%0.2f", tipCalculator.totalAmount)
        totalResultLabel.text = formatOutput(tipCalculator.totalAmount)
        let numberOfPeople: Int = Int(numberOfPeopleSlider.value)
//        eachPersonLabel.text = String(format: "$%0.2f", tipCalculator.totalAmount / Double(numberOfPeople))
        eachPersonLabel.text = formatOutput(tipCalculator.totalAmount / Double(numberOfPeople))
    }
    
    //
    @IBAction func tipSliderValueChange(sender: Any){
        tipPercentageLabel.text = String(format: "Tip: %02d%%", Int(tipPercentageSlider.value))
         calculateBill()
    }
    @IBAction func numberOfPeopleSliderValueChange(Sender: Any){
        numberOfPeopleLabel.text = "Split: \(Int(numberOfPeopleSlider.value))"
        calculateBill()
    }
    
    
    @IBAction func amountBeforeTextField(_ sender: Any) {
        calculateBill()
    }
    
    func hideKeyBoardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CalculatorViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func formatOutput(_ amount: Double) -> String {
      let formatter = NumberFormatter()
    formatter.locale = Locale.current
      formatter.numberStyle = .currency
      let formattedOutput = formatter.string(from: amount as NSNumber)
      return formattedOutput!
    }
  
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
