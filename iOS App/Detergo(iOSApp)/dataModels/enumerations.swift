/*
 DETERGO - Laundry Detergent Calculation App
 Data Model - Enumerations
 
 Programmed by Gregory Desrosiers
 
 Start Date: July 3, 2017
 End Date: July 9, 2017
 
 File Name: enumerations.swift
 
 Source Code © 2017 Gregory Desrosiers. All rights reserved.
 
 */

import Foundation

// Enum for how much dirt or soil the laundry has
enum DirtLevel: Int {
    case VERY_LOW
    case LOW
    case MEDIUM
    case HIGH
    case VERY_HIGH
}

/* 
    Enum for how hard the water is depending on the concentration of minerals in the water
    http://www.water-research.net/index.php/water-treatment/tools/hard-water-hardness
 */
enum WaterHardness: Int {
    case VERY_SOFT  // 0 - 17.1 ppm
    case SOFT       // 17.1 - 60.0 ppm
    case AVERAGE    // 60 - 120 ppm
    case HARD       // 120 - 180 ppm
    case VERY_HARD  // +180 ppm
}

// Enum for how much drum volume is used
enum DrumCapacityUse: Int {
    case LESS_THAN_ONE_QUARTER
    case ONE_QUARTER
    case BETWEEN_ONE_QUARTER_AND_ONE_HALF
    case ONE_HALF
    case BETWEEN_ONE_HALF_AND_THREE_QUARTERS
    case THREE_QUARTERS
    case BETWEEN_THREE_QUARTERS_AND_NINE_TENTHS
    case NINE_TENTHS
    case MORE_THAN_NINE_TENTHS
}

// A flag to tell the frontend on what the helper text should be below the main text.
enum LaundryMachine {
    case IS_OK_WITH_LAUNDRY_LOAD
    case HAS_TOO_LITTLE_LAUNDRY
    case HAS_TOO_MUCH_LAUNDRY
}