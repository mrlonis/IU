package edu.indiana.mrlonis.a290finalproject;

/**
 * infoI101Fragment.java
 *
 * Contains the Java code for the INFO-I 101 Fragment
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to fragment_info_i101.xml layout file
 */

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
/**
 * Custom Imports
 */
import android.net.Uri;
import android.content.Intent;
import android.widget.Button;
import android.widget.ScrollView;
import android.widget.TextView;

/**
 * A simple {@link Fragment} subclass.
 */
public class infoI101Fragment extends Fragment implements View.OnClickListener {

    Button project1Button;
    String project1URL = "http://pages.iu.edu/~mrlonis/home.html";

    ScrollView infoI101ScrollView;
    TextView infoI101CourseInfo;
    TextView infoI101CourseDescription;
    TextView infoI101Project1;
    TextView infoI101Project1Name;
    TextView infoI101Project1Description;

    public infoI101Fragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_info_i101, container, false);

        /**
         * Link Views
         */
        project1Button = (Button) view.findViewById(R.id.infoI101Project1File);
        project1Button.setOnClickListener(this);

        infoI101ScrollView = (ScrollView) view.findViewById(R.id.scroll_view_i101);
        infoI101CourseInfo = (TextView) view.findViewById(R.id.infoI101CourseInfo);
        infoI101CourseDescription = (TextView) view.findViewById(R.id.infoI101CourseDescription);
        infoI101Project1 = (TextView) view.findViewById(R.id.infoI101Project1);
        infoI101Project1Name = (TextView) view.findViewById(R.id.infoI101Project1Name);
        infoI101Project1Description = (TextView) view.findViewById(R.id.infoI101Project1Description);

        /**
         * Set Background Color/Text Color
         */
        if (Constants.backgroundColor == R.id.red) {
            infoI101ScrollView.setBackgroundColor(getResources().getColor(R.color.red));
            infoI101CourseInfo.setTextColor(getResources().getColor(R.color.white));
            infoI101CourseDescription.setTextColor(getResources().getColor(R.color.white));
            infoI101Project1.setTextColor(getResources().getColor(R.color.white));
            infoI101Project1Name.setTextColor(getResources().getColor(R.color.white));
            infoI101Project1Description.setTextColor(getResources().getColor(R.color.white));
        } else if (Constants.backgroundColor == R.id.black) {
            infoI101ScrollView.setBackgroundColor(getResources().getColor(R.color.black));
            infoI101CourseInfo.setTextColor(getResources().getColor(R.color.white));
            infoI101CourseDescription.setTextColor(getResources().getColor(R.color.white));
            infoI101Project1.setTextColor(getResources().getColor(R.color.white));
            infoI101Project1Name.setTextColor(getResources().getColor(R.color.white));
            infoI101Project1Description.setTextColor(getResources().getColor(R.color.white));
        }else if (Constants.backgroundColor == R.id.blue) {
            infoI101ScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            infoI101CourseInfo.setTextColor(getResources().getColor(R.color.black));
            infoI101CourseDescription.setTextColor(getResources().getColor(R.color.black));
            infoI101Project1.setTextColor(getResources().getColor(R.color.black));
            infoI101Project1Name.setTextColor(getResources().getColor(R.color.black));
            infoI101Project1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.green) {
            infoI101ScrollView.setBackgroundColor(getResources().getColor(R.color.green));
            infoI101CourseInfo.setTextColor(getResources().getColor(R.color.black));
            infoI101CourseDescription.setTextColor(getResources().getColor(R.color.black));
            infoI101Project1.setTextColor(getResources().getColor(R.color.black));
            infoI101Project1Name.setTextColor(getResources().getColor(R.color.black));
            infoI101Project1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.normal) {
            infoI101ScrollView.setBackgroundColor(getResources().getColor(R.color.normal));
            infoI101CourseInfo.setTextColor(getResources().getColor(R.color.black));
            infoI101CourseDescription.setTextColor(getResources().getColor(R.color.black));
            infoI101Project1.setTextColor(getResources().getColor(R.color.black));
            infoI101Project1Name.setTextColor(getResources().getColor(R.color.black));
            infoI101Project1Description.setTextColor(getResources().getColor(R.color.black));
        }
        return view;
    }

    public void onClick(View view) {
        if (view.equals(project1Button)) {
            openBrowser(project1URL);
        }
    }

    private void openBrowser(String url) {
        Uri uri = Uri.parse(url);
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        startActivity(intent);
    }

}
