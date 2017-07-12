/*
    DETERGO - Laundry Detergent Calculation App
    Main View Controller
 
    Programmed by Gregory Desrosiers
 
    Start Date: July 2, 2017
    End Date:
 
    File Name: ViewController.swift
 
    Source Code © 2017 Gregory Desrosiers. All rights reserved.
 
 */

import UIKit

class ViewController: UIViewController {

    // Constants
    let drumCapacityUseMessages: [String] =
        ["Less than 1/4", "1/4", "Between 1/4 and 1/2", "1/2", "Between 1/2 and 3/4", "3/4", "Between 3/4 and 9/10", "9/10", "More than 9/10"]
    let dirtLevelMessages: [String] = ["Very Low", "Low", "Medium", "High", "Very High"]
    let waterHardnesMessages: [String] = ["Very Soft (0 - 17.1 ppm)", "Soft (17.1 - 60.0 ppm)", "Average (60 - 120 ppm)", "Hard (120 - 180 ppm)", "Very Hard (+180 ppm)"]
    
    // Controller Variables
    var drumCapacityUse: DrumCapacityUse = DrumCapacityUse.BETWEEN_ONE_HALF_AND_THREE_QUARTERS
    var dirtLevel: DirtLevel = DirtLevel.MEDIUM
    var waterHardnessLevel: WaterHardness = WaterHardness.AVERAGE
    
    // Interface elements
    @IBOutlet weak var drumCapacityUseLabel: UILabel!
    @IBOutlet weak var dirtLevelLabel: UILabel!
    @IBOutlet weak var waterHardnessLabel: UILabel!
    @IBOutlet weak var detergentSelector: UISegmentedControl!
    
    
    /* Action listeners */
    // Action listener for the amount of space occupied in the washing drum
    @IBAction func drumCapacityStepperValueChanged(sender: UIStepper) {
        drumCapacityUseLabel.text = drumCapacityUseMessages[Int(sender.value - 1)]
        drumCapacityUse = DrumCapacityUse(rawValue: Int(sender.value - 1))!
    }
    
    // Action listener for the amount of dirt the clothes have
    @IBAction func dirtLevelStepperValueChanged(sender: UIStepper) {
        dirtLevelLabel.text = dirtLevelMessages[Int(sender.value - 1)]
        dirtLevel = DirtLevel(rawValue: Int(sender.value - 1))!
    }

    // Action listener for the concentration of minerals in the water supply
    @IBAction func waterHardnessStepperValueChanged(sender: UIStepper) {
        waterHardnessLabel.text = waterHardnesMessages[Int(sender.value - 1)]
        waterHardnessLevel = WaterHardness(rawValue: Int(sender.value - 1))!
    }
    
    // Upon clicking the "Calculate" button, run the calculations and display the result.
    @IBAction func calculateAmountOfDetergentNeeded(sender: UIButton) {
        if (detergentSelector.selectedSegmentIndex == 0) { // Pod detergent
            let podDetergent = PodDetergent(dirtLevel: dirtLevel, drumCapacityUse: drumCapacityUse, waterHardness: waterHardnessLevel)
            
            // Display a corresponding alert based on whether the machine can handle the load or not.
            if (podDetergent.laundryLoad() == LaundryMachine.HAS_TOO_LITTLE_LAUNDRY) {
                displayAlert(podDetergent.amountNeededForWashing(), message: Detergent.tooLittleLaundryExplanationMessage)
            }
            else if (podDetergent.laundryLoad() == LaundryMachine.HAS_TOO_MUCH_LAUNDRY) {
                displayAlert(podDetergent.amountNeededForWashing(), message: Detergent.tooMuchLaundryExplanationMessage)
            }
            else {
                displayAlert("For this load: ", message: podDetergent.amountNeededForWashing())
            }
            
        }
        else if (detergentSelector.selectedSegmentIndex == 1) { // Liquid detergent
            let liquidDetergent = LiquidDetergent(dirtLevel: dirtLevel, drumCapacityUse: drumCapacityUse, waterHardness: waterHardnessLevel)
            
            // Display a corresponding alert based on whether the machine can handle the load or not.
            if (liquidDetergent.laundryLoad() == LaundryMachine.HAS_TOO_LITTLE_LAUNDRY) {
                displayAlert(liquidDetergent.amountNeededForWashing(), message: Detergent.tooLittleLaundryExplanationMessage)
            }
            else if (liquidDetergent.laundryLoad() == LaundryMachine.HAS_TOO_MUCH_LAUNDRY) {
                displayAlert(liquidDetergent.amountNeededForWashing(), message: Detergent.tooMuchLaundryExplanationMessage)
            }
            else {
                displayAlert("For this load: ", message: liquidDetergent.amountNeededForWashing())
            }
        }
        else { // Powder detergent
            let powderDetergent = PowderDetergent(dirtLevel: dirtLevel, drumCapacityUse: drumCapacityUse, waterHardness: waterHardnessLevel)
            
            // Display a corresponding alert based on whether the machine can handle the load or not.
            if (powderDetergent.laundryLoad() == LaundryMachine.HAS_TOO_LITTLE_LAUNDRY) {
                displayAlert(powderDetergent.amountNeededForWashing(), message: Detergent.tooLittleLaundryExplanationMessage)
            }
            else if (powderDetergent.laundryLoad() == LaundryMachine.HAS_TOO_MUCH_LAUNDRY) {
                displayAlert(powderDetergent.amountNeededForWashing(), message: Detergent.tooMuchLaundryExplanationMessage)
            }
            else {
                displayAlert("For this load: ", message: powderDetergent.amountNeededForWashing())
            }
        }
    }
    
    // Display the result in an alert box.
    func displayAlert(title: String, message: String) {
        // From https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // Default functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

