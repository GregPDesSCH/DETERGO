/*
 DETERGO - Laundry Detergent Calculation App
 Data Model - Liquid Detergent
 
 Programmed by Gregory Desrosiers
 
 Start Date: July 5, 2017
 End Date: July 9, 2017
 
 File Name: LiquidDetergent.swift
 
 Source Code © 2017 Gregory Desrosiers. All rights reserved.
 
 */

import Foundation

public class LiquidDetergent: Detergent, DetergentFunc {
    
    // Constructor
    override init(dirtLevel: DirtLevel, drumCapacityUse: DrumCapacityUse, waterHardness: WaterHardness) {
        super.init(dirtLevel: dirtLevel, drumCapacityUse: drumCapacityUse, waterHardness: waterHardness)
    }
    
    // Calculates amount of detergent needed to wash the load. (In this case, fill level for measuring cup)
    func calculateAmountNeededForWashing() -> Int {
        var liquidLevel: Float = 1 // Base amount of detergent
        
        // Adjust amount based on how much of the drum the laundry occupies in a linear fashion
        switch self.drumCapacityUse {
        case DrumCapacityUse.BETWEEN_ONE_QUARTER_AND_ONE_HALF: liquidLevel = 1.66; break
        case DrumCapacityUse.ONE_HALF: liquidLevel = 2.33; break
        case DrumCapacityUse.BETWEEN_ONE_HALF_AND_THREE_QUARTERS: liquidLevel = 3; break
        case DrumCapacityUse.THREE_QUARTERS: liquidLevel = 3.66; break
        case DrumCapacityUse.BETWEEN_THREE_QUARTERS_AND_NINE_TENTHS: liquidLevel = 4.33; break
        case DrumCapacityUse.NINE_TENTHS: liquidLevel = 5; break
        default: break
        }
        
        // Adjust amount based on how much dirt (stains, soil, sweat, etc.) has been accumulated in the laundry.
        switch self.dirtLevel {
        case DirtLevel.VERY_LOW: liquidLevel -= Detergent.changeInAmountBasedOnSoil * 2; break
        case DirtLevel.LOW: liquidLevel -= Detergent.changeInAmountBasedOnSoil; break
        case DirtLevel.HIGH: liquidLevel += Detergent.changeInAmountBasedOnSoil; break
        case DirtLevel.VERY_HIGH: liquidLevel += Detergent.changeInAmountBasedOnSoil * 2; break
        default: break
        }
        
        // Adjust amount based on the concentration of minerals, including calcium, in the water supply
        switch self.waterHardness {
        case WaterHardness.VERY_SOFT: liquidLevel -= Detergent.changeInAmountBasedOnWaterHardness * 2; break
        case WaterHardness.SOFT: liquidLevel -= Detergent.changeInAmountBasedOnWaterHardness; break
        case WaterHardness.HARD: liquidLevel += Detergent.changeInAmountBasedOnWaterHardness; break
        case WaterHardness.VERY_HARD: liquidLevel += Detergent.changeInAmountBasedOnWaterHardness * 2; break
        default: break
        }
        
        // Make sure the number of pods is at least one.
        if (liquidLevel < 1) { liquidLevel = 1 }
        
        // Return an integer of the number of pods needed.
        return Int(round(liquidLevel))
    }
    
    // Retrieve the output message based on the parameters given in the model.
    public func amountNeededForWashing() -> String {
        
        // If there's too little or too much laundry to wash, display an invalid message.
        // Otherwise, get the message for how much detergent needed.
        switch self.drumCapacityUse {
        case DrumCapacityUse.LESS_THAN_ONE_QUARTER: return Detergent.tooLittleLaundryMessage
        case DrumCapacityUse.MORE_THAN_NINE_TENTHS: return Detergent.tooMuchLaundryMessage
        default: return "Fill the measuring cup up to bar \(calculateAmountNeededForWashing())."
        }
    }
}