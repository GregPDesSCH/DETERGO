/*
*
*   DETERGO (Android App)

    Data Model - Liquid Detergent

    This is the actual data model class representing laundry detergent that come as a liquid like
    the original Tide.

    Start Date: August 6, 2017
    End Date: August 15, 2017

    File Name: LiquidDetergent.java

    © 2017 Gregory Desrosiers. All rights reserved.
*
*/

// Package Location
package io.github.gregpdessch.detergo.dataModels;

// Additional Resources
import android.content.Context;
import io.github.gregpdessch.detergo.R;

public final class LiquidDetergent extends Detergent {
    // Constructor
    public LiquidDetergent (DetergentEnumerations.DirtLevel dirtLevel, DetergentEnumerations.DrumCapacityUse drumCapacityUse,
                         DetergentEnumerations.WaterHardness waterHardness, Context context) {
        super(dirtLevel, drumCapacityUse, waterHardness, context);
    }

    // Calculates amount of detergent needed to wash the load. (In this case, fill level for measuring cup)
    public int calculateAmountNeededForWashing() {
        float liquidLevel = 1f;

        // Adjust amount based on how much of the drum the laundry occupies in a linear fashion
        switch (drumCapacityUse) {
            case BETWEEN_ONE_QUARTER_AND_ONE_HALF:          liquidLevel = 1.66f; break;
            case ONE_HALF:                                  liquidLevel = 2.33f; break;
            case BETWEEN_ONE_HALF_AND_THREE_QUARTERS:       liquidLevel = 3f; break;
            case THREE_QUARTERS:                            liquidLevel = 3.66f; break;
            case BETWEEN_THREE_QUARTERS_AND_NINE_TENTHS:    liquidLevel = 4.33f; break;
            case NINE_TENTHS:                               liquidLevel = 5f; break;
            default:                                        break;
        }

        // Adjust amount based on how much dirt (stains, soil, sweat, etc.) has been accumulated in the laundry.
        switch (dirtLevel) {
            case VERY_LOW:  liquidLevel -= Detergent.changeInAmountBasedOnSoil * 2; break;
            case LOW:       liquidLevel -= Detergent.changeInAmountBasedOnSoil; break;
            case HIGH:      liquidLevel += Detergent.changeInAmountBasedOnSoil; break;
            case VERY_HIGH: liquidLevel += Detergent.changeInAmountBasedOnSoil * 2; break;
            default:        break;
        }

        // Adjust amount based on the concentration of minerals, including calcium, in the water supply
        switch (waterHardness) {
            case VERY_SOFT:     liquidLevel -= Detergent.changeInAmountBasedOnWaterHardness * 2; break;
            case SOFT:          liquidLevel -= Detergent.changeInAmountBasedOnWaterHardness; break;
            case HARD:          liquidLevel += Detergent.changeInAmountBasedOnWaterHardness; break;
            case VERY_HARD:     liquidLevel += Detergent.changeInAmountBasedOnWaterHardness * 2; break;
            default:            break;
        }

        // Make sure the number of pods is at least one.
        if (liquidLevel < 1f) liquidLevel = 1f;
        return Math.round(liquidLevel);
    }

    // Retrieve the output message based on the parameters given in the model.
    public String amountNeededForWashing() {
        // If there's too little or too much laundry to wash, display an invalid message.
        // Otherwise, get the message for how much detergent needed.
        switch (this.drumCapacityUse) {
            case LESS_THAN_ONE_QUARTER:
                return context.getString(R.string.too_little_laundry_explanation_message);
            case MORE_THAN_NINE_TENTHS:
                return context.getString(R.string.too_much_laundry_explanation_message);
            default:
                return "Fill the measuring cup up to bar " + calculateAmountNeededForWashing() + ".";
        }
    }
}
