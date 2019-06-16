//
//  ViewController.swift
//  TradeMyTesla
//
//  Created by Simon Italia on 6/15/19.
//  Copyright © 2019 Magical Tomato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cars = Cars()
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var modelSegmentControl: UISegmentedControl!
    @IBOutlet weak var upgradesSegmentControl: UISegmentedControl!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var mileageSlider: UISlider!
    @IBOutlet weak var conditionSegmentControl: UISegmentedControl!
    @IBOutlet weak var predictedValuationLabel: UILabel!
    
    //User interacting with any segemnt control or mileage slider will fire a new valuation calculation prediction
    @IBAction func triggerCalculateValue(_ sender: Any) {
        
        //Update MILEAGE Label as slider moves
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formattedMileage = formatter.string(for: mileageSlider.value) ?? "0"
        mileageLabel.text = "MILEAGE \(formattedMileage) miles"
        
        //Generate Trade-in prediction value
        if let predictedValue = try? cars.prediction(
            model: Double(modelSegmentControl.selectedSegmentIndex),
            premium: Double(upgradesSegmentControl.selectedSegmentIndex),
            milegae: Double(mileageSlider.value),
            condition: Double(conditionSegmentControl.selectedSegmentIndex)
        ){
            //Clamp the price so it's at least $2K
            let minimumValuation = max(2000, predictedValue.price)
            
            //make number formatter outut currencies
            formatter.numberStyle = .currency
            
            
            //Display (formatted) predicted value
            predictedValuationLabel.text = formatter.string(for: minimumValuation)
            
        } else {
            //Catch any errors
            predictedValuationLabel.text = "Error! Something went wrong :("
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Custom spacing between specified stackview rows
        stackView.setCustomSpacing(30, after: modelSegmentControl)
        stackView.setCustomSpacing(30, after: upgradesSegmentControl)
        stackView.setCustomSpacing(30, after: mileageSlider)
        stackView.setCustomSpacing(50, after: conditionSegmentControl)
        
        //Fire predciton calculation based on interface values
        triggerCalculateValue(self)
        
    }


}

