/*
*
*   DETERGO (Android App)

    Assessment Activity Controller

    This is the default controller that's generated on creating a new activity for the Android app.

    Start Date: August 5, 2017
    End Date:

    File Name: AssessmentActivity.java

    © 2017 Gregory Desrosiers. All rights reserved.
*
*/

// Package Name
package io.github.gregpdessch.detergo;

// Additional Resources
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Spinner;

import io.github.gregpdessch.detergo.dataModels.DetergentEnumerations.*;

public class AssessmentActivity extends AppCompatActivity implements View.OnClickListener {

    /* UI Elements */
    // Spinners
    private Spinner typeOfDetergentComboBox;
    private Spinner drumOccupancyComboBox;
    private Spinner dirtLevelComboBox;
    private Spinner waterHardnessLevelComboBox;

    // Calculate Button
    private Button calculateButton;

    /* Activity Properties */
    private DrumCapacityUse drumOccupancy;
    private DirtLevel dirtLevel;
    private WaterHardness waterHardness;


    // This is what the activity does while the Android SDK starts to create the activity. (Event listener)
    @Override
    protected void onCreate(Bundle savedInstanceState) {

        // Let the Android SDK know that this activity is being created, and that a layout is needed.
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_assessment);

        // Find all of the UI elements that require referencing and event handling by using ID matching.
        typeOfDetergentComboBox = (Spinner) findViewById(R.id.typeOfDetergentComboBox);
        drumOccupancyComboBox = (Spinner) findViewById(R.id.drumOccupancyComboBox);
        dirtLevelComboBox = (Spinner) findViewById(R.id.dirtLevelComboBox);
        waterHardnessLevelComboBox = (Spinner) findViewById(R.id.waterHardnessLevelComboBox);
        calculateButton = (Button) findViewById(R.id.calculateButton);

        // Define an event listener for the calculate button.
        calculateButton.setOnClickListener(this);
    }

    @Override
    public void onClick(View view) {
        if (view == calculateButton) {
            System.out.println("Received the click from the calculate button.");
            Log.i("Button listener", "Received the click from the calculate button.");
        }
    }

}
