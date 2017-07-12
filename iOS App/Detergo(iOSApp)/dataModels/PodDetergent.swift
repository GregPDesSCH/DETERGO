/*
 DETERGO - Laundry Detergent Calculation App
 Data Model - Pod Detergent
 
 Programmed by Gregory Desrosiers
 
 Start Date: July 4, 2017
 End Date: July 9, 2017
 
 File Name: PodDetergent.swift
 
 Source Code © 2017 Gregory Desrosiers. All rights reserved.
 
 */

import Foundation

public class PodDetergent: Detergent, DetergentFunc {
    
    // Constructor
    override init(dirtLevel: DirtLevel, drumCapacityUse: DrumCapacityUse, waterHardness: WaterHardness) {
        super.init(dirtLevel: dirtLevel, drumCapacityUse: drumCapacityUse, waterHardness: waterHardness)
    }
    
    // Calculates amount of detergent needed to wash the load. (In this case, number of pods)
    func calculateAmountNeededForWashing() -> Int {
        var podsNeeded: Float = 1 // Base amount of detergent
        
        // Adjust amount based on how much of the drum the laundry occupies in a linear fashion
        switch self.drumCapacityUse {
        case DrumCapacityUse.BETWEEN_ONE_QUARTER_AND_ONE_HALF: podsNeeded = 1.33; break
        case DrumCapacityUse.ONE_HALF: podsNeeded = 1.66; break
        case DrumCapacityUse.BETWEEN_ONE_HALF_AND_THREE_QUARTERS: podsNeeded = 2; break
        case DrumCapacityUse.THREE_QUARTERS: podsNeeded = 2.33; break
        case DrumCapacityUse.BETWEEN_THREE_QUARTERS_AND_NINE_TENTHS: podsNeeded = 2.66; break
        case DrumCapacityUse.NINE_TENTHS: podsNeeded = 3; break
        default: break
        }

        // Adjust amount based on how much dirt (stains, soil, sweat, etc.) has been accumulated in the laundry.
        switch self.dirtLevel {
        case DirtLevel.VERY_LOW: podsNeeded -= Detergent.changeInAmountBasedOnSoil * 2; break
        case DirtLevel.LOW: podsNeeded -= Detergent.changeInAmountBasedOnSoil; break
        case DirtLevel.HIGH: podsNeeded += Detergent.changeInAmountBasedOnSoil; break
        case DirtLevel.VERY_HIGH: podsNeeded += Detergent.changeInAmountBasedOnSoil * 2; break
        default: break
        }
        
        // Adjust amount based on the concentration of minerals, including calcium, in the water supply
        switch self.waterHardness {
        case WaterHardness.VERY_SOFT: podsNeeded -= Detergent.changeInAmountBasedOnWaterHardness * 2; break
        case WaterHardness.SOFT: podsNeeded -= Detergent.changeInAmountBasedOnWaterHardness; break
        case WaterHardness.HARD: podsNeeded += Detergent.changeInAmountBasedOnWaterHardness; break
        case WaterHardness.VERY_HARD: podsNeeded += Detergent.changeInAmountBasedOnWaterHardness * 2; break
        default: break
        }
        
        // Make sure the number of pods is at least one.
        if (podsNeeded < 1) { podsNeeded = 1 }
        
        // Return an integer of the number of pods needed.
        return Int(round(podsNeeded))
    }
    
    // Retrieve the output message based on the parameters given in the model.
    public func amountNeededForWashing() -> String {
        
        // If there's too little or too much laundry to wash, display an invalid message.
        if (self.drumCapacityUse == DrumCapacityUse.LESS_THAN_ONE_QUARTER) {
            return Detergent.tooLittleLaundryMessage
        }
        else if (self.drumCapacityUse == DrumCapacityUse.MORE_THAN_NINE_TENTHS) {
            return Detergent.tooMuchLaundryMessage
        }
        else { // Otherwise, get the message for how much detergent needed.
            let numberOfPods: Int = calculateAmountNeededForWashing()
            let firstPartOfMessage: String = "Add \(numberOfPods) pod"
            let secondPartOfMessage: String = numberOfPods != 1 ? "s" : ""
            return "\(firstPartOfMessage)\(secondPartOfMessage) to it."
        }
    }
}