/*
*
*   DETERGO (Android App)

    Detergent Class

    This is the initial model for the kind of detergent that's to be referenced upon in the app itself.

    Start Date: August 6, 2017
    End Date:

    File Name: DetergentFunctions.java

    © 2017 Gregory Desrosiers. All rights reserved.
*
*/

// Package Location
package io.github.gregpdessch.detergo.dataModels;


public abstract class Detergent
{
    /* Constants */
    static final float changeInAmountBasedOnSoil = 0.25f;
    static final float changeInAmountBasedOnWaterHardness = 0.2f;

    /* Data Fields */
    DetergentEnumerations.DirtLevel dirtLevel;
    DetergentEnumerations.DrumCapacityUse drumCapacityUse;
    DetergentEnumerations.WaterHardness waterHardness;

    /* Defined Constructor & Functions */

    // Main Constructor
    Detergent(DetergentEnumerations.DirtLevel dirtLevel, DetergentEnumerations.DrumCapacityUse drumCapacityUse,
              DetergentEnumerations.WaterHardness waterHardness) {
        this.dirtLevel = dirtLevel;
        this.drumCapacityUse = drumCapacityUse;
        this.waterHardness = waterHardness;
    }

    // Returns a flag on whether or not the amount of laundry is within the manufacturer's
    // recommended limits for a wash cycle.
    DetergentEnumerations.LaundryMachine laundryLoad() {
        switch (this.drumCapacityUse) {
            case LESS_THAN_ONE_QUARTER:
                return DetergentEnumerations.LaundryMachine.HAS_TOO_LITTLE_LAUNDRY;
            case MORE_THAN_NINE_TENTHS:
                return DetergentEnumerations.LaundryMachine.HAS_TOO_MUCH_LAUNDRY;
            default:
                return DetergentEnumerations.LaundryMachine.IS_OK_WITH_LAUNDRY_LOAD;
        }
    }

    /* Abstracted Functions */
    public abstract int calculateAmountNeededForWashing();
    public abstract String amountNeededForWashing();
}
