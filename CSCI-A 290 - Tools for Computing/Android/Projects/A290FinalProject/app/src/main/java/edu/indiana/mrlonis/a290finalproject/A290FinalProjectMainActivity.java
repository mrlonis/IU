package edu.indiana.mrlonis.a290finalproject;

/**
 * A290FinalProjectMainActivity.java
 *
 * Contains the Java code for the Primary Activity in this project
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to activity_a290_final_project_main.xml layout file
 */

import android.os.Bundle;
import android.support.design.widget.NavigationView;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;

public class A290FinalProjectMainActivity extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener {

    NavigationView navigationView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_a290_final_project_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.setDrawerListener(toggle);
        toggle.syncState();

        navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

        Fragment fragment = new homePageFragment();
        FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
        ft.replace(R.id.mainFrame, fragment);
        ft.commit();

        navigationView.setCheckedItem(navigationView.getMenu().getItem(0).getItemId());
        getSupportActionBar().setTitle("Home Page");
    }

    @Override
    public void onBackPressed() {
        Fragment fragment;
        FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            if (Constants.previousFrag.equals("Home")) {
                fragment = new homePageFragment();
                ft.replace(R.id.mainFrame, fragment);
                ft.commit();
                getSupportActionBar().setTitle("Home Page");
                Constants.previousFrag = "";
                Constants.currentFrag = "Home";
            } else if (Constants.previousFrag.equals("Resume")) {
                fragment = new resumeFragment();
                ft.replace(R.id.mainFrame, fragment);
                ft.commit();
                getSupportActionBar().setTitle("Resume");
                Constants.previousFrag = "";
                Constants.currentFrag = "Resume";
            } else if (Constants.previousFrag.equals("C211")) {
                fragment = new csciC211Fragment();
                ft.replace(R.id.mainFrame, fragment);
                ft.commit();
                getSupportActionBar().setTitle("CSCI-C 211");
                Constants.previousFrag = "";
                Constants.currentFrag = "C211";
            } else if (Constants.previousFrag.equals("C212")) {
                fragment = new csciC212Fragment();
                ft.replace(R.id.mainFrame, fragment);
                ft.commit();
                getSupportActionBar().setTitle("CSCI-C 212");
                Constants.previousFrag = "";
                Constants.currentFrag = "C212";
            } else if (Constants.previousFrag.equals("C343")) {
                fragment = new csciC343Fragment();
                ft.replace(R.id.mainFrame, fragment);
                ft.commit();
                getSupportActionBar().setTitle("CSCI-C 343");
                Constants.previousFrag = "";
                Constants.currentFrag = "C343";
            } else if (Constants.previousFrag.equals("C291")) {
                fragment = new csciC291Fragment();
                ft.replace(R.id.mainFrame, fragment);
                ft.commit();
                getSupportActionBar().setTitle("CSCI-C 291");
                Constants.previousFrag = "";
                Constants.currentFrag = "C291";
            } else if (Constants.previousFrag.equals("C")) {
                fragment = new csciA290CFragment();
                ft.replace(R.id.mainFrame, fragment);
                ft.commit();
                getSupportActionBar().setTitle("CSCI-A 290: C");
                Constants.previousFrag = "";
                Constants.currentFrag = "C";
            } else if (Constants.previousFrag.equals("Windows")) {
                fragment = new csciA290WindowsFragment();
                ft.replace(R.id.mainFrame, fragment);
                ft.commit();
                getSupportActionBar().setTitle("CSCI-A 290: Windows");
                Constants.previousFrag = "";
                Constants.currentFrag = "Windows";
            } else if (Constants.previousFrag.equals("Android")) {
                fragment = new csciA290AndroidFragment();
                ft.replace(R.id.mainFrame, fragment);
                ft.commit();
                getSupportActionBar().setTitle("CSCI-A 290: Android");
                Constants.previousFrag = "";
                Constants.currentFrag = "Android";
            } else if (Constants.previousFrag.equals("I101")) {
                fragment = new infoI101Fragment();
                ft.replace(R.id.mainFrame, fragment);
                ft.commit();
                getSupportActionBar().setTitle("INFO-I 101");
                Constants.previousFrag = "";
                Constants.currentFrag = "I101";
            } else if (Constants.previousFrag.equals("Settings")) {
                fragment = new settingsFragment();
                ft.replace(R.id.mainFrame, fragment);
                ft.commit();
                getSupportActionBar().setTitle("Settings");
                Constants.previousFrag = Constants.currentFrag;
                Constants.currentFrag = "Settings";
            } else if (Constants.previousFrag.equals("")) {
                super.onBackPressed();
            }
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.a290_final_project_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        Fragment fragment;
        FragmentTransaction ft = getSupportFragmentManager().beginTransaction();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            fragment = new settingsFragment();
            ft.replace(R.id.mainFrame, fragment);
            ft.commit();
            getSupportActionBar().setTitle("Settings");
            Constants.previousFrag = Constants.currentFrag;
            Constants.currentFrag = "Settings";
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        int id = item.getItemId();
        Fragment fragment;
        FragmentTransaction ft = getSupportFragmentManager().beginTransaction();

        if (id == R.id.nav_home) {
            fragment = new homePageFragment();
            ft.replace(R.id.mainFrame, fragment);
            ft.commit();
            getSupportActionBar().setTitle("Home Page");
            Constants.previousFrag = Constants.currentFrag;
            Constants.currentFrag = "Home";
        } else if (id == R.id.nav_resume) {
            fragment = new resumeFragment();
            ft.replace(R.id.mainFrame, fragment);
            ft.commit();
            getSupportActionBar().setTitle("Resume");
            Constants.previousFrag = Constants.currentFrag;
            Constants.currentFrag = "Resume";
        } else if (id == R.id.nav_csci_c211) {
            fragment = new csciC211Fragment();
            ft.replace(R.id.mainFrame, fragment);
            ft.commit();
            getSupportActionBar().setTitle("CSCI-C 211");
            Constants.previousFrag = Constants.currentFrag;
            Constants.currentFrag = "C211";
        } else if (id == R.id.nav_csci_c212) {
            fragment = new csciC212Fragment();
            ft.replace(R.id.mainFrame, fragment);
            ft.commit();
            getSupportActionBar().setTitle("CSCI-C 212");
            Constants.previousFrag = Constants.currentFrag;
            Constants.currentFrag = "C212";
        } else if (id == R.id.nav_csci_c343) {
            fragment = new csciC343Fragment();
            ft.replace(R.id.mainFrame, fragment);
            ft.commit();
            getSupportActionBar().setTitle("CSCI-C 343");
            Constants.previousFrag = Constants.currentFrag;
            Constants.currentFrag = "C343";
        } else if (id == R.id.nav_csci_c291) {
            fragment = new csciC291Fragment();
            ft.replace(R.id.mainFrame, fragment);
            ft.commit();
            getSupportActionBar().setTitle("CSCI-C 291");
            Constants.previousFrag = Constants.currentFrag;
            Constants.currentFrag = "C291";
        } else if (id == R.id.nav_csci_a290_c) {
            fragment = new csciA290CFragment();
            ft.replace(R.id.mainFrame, fragment);
            ft.commit();
            getSupportActionBar().setTitle("CSCI-A 290: C");
            Constants.previousFrag = Constants.currentFrag;
            Constants.currentFrag = "C";
        } else if (id == R.id.nav_csci_a290_windows) {
            fragment = new csciA290WindowsFragment();
            ft.replace(R.id.mainFrame, fragment);
            ft.commit();
            getSupportActionBar().setTitle("CSCI-A 290: Windows");
            Constants.previousFrag = Constants.currentFrag;
            Constants.currentFrag = "Windows";
        } else if (id == R.id.nav_csci_a290_android) {
            fragment = new csciA290AndroidFragment();
            ft.replace(R.id.mainFrame, fragment);
            ft.commit();
            getSupportActionBar().setTitle("CSCI-A 290: Android");
            Constants.previousFrag = Constants.currentFrag;
            Constants.currentFrag = "Android";
        } else if (id == R.id.nav_info_i101) {
            fragment = new infoI101Fragment();
            ft.replace(R.id.mainFrame, fragment);
            ft.commit();
            getSupportActionBar().setTitle("INFO-I 101");
            Constants.previousFrag = Constants.currentFrag;
            Constants.currentFrag = "I101";
        }

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }
}
