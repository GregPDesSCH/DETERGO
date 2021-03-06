/*
*
*   DETERGO (Android App)

    Assessment Activity Controller

    This is the default controller that's generated on creating a new activity for the Android app.

    Start Date: August 5, 2017
    End Date: August 15, 2017

    File Name: AssessmentActivity.java

    © 2017 Gregory Desrosiers. All rights reserved.
*
*/

// Package Name
package io.github.gregpdessch.detergo;

// Additional Resources
import android.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.Spinner;

import io.github.gregpdessch.detergo.dataModels.DetergentEnumerations.*;
import io.github.gregpdessch.detergo.dataModels.*;

public class AssessmentActivity extends AppCompatActivity implements View.OnClickListener {

    /* UI Elements */
    // Spinners
    private Spinner typeOfDetergentComboBox;
    private Spinner drumOccupancyComboBox;
    private Spinner dirtLevelComboBox;
    private Spinner waterHardnessLevelComboBox;

    // Calculate Button
    private Button calculateButton;

    // Alert Dialog Builder
    private AlertDialog.Builder builder = null; // Initialized to avoid compilation errors

    /* Activity Properties */
    // Preferences
    private DrumCapacityUse drumOccupancy;
    private DirtLevel dirtLevel;
    private WaterHardness waterHardness;
    private TypeOfDetergent typeOfDetergent;

    // Main Data Unit
    private Detergent detergent;

    // This is what the activity does while the Android SDK starts to create the activity. (Event listener)
    @Override
    protected void onCreate(Bundle savedInstanceState) {

        // Let the Android SDK know that this activity is being created, and that a layout is needed.
        super.onCreate(savedInstanceState);

        // Display the status bar at the top of the screen
        getWindow().requestFeature(Window.FEATURE_ACTION_BAR);
        getSupportActionBar().show();

        // Display the layout of this activity.
        setContentView(R.layout.activity_assessment);


        // Find all of the UI elements that require referencing and event handling by using ID matching.
        typeOfDetergentComboBox = (Spinner) findViewById(R.id.typeOfDetergentComboBox);
        drumOccupancyComboBox = (Spinner) findViewById(R.id.drumOccupancyComboBox);
        dirtLevelComboBox = (Spinner) findViewById(R.id.dirtLevelComboBox);
        waterHardnessLevelComboBox = (Spinner) findViewById(R.id.waterHardnessLevelComboBox);
        calculateButton = (Button) findViewById(R.id.calculateButton);

        // Create the dialog builder
        builder = new AlertDialog.Builder(this);

        // Define an event listener for the calculate button.
        calculateButton.setOnClickListener(this);
    }

    @Override
    public void onClick(View view) {

        if (view == calculateButton) {

            // Retrieve all the specific values from the UI.
            typeOfDetergent = TypeOfDetergent.values()[typeOfDetergentComboBox.getSelectedItemPosition()];
            drumOccupancy = DrumCapacityUse.values()[drumOccupancyComboBox.getSelectedItemPosition()];
            dirtLevel = DirtLevel.values()[dirtLevelComboBox.getSelectedItemPosition()];
            waterHardness = WaterHardness.values()[waterHardnessLevelComboBox.getSelectedItemPosition()];

            // Create the data model instance appropriately.
            if (typeOfDetergent == TypeOfDetergent.POD)
                detergent = new PodDetergent(dirtLevel, drumOccupancy, waterHardness, this);
            else if (typeOfDetergent == TypeOfDetergent.LIQUID)
                detergent = new LiquidDetergent(dirtLevel, drumOccupancy, waterHardness, this);
            else
                detergent = new PowderDetergent(dirtLevel, drumOccupancy, waterHardness, this);


            // Have the dialog hold the OK button that basically closes itself, then set the title appropriately
            // depending on what the laundry load is, among with the respective message, and display it.
            builder.setPositiveButton("OK", null);

            if (detergent.laundryLoad() == LaundryMachine.HAS_TOO_LITTLE_LAUNDRY)
                builder.setTitle(R.string.too_little_laundry_title);
            else if (detergent.laundryLoad() == LaundryMachine.HAS_TOO_MUCH_LAUNDRY)
                builder.setTitle(R.string.too_much_laundry_title);
            else
                builder.setTitle(R.string.detergent_amount_title);

            builder.setMessage(detergent.amountNeededForWashing());

            builder.create().show();

        }
    }
}
