/*
 DETERGO - Laundry Detergent Calculation App
 Base Data Model - Detergent
 
 Programmed by Gregory Desrosiers
 
 Start Date: July 3, 2017
 End Date: July 9, 2017
 
 File Name: Detergent.swift
 
 Source Code © 2017 Gregory Desrosiers. All rights reserved.
 
 */

import Foundation

// Interface to implement the following functions
protocol DetergentFunc {
    func calculateAmountNeededForWashing() -> Int
    func amountNeededForWashing() -> String
}

public class Detergent: CustomStringConvertible {
    
    /* Constants */
    // How much detergent can we add or take out based on soil level
    static let changeInAmountBasedOnSoil: Float = 0.25
    
    // How much detergent can we add or take out based on water hardness
    static let changeInAmountBasedOnWaterHardness: Float = 0.2
    
    // Message for too little laundry
    static let tooLittleLaundryMessage: String = "Too little laundry to wash!"
    static let tooMuchLaundryMessage: String = "Too much laundry to wash!"
    
    
    // Explanation messages for the labels in the views
    static let tooLittleLaundryExplanationMessage: String = "By doing this, you'll waste some water; wait until you have enough laundry to fill at least one quarter of the machine's washing drum."
    
    static let tooMuchLaundryExplanationMessage: String = "The machine cannot wash the load in one cycle; consider splitting the load into two or more as needed so that they are washed properly. Use this for the partial loads."
    
    /* Data Members */
    var dirtLevel: DirtLevel
    var drumCapacityUse: DrumCapacityUse
    var waterHardness: WaterHardness
    
    /* Description Property (Swift counterpart of toString() method in Java classes) */
    public var description: String { return "Detergent -- Dirt Level:\(dirtLevel), Drum Capacity Use: \(drumCapacityUse), Water Hardness: \(waterHardness)" }
    
    /* Main Constructor */
    init(dirtLevel: DirtLevel, drumCapacityUse: DrumCapacityUse, waterHardness: WaterHardness) {
        self.dirtLevel = dirtLevel
        self.drumCapacityUse = drumCapacityUse
        self.waterHardness = waterHardness
    }
    
    // Returns a flag on whether or not the amount of laundry is within the manufacturer's
    // recommended limits for a wash cycle.
    func laundryLoad() -> LaundryMachine {
        switch self.drumCapacityUse {
        case DrumCapacityUse.LESS_THAN_ONE_QUARTER: return LaundryMachine.HAS_TOO_LITTLE_LAUNDRY
        case DrumCapacityUse.MORE_THAN_NINE_TENTHS: return LaundryMachine.HAS_TOO_MUCH_LAUNDRY
        default: return LaundryMachine.IS_OK_WITH_LAUNDRY_LOAD
        }
    }
}

