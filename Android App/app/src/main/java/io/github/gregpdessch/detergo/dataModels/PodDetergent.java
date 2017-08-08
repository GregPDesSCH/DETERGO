/*
*
*   DETERGO (Android App)

    Data Model - Pod Detergent

    This is the actual data model class representing laundry detergent that come in pods, like Tide Pods.

    Start Date: August 6, 2017
    End Date:

    File Name: PodDetergent.java

    © 2017 Gregory Desrosiers. All rights reserved.
*
*/

// Package Location
package io.github.gregpdessch.detergo.dataModels;

public final class PodDetergent extends Detergent
{
    // Constructor
    public PodDetergent (DetergentEnumerations.DirtLevel dirtLevel, DetergentEnumerations.DrumCapacityUse drumCapacityUse,
                  DetergentEnumerations.WaterHardness waterHardness)
    {
        super(dirtLevel, drumCapacityUse, waterHardness);
    }

    // Calculates amount of detergent needed to wash the load. (In this case, number of pods)
    public int calculateAmountNeededForWashing()
    {
        float podsNeeded = 1f;

        // Adjust amount based on how much of the drum the laundry occupies in a linear fashion
        switch (drumCapacityUse) {
            case BETWEEN_ONE_QUARTER_AND_ONE_HALF:          podsNeeded = 1.66f; break;
            case ONE_HALF:                                  podsNeeded = 1.66f; break;
            case BETWEEN_ONE_HALF_AND_THREE_QUARTERS:       podsNeeded = 2f; break;
            case THREE_QUARTERS:                            podsNeeded = 2.33f; break;
            case BETWEEN_THREE_QUARTERS_AND_NINE_TENTHS:    podsNeeded = 2.66f; break;
            case NINE_TENTHS:                               podsNeeded = 3f; break;
            default:                                        break;
        }

        // Adjust amount based on how much dirt (stains, soil, sweat, etc.) has been accumulated in the laundry.
        switch(dirtLevel) {
            case VERY_LOW:  podsNeeded -= Detergent.changeInAmountBasedOnSoil * 2; break;
            case LOW:       podsNeeded -= Detergent.changeInAmountBasedOnSoil; break;
            case HIGH:      podsNeeded += Detergent.changeInAmountBasedOnSoil; break;
            case VERY_HIGH: podsNeeded += Detergent.changeInAmountBasedOnSoil * 2; break;
            default:        break;
        }

        // Adjust amount based on the concentration of minerals, including calcium, in the water supply
        switch(waterHardness) {
            case VERY_SOFT: podsNeeded -= Detergent.changeInAmountBasedOnWaterHardness * 2; break;
            case SOFT:      podsNeeded -= Detergent.changeInAmountBasedOnWaterHardness; break;
            case HARD:      podsNeeded += Detergent.changeInAmountBasedOnWaterHardness; break;
            case VERY_HARD: podsNeeded += Detergent.changeInAmountBasedOnWaterHardness * 2; break;
            default:         break;
        }

        // Make sure the number of pods is at least one.
        if (podsNeeded < 1f) podsNeeded = 1f;
        return Math.round(podsNeeded);
    }

    // Retrieve the output message based on the parameters given in the model.
    public String amountNeededForWashing()
    {
        return null;
    }
}