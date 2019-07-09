package edu.indiana.mrlonis.a290finalproject;

/**
 * homePageFragment.java
 *
 * Contains the Java code for the Home Page Fragment
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to fragment_home_page.xml layout file
 */

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;


/**
 * A simple {@link Fragment} subclass.
 */
public class homePageFragment extends Fragment {

    ScrollView homeScrollView;
    LinearLayout homeLinearLayout;
    TextView aboutMe;
    TextView aboutMeDescription;
    TextView aboutThisApp;
    TextView aboutThisAppDescription;

    public homePageFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_home_page, container, false);

        /**
         * Link Views from XML
         */
        homeScrollView = (ScrollView) view.findViewById(R.id.scroll_view_home);
        homeLinearLayout = (LinearLayout) view.findViewById(R.id.linear_layout_home);
        aboutMe = (TextView) view.findViewById(R.id.aboutMe);
        aboutMeDescription = (TextView) view.findViewById(R.id.aboutMeDescription);
        aboutThisApp = (TextView) view.findViewById(R.id.aboutThisApp);
        aboutThisAppDescription = (TextView) view.findViewById(R.id.aboutThisAppDescription);

        /**
         * Set Background Color/Text Color
         */
        if (Constants.backgroundColor == R.id.red) {
            homeScrollView.setBackgroundColor(getResources().getColor(R.color.red));
            aboutMe.setTextColor(getResources().getColor(R.color.white));
            aboutMeDescription.setTextColor(getResources().getColor(R.color.white));
            aboutThisApp.setTextColor(getResources().getColor(R.color.white));
            aboutThisAppDescription.setTextColor(getResources().getColor(R.color.white));
        } else if (Constants.backgroundColor == R.id.black) {
            homeScrollView.setBackgroundColor(getResources().getColor(R.color.black));
            aboutMe.setTextColor(getResources().getColor(R.color.white));
            aboutMeDescription.setTextColor(getResources().getColor(R.color.white));
            aboutThisApp.setTextColor(getResources().getColor(R.color.white));
            aboutThisAppDescription.setTextColor(getResources().getColor(R.color.white));
        }else if (Constants.backgroundColor == R.id.blue) {
            homeScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            aboutMe.setTextColor(getResources().getColor(R.color.black));
            aboutMeDescription.setTextColor(getResources().getColor(R.color.black));
            aboutThisApp.setTextColor(getResources().getColor(R.color.black));
            aboutThisAppDescription.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.green) {
            homeScrollView.setBackgroundColor(getResources().getColor(R.color.green));
            aboutMe.setTextColor(getResources().getColor(R.color.black));
            aboutMeDescription.setTextColor(getResources().getColor(R.color.black));
            aboutThisApp.setTextColor(getResources().getColor(R.color.black));
            aboutThisAppDescription.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.normal) {
            homeScrollView.setBackgroundColor(getResources().getColor(R.color.normal));
            aboutMe.setTextColor(getResources().getColor(R.color.black));
            aboutMeDescription.setTextColor(getResources().getColor(R.color.black));
            aboutThisApp.setTextColor(getResources().getColor(R.color.black));
            aboutThisAppDescription.setTextColor(getResources().getColor(R.color.black));
        }

        return view;
    }

}
