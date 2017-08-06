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

public class AssessmentActivity extends AppCompatActivity {

    // This is what the activity does while the Android SDK starts to create the activity. (Event listener)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_assessment);
    }
}
