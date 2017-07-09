/*
 DETERGO - Laundry Detergent Calculation App
 Data Model - Powder Detergent
 
 Programmed by Gregory Desrosiers
 
 Start Date: July 5, 2017
 End Date:
 
 File Name: PowderDetergent.swift
 
 Source Code © 2017 Gregory Desrosiers. All rights reserved.
 
 */

import Foundation

public class PowderDetergent: Detergent, DetergentFunc {
    
    // Constructor
    override init(dirtLevel: DirtLevel, drumCapacityUse: DrumCapacityUse, waterHardness: WaterHardness) {
        super.init(dirtLevel: dirtLevel, drumCapacityUse: drumCapacityUse, waterHardness: waterHardness)
    }
    
    // Calculates amount of detergent needed to wash the load. (In this case, fill level for the powder cup)
    func calculateAmountNeededForWashing() -> Int {
        var powderLevel: Float = 1 // Base amount of detergent
        
        // Adjust amount based on how much of the drum the laundry occupies in a linear fashion
        switch self.drumCapacityUse {
        case DrumCapacityUse.BETWEEN_ONE_QUARTER_AND_ONE_HALF: powderLevel = 1.5; break
        case DrumCapacityUse.ONE_HALF: powderLevel = 2; break
        case DrumCapacityUse.BETWEEN_ONE_HALF_AND_THREE_QUARTERS: powderLevel = 2.5; break
        case DrumCapacityUse.THREE_QUARTERS: powderLevel = 3; break
        case DrumCapacityUse.BETWEEN_THREE_QUARTERS_AND_NINE_TENTHS: powderLevel = 3.5; break
        case DrumCapacityUse.NINE_TENTHS: powderLevel = 4; break
        default: break
        }
        
        // Adjust amount based on how much dirt (stains, soil, sweat, etc.) has been accumulated in the laundry.
        switch self.dirtLevel {
        case DirtLevel.VERY_LOW: powderLevel -= Detergent.changeInAmountBasedOnSoil * 2; break
        case DirtLevel.LOW: powderLevel -= Detergent.changeInAmountBasedOnSoil; break
        case DirtLevel.HIGH: powderLevel += Detergent.changeInAmountBasedOnSoil; break
        case DirtLevel.VERY_HIGH: powderLevel += Detergent.changeInAmountBasedOnSoil * 2; break
        default: break
        }
        
        // Adjust amount based on the concentration of minerals, including calcium, in the water supply
        switch self.waterHardness {
        case WaterHardness.VERY_SOFT: powderLevel -= Detergent.changeInAmountBasedOnWaterHardness * 2; break
        case WaterHardness.SOFT: powderLevel -= Detergent.changeInAmountBasedOnWaterHardness; break
        case WaterHardness.HARD: powderLevel += Detergent.changeInAmountBasedOnWaterHardness; break
        case WaterHardness.VERY_HARD: powderLevel += Detergent.changeInAmountBasedOnWaterHardness * 2; break
        default: break
        }
        
        // Make sure the number of pods is at least one.
        if (powderLevel < 1) { powderLevel = 1 }
        
        // Return an integer of the number of pods needed.
        return Int(round(powderLevel))
    }
    
    // Retrieve the output message based on the parameters given in the model.
    public func amountNeededForWashing() -> String {
        
        // If there's too little or too much laundry to wash, display an invalid message.
        // Otherwise, get the message for how much detergent needed.
        switch self.drumCapacityUse {
        case DrumCapacityUse.LESS_THAN_ONE_QUARTER: return Detergent.tooLittleLaundryMessage
        case DrumCapacityUse.MORE_THAN_NINE_TENTHS: return Detergent.tooMuchLaundryMessage
        default: return "Fill the powder measuring cup up to bar \(calculateAmountNeededForWashing())."
        }
    }
}