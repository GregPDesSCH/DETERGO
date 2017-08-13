/*
*
*   DETERGO (Android App)

    Data Model - Powder Detergent

    This is the actual data model class representing laundry detergent that come in as a powder.

    Start Date: August 6, 2017
    End Date:

    File Name: PowderDetergent.java

    © 2017 Gregory Desrosiers. All rights reserved.
*
*/

// Package Location
package io.github.gregpdessch.detergo.dataModels;

import android.content.Context;

import io.github.gregpdessch.detergo.R;

public final class PowderDetergent extends Detergent
{
    // Constructor
    public PowderDetergent (DetergentEnumerations.DirtLevel dirtLevel, DetergentEnumerations.DrumCapacityUse drumCapacityUse,
                            DetergentEnumerations.WaterHardness waterHardness, Context context)
    {
        super(dirtLevel, drumCapacityUse, waterHardness, context);
    }

    // Calculates amount of detergent needed to wash the load. (In this case, fill level for the powder cup)
    public int calculateAmountNeededForWashing()
    {
        float powderLevel = 1f;

        // Adjust amount based on how much of the drum the laundry occupies in a linear fashion
        switch (drumCapacityUse) {
            case BETWEEN_ONE_QUARTER_AND_ONE_HALF:          powderLevel = 1.5f; break;
            case ONE_HALF:                                  powderLevel = 2f; break;
            case BETWEEN_ONE_HALF_AND_THREE_QUARTERS:       powderLevel = 2.5f; break;
            case THREE_QUARTERS:                            powderLevel = 3f; break;
            case BETWEEN_THREE_QUARTERS_AND_NINE_TENTHS:    powderLevel = 3.5f; break;
            case NINE_TENTHS:                               powderLevel = 4f; break;
            default:                                        break;
        }

        // Adjust amount based on how much dirt (stains, soil, sweat, etc.) has been accumulated in the laundry.
        switch (dirtLevel) {
            case VERY_LOW:  powderLevel -= Detergent.changeInAmountBasedOnSoil * 2; break;
            case LOW:       powderLevel -= Detergent.changeInAmountBasedOnSoil; break;
            case HIGH:      powderLevel += Detergent.changeInAmountBasedOnSoil; break;
            case VERY_HIGH: powderLevel += Detergent.changeInAmountBasedOnSoil * 2; break;
            default:        break;
        }

        // Adjust amount based on the concentration of minerals, including calcium, in the water supply
        switch (waterHardness) {
            case VERY_SOFT: powderLevel -= Detergent.changeInAmountBasedOnWaterHardness * 2; break;
            case SOFT:      powderLevel -= Detergent.changeInAmountBasedOnWaterHardness; break;
            case HARD:      powderLevel += Detergent.changeInAmountBasedOnWaterHardness; break;
            case VERY_HARD: powderLevel += Detergent.changeInAmountBasedOnWaterHardness * 2; break;
            default:        break;
        }


        // Make sure the number of pods is at least one.
        if (powderLevel < 1f) powderLevel = 1f;
        return Math.round(powderLevel);
    }

    // Retrieve the output message based on the parameters given in the model.
    public String amountNeededForWashing()
    {
        // TODO: Fix the bug that this function creates where an exception is thrown for not finding a resource.
        // If there's too little or too much laundry to wash, display an invalid message.
        // Otherwise, get the message for how much detergent needed.
        switch (this.drumCapacityUse) {
            case LESS_THAN_ONE_QUARTER:
                return context.getString(R.string.too_little_laundry_explanation_message);
            case MORE_THAN_NINE_TENTHS:
                return context.getString(R.string.too_much_laundry_explanation_message);
            default:
                return "Fill the powder measuring cup up to bar " + calculateAmountNeededForWashing() + ".";
        }
    }
}
