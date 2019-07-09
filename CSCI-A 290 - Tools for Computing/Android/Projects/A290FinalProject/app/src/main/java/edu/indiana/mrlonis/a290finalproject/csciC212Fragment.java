package edu.indiana.mrlonis.a290finalproject;

/**
 * csciC212Fragment.java
 *
 * Contains the Java code for the CSCI-C 212 Fragment
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to fragment_csci_c212.xml layout file
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
public class csciC212Fragment extends Fragment implements View.OnClickListener {

    Button project1Button;
    String project1URL = "https://github.com/EchoesUndead/CSCI-C212/tree/master/Project/Part%203";

    ScrollView csciC212ScrollView;
    TextView csciC212CourseInfo;
    TextView csciC212CourseDescription;
    TextView csciC212Project1;
    TextView csciC212Project1Name;
    TextView csciC212Project1Description;

    public csciC212Fragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_csci_c212, container, false);

        /**
         * Link Views
         */
        project1Button = (Button) view.findViewById(R.id.csciC212Project1File);
        project1Button.setOnClickListener(this);
        csciC212ScrollView = (ScrollView) view.findViewById(R.id.scroll_view_c212);
        csciC212CourseInfo = (TextView) view.findViewById(R.id.csciC212CourseInfo);
        csciC212CourseDescription = (TextView) view.findViewById(R.id.csciC212CourseDescription);
        csciC212Project1 = (TextView) view.findViewById(R.id.csciC212Project1);
        csciC212Project1Name = (TextView) view.findViewById(R.id.csciC212Project1Name);
        csciC212Project1Description = (TextView) view.findViewById(R.id.csciC212Project1Description);

        /**
         * Set Background Color/Text Color
         */
        if (Constants.backgroundColor == R.id.red) {
            csciC212ScrollView.setBackgroundColor(getResources().getColor(R.color.red));
            csciC212CourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciC212CourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciC212Project1.setTextColor(getResources().getColor(R.color.white));
            csciC212Project1Name.setTextColor(getResources().getColor(R.color.white));
            csciC212Project1Description.setTextColor(getResources().getColor(R.color.white));
        } else if (Constants.backgroundColor == R.id.black) {
            csciC212ScrollView.setBackgroundColor(getResources().getColor(R.color.black));
            csciC212CourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciC212CourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciC212Project1.setTextColor(getResources().getColor(R.color.white));
            csciC212Project1Name.setTextColor(getResources().getColor(R.color.white));
            csciC212Project1Description.setTextColor(getResources().getColor(R.color.white));
        }else if (Constants.backgroundColor == R.id.blue) {
            csciC212ScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            csciC212CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC212CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC212Project1.setTextColor(getResources().getColor(R.color.black));
            csciC212Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC212Project1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.green) {
            csciC212ScrollView.setBackgroundColor(getResources().getColor(R.color.green));
            csciC212CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC212CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC212Project1.setTextColor(getResources().getColor(R.color.black));
            csciC212Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC212Project1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.normal) {
            csciC212ScrollView.setBackgroundColor(getResources().getColor(R.color.normal));
            csciC212CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC212CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC212Project1.setTextColor(getResources().getColor(R.color.black));
            csciC212Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC212Project1Description.setTextColor(getResources().getColor(R.color.black));
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
