/*
*
*   DETERGO (Android App)

    Detergent Enumerations

    These are for the different possible settings the user can set to which the data models understand.

    Start Date: August 6, 2017
    End Date: August 15, 2017

    File Name: DetergentFunctions.java

    © 2017 Gregory Desrosiers. All rights reserved.
*
*/

// Package Location
package io.github.gregpdessch.detergo.dataModels;

// Enum Wrapper
public final class DetergentEnumerations {

    /* Enum for type of detergent */
    public enum TypeOfDetergent {
        POD, LIQUID, POWDER
    }

    /* Enum for how much dirt or soil the laundry has */
    public enum DirtLevel {
        VERY_LOW, LOW, MEDIUM, HIGH, VERY_HIGH
    }

    /*
        Enum for how hard the water is depending on the concentration of minerals in the water
        http://www.water-research.net/index.php/water-treatment/tools/hard-water-hardness
    */
    public enum WaterHardness {
        VERY_SOFT,  // 0 - 17.1 ppm
        SOFT,       // 17.1 - 60.0 ppm
        AVERAGE,    // 60 - 120 ppm
        HARD,       // 120 - 180 ppm
        VERY_HARD   // +180 ppm
    }

    /* Enum for how much drum volume is used */
    public enum DrumCapacityUse {
        LESS_THAN_ONE_QUARTER, ONE_QUARTER, BETWEEN_ONE_QUARTER_AND_ONE_HALF, ONE_HALF, BETWEEN_ONE_HALF_AND_THREE_QUARTERS,
        THREE_QUARTERS, BETWEEN_THREE_QUARTERS_AND_NINE_TENTHS, NINE_TENTHS, MORE_THAN_NINE_TENTHS
    }

    /* A flag to tell the frontend on what the helper text should be below the main text. */
    public enum LaundryMachine {
        IS_OK_WITH_LAUNDRY_LOAD, HAS_TOO_LITTLE_LAUNDRY, HAS_TOO_MUCH_LAUNDRY
    }
}
