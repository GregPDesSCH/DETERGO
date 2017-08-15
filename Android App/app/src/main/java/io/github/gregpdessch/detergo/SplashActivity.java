/*
*
*   DETERGO (Android App)

    Splash Activity

    This controller manages the duration of the splash screen and terminates itself for the main
    activity to come up when a delay has gone by.

    Start Date: August 13, 2017
    End Date: August 15, 2017

    File Name: DetergentFunctions.java

    © 2017 Gregory Desrosiers. All rights reserved.
*
*/

// Package Location
package io.github.gregpdessch.detergo;

// Additional Resources
import android.content.Intent;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Window;

public class SplashActivity extends AppCompatActivity {

    // From https://stackoverflow.com/questions/5486789/how-do-i-make-a-splash-screen
    /* How long the splash screen stays before the main activity is loaded */
    private final int SPLASH_SCREEN_DURATION = 4000;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Hide the status bar at the top of the screen
        getWindow().requestFeature(Window.FEATURE_ACTION_BAR);
        getSupportActionBar().hide();

        // Display the layout of this activity.
        setContentView(R.layout.activity_splash);

        // Bind an event listener to have the main activity replace this activity after
        // the entire duration has elapsed, then run it immediately.
        new Handler().postDelayed(new Runnable(){
            @Override
            public void run() {
                /* Create an Intent that will start the Menu-Activity. */
                Intent mainIntent = new Intent(SplashActivity.this, AssessmentActivity.class);
                SplashActivity.this.startActivity(mainIntent);
                SplashActivity.this.finish();
            }
        }, SPLASH_SCREEN_DURATION);
    }
}
