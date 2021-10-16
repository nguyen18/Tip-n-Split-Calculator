//
//  ViewController.swift
//  Prework_Spring22TechFellow
//
//  Created by Taylor Nguyen on 10/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var BillTextField: UITextField!
    @IBOutlet weak var numPeople: UITextField!
    @IBOutlet weak var tip1: UIButton!
    @IBOutlet weak var tip2: UIButton!
    @IBOutlet weak var tip3: UIButton!
    @IBOutlet weak var tip4: UIButton!
    @IBOutlet weak var tip5: UIButton!
    @IBOutlet weak var customTip: UIButton!
    @IBOutlet weak var customTipValue: UITextField!
    @IBOutlet weak var totalTip: UILabel!
    @IBOutlet weak var totalBill: UILabel!
    @IBOutlet weak var tipPerPerson: UILabel!
    @IBOutlet weak var totalPerPerson: UILabel!
    var tipSelected = 0.0
    @IBOutlet weak var selectedTip: UILabel!
    
    
    @IBOutlet weak var customSetting: UIView!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
        
        mainView.layer.cornerRadius = 20
        mainView.layer.shadowRadius = 5.0
        
        customSetting.isHidden = true
        customSetting.layer.cornerRadius = 20
        customSetting.layer.borderWidth = 1
        customSetting.layer.borderColor = UIColor.lightGray.cgColor
        customSetting.center = mainView.center
        
        view.addSubview(mainView)
        view.addSubview(customSetting)
        // Do any additional setup after loading the view.
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func defaultTip(_ sender: Any) {
        calculateTip(percentage: tipSelected)
    }
    
    @IBAction func defaultSplit(_ sender: Any) {
        if(numPeople.text! == "0") {
            numPeople.text! = "1"
        }
        
        calculateTip(percentage: tipSelected)
    }
    
    
    func calculateTip(percentage: Double) {
        let bill = Double(BillTextField.text!) ?? 0
        let people = Double(numPeople.text!) ?? 0
        tipSelected = percentage
        
        let tip = bill * tipSelected
        let total = bill + tip
        let tipPerson = tip / people
        let totalPerson = total / people
        
        selectedTip.text = String(format: "%.0f%@",tipSelected*100,"%")
        tipPerPerson.text = String(format: "$%.2f", tipPerson)
        totalPerPerson.text = String(format: "$%.2f", totalPerson)
        totalTip.text = String(format: "$%.2f", tip)
        totalBill.text = String(format: "$%.2f", total)
        
    }
    
    @IBAction func calculate10(_ sender: Any) {
        calculateTip(percentage: 0.10)
    }
    
    @IBAction func calculate15(_ sender: Any) {
        calculateTip(percentage: 0.15)
    }
    
    @IBAction func calculate18(_ sender: Any) {
        calculateTip(percentage: 0.18)
    }
    
    @IBAction func calculate20(_ sender: Any) {
        calculateTip(percentage: 0.20)
    }
    
    @IBAction func calculate25(_ sender: Any) {
        calculateTip(percentage: 0.25)
    }
    
    @IBAction func calculateCustom(_ sender: Any) {
        customSetting.isHidden = false
        mainView.isOpaque = true
        customSetting.alpha = 0
        customSetting.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(
            withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: { [self] in
                customSetting.transform = .identity
                self.customSetting.alpha = 1
        }, completion: nil)
    }
    
    @IBAction func exitSettings(_ sender: Any) {
        customSetting.isHidden = true
        mainView.isOpaque = false
    }
    
    @IBAction func doneSettings(_ sender: Any) {
        let tipValue = Double(customTipValue.text!) ?? 0
        calculateTip(percentage: tipValue / 100)
        exitSettings(Any.self)
    }
    
    @IBAction func reset(_ sender: Any) {
        BillTextField.text = String("")
        numPeople.text = String("1")
        tipPerPerson.text = String("$0.00")
        totalPerPerson.text = String("$0.00")
        totalTip.text = String("$0.00")
        totalBill.text = String("$0.00")
        tipSelected = 0.0
        selectedTip.text = String(format: "%.0f%@",tipSelected*100,"%")
    }
    
}

