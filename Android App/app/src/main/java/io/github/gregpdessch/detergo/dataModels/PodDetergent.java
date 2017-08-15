/*
*
*   DETERGO (Android App)

    Data Model - Pod Detergent

    This is the actual data model class representing laundry detergent that come in pods, like Tide Pods.

    Start Date: August 6, 2017
    End Date: August 15, 2017

    File Name: PodDetergent.java

    © 2017 Gregory Desrosiers. All rights reserved.
*
*/

// Package Location
package io.github.gregpdessch.detergo.dataModels;

// Additional Resources
import android.content.Context;
import io.github.gregpdessch.detergo.R;

public final class PodDetergent extends Detergent {
    // Constructor
    public PodDetergent (DetergentEnumerations.DirtLevel dirtLevel, DetergentEnumerations.DrumCapacityUse drumCapacityUse,
                  DetergentEnumerations.WaterHardness waterHardness, Context context) {
        super(dirtLevel, drumCapacityUse, waterHardness, context);
    }

    // Calculates amount of detergent needed to wash the load. (In this case, number of pods)
    public int calculateAmountNeededForWashing() {
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
    public String amountNeededForWashing() {

        // If there's too little or too much laundry to wash, display an invalid message.
        // Otherwise, get the message for how much detergent needed.
        switch (this.drumCapacityUse) {
            case LESS_THAN_ONE_QUARTER:
                return context.getString(R.string.too_little_laundry_explanation_message);
            case MORE_THAN_NINE_TENTHS:
                return context.getString(R.string.too_much_laundry_explanation_message);
            default:
                int numberOfPodsNeeded = calculateAmountNeededForWashing();
                return "Add " + numberOfPodsNeeded + " pod" + (numberOfPodsNeeded != 1 ? "s " : " ") +
                        "to the load.";

        }
    }
}
