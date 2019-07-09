package edu.indiana.mrlonis.a290finalproject;

/**
 * csciC291Fragment.java
 *
 * Contains the Java code for the CSCI-C 291 Fragment
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to fragment_csci_c291.xml layout file
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
public class csciC291Fragment extends Fragment implements View.OnClickListener {

    Button project1Button;
    Button project2Button;
    Button project3Button;
    String project1URL = "https://github.com/EchoesUndead/CSCI-C291/blob/master/Assignments/Assignment5/operations.c";
    String project2URL = "https://github.com/EchoesUndead/CSCI-C291/blob/master/Assignments/Assignment5/client.c";
    String project3URL = "https://github.com/EchoesUndead/CSCI-C291/blob/master/Assignments/Assignment5/node.h";

    ScrollView csciC291ScrollView;
    TextView csciC291CourseInfo;
    TextView csciC291CourseDescription;
    TextView csciC291Project1;
    TextView csciC291Project1Name;
    TextView csciC291Project1Description;

    public csciC291Fragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_csci_c291, container, false);

        /**
         * Link Views
         */
        project1Button = (Button) view.findViewById(R.id.csciC291Project1File1);
        project2Button = (Button) view.findViewById(R.id.csciC291Project1File2);
        project3Button = (Button) view.findViewById(R.id.csciC291Project1File3);
        project1Button.setOnClickListener(this);
        project2Button.setOnClickListener(this);
        project3Button.setOnClickListener(this);

        csciC291ScrollView = (ScrollView) view.findViewById(R.id.scroll_view_c291);
        csciC291CourseInfo = (TextView) view.findViewById(R.id.csciC291CourseInfo);
        csciC291CourseDescription = (TextView) view.findViewById(R.id.csciC291CourseDescription);
        csciC291Project1 = (TextView) view.findViewById(R.id.csciC291Project1);
        csciC291Project1Name = (TextView) view.findViewById(R.id.csciC291Project1Name);
        csciC291Project1Description = (TextView) view.findViewById(R.id.csciC291Project1Description);

        /**
         * Set Background Color/Text Color
         */
        if (Constants.backgroundColor == R.id.red) {
            csciC291ScrollView.setBackgroundColor(getResources().getColor(R.color.red));
            csciC291CourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciC291CourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciC291Project1.setTextColor(getResources().getColor(R.color.white));
            csciC291Project1Name.setTextColor(getResources().getColor(R.color.white));
            csciC291Project1Description.setTextColor(getResources().getColor(R.color.white));
        } else if (Constants.backgroundColor == R.id.black) {
            csciC291ScrollView.setBackgroundColor(getResources().getColor(R.color.black));
            csciC291CourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciC291CourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciC291Project1.setTextColor(getResources().getColor(R.color.white));
            csciC291Project1Name.setTextColor(getResources().getColor(R.color.white));
            csciC291Project1Description.setTextColor(getResources().getColor(R.color.white));
        }else if (Constants.backgroundColor == R.id.blue) {
            csciC291ScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            csciC291CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC291CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC291Project1.setTextColor(getResources().getColor(R.color.black));
            csciC291Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC291Project1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.green) {
            csciC291ScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            csciC291CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC291CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC291Project1.setTextColor(getResources().getColor(R.color.black));
            csciC291Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC291Project1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.normal) {
            csciC291ScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            csciC291CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC291CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC291Project1.setTextColor(getResources().getColor(R.color.black));
            csciC291Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC291Project1Description.setTextColor(getResources().getColor(R.color.black));
        }
        return view;
    }

    public void onClick(View view) {
        if (view.equals(project1Button)) {
            openBrowser(project1URL);
        } else if (view.equals(project2Button)) {
            openBrowser(project2URL);
        } else if (view.equals(project3Button)) {
            openBrowser(project3URL);
        }
    }

    private void openBrowser(String url) {
        Uri uri = Uri.parse(url);
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        startActivity(intent);
    }

}
