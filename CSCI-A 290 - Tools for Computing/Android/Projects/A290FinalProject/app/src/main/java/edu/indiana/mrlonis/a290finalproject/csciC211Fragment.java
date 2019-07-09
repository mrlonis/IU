package edu.indiana.mrlonis.a290finalproject;

/**
 * csciC211Fragment.java
 *
 * Contains the Java code for the CSCI-C 211 Fragment
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to fragment_csci_c211.xml layout file
 */

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
/**
 * Custom Imports
 */
import android.widget.Button;
import android.net.Uri;
import android.content.Intent;
import android.widget.ScrollView;
import android.widget.TextView;


/**
 * A simple {@link Fragment} subclass.
 */
public class csciC211Fragment extends Fragment implements View.OnClickListener {

    Button project1Button;
    Button project2Button;
    Button project3Button;
    Button project4Button;
    String project1URL = "https://github.com/EchoesUndead/CSCI-C211/blob/master/Assignments/a14/a14.rkt";
    String project2URL = "https://github.com/EchoesUndead/CSCI-C211/blob/master/Assignments/a7/a7.rkt";
    String project3URL = "https://github.com/EchoesUndead/CSCI-C211/blob/master/Assignments/a8/a8.rkt";
    String project4URL = "https://github.com/EchoesUndead/CSCI-C211/blob/master/Assignments/a11/a11.rkt";

    ScrollView csciC211ScrollView;
    TextView csciC211CourseInfo;
    TextView csciC211CourseDescription;
    TextView csciC211Project1;
    TextView csciC211Project1Name;
    TextView csciC211Project1Description;
    TextView csciC211Project2;
    TextView csciC211Project2Name;
    TextView csciC211Project2Description;
    TextView csciC211Project3;
    TextView csciC211Project3Name;
    TextView csciC211Project3Description;
    TextView csciC211Project4;
    TextView csciC211Project4Name;
    TextView csciC211Project4Description;

    public csciC211Fragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_csci_c211, container, false);

        /**
         * Link Views
         */
        project1Button = (Button) view.findViewById(R.id.csciC211Project1File);
        project2Button = (Button) view.findViewById(R.id.csciC211Project2File);
        project3Button = (Button) view.findViewById(R.id.csciC211Project3File);
        project4Button = (Button) view.findViewById(R.id.csciC211Project4File);
        project1Button.setOnClickListener(this);
        project2Button.setOnClickListener(this);
        project3Button.setOnClickListener(this);
        project4Button.setOnClickListener(this);

        csciC211ScrollView = (ScrollView) view.findViewById(R.id.scroll_view_c211);
        csciC211CourseInfo = (TextView) view.findViewById(R.id.csciC211CourseInfo);
        csciC211CourseDescription = (TextView) view.findViewById(R.id.csciC211CourseDescription);
        csciC211Project1 = (TextView) view.findViewById(R.id.csciC211Project1);
        csciC211Project1Name = (TextView) view.findViewById(R.id.csciC211Project1Name);
        csciC211Project1Description = (TextView) view.findViewById(R.id.csciC211Project1Description);
        csciC211Project2 = (TextView) view.findViewById(R.id.csciC211Project2);
        csciC211Project2Name = (TextView) view.findViewById(R.id.csciC211Project2Name);
        csciC211Project2Description = (TextView) view.findViewById(R.id.csciC211Project2Description);
        csciC211Project3 = (TextView) view.findViewById(R.id.csciC211Project3);
        csciC211Project3Name = (TextView) view.findViewById(R.id.csciC211Project3Name);
        csciC211Project3Description = (TextView) view.findViewById(R.id.csciC211Project3Description);
        csciC211Project4 = (TextView) view.findViewById(R.id.csciC211Project4);
        csciC211Project4Name = (TextView) view.findViewById(R.id.csciC211Project4Name);
        csciC211Project4Description = (TextView) view.findViewById(R.id.csciC211Project4Description);

        /**
         * Set Background Color/Text Color
         */
        if (Constants.backgroundColor == R.id.red) {
            csciC211ScrollView.setBackgroundColor(getResources().getColor(R.color.red));
            csciC211CourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciC211CourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciC211Project1.setTextColor(getResources().getColor(R.color.white));
            csciC211Project1Name.setTextColor(getResources().getColor(R.color.white));
            csciC211Project1Description.setTextColor(getResources().getColor(R.color.white));
            csciC211Project2.setTextColor(getResources().getColor(R.color.white));
            csciC211Project2Name.setTextColor(getResources().getColor(R.color.white));
            csciC211Project2Description.setTextColor(getResources().getColor(R.color.white));
            csciC211Project3.setTextColor(getResources().getColor(R.color.white));
            csciC211Project3Name.setTextColor(getResources().getColor(R.color.white));
            csciC211Project3Description.setTextColor(getResources().getColor(R.color.white));
            csciC211Project4.setTextColor(getResources().getColor(R.color.white));
            csciC211Project4Name.setTextColor(getResources().getColor(R.color.white));
            csciC211Project4Description.setTextColor(getResources().getColor(R.color.white));
        } else if (Constants.backgroundColor == R.id.black) {
            csciC211ScrollView.setBackgroundColor(getResources().getColor(R.color.black));
            csciC211CourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciC211CourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciC211Project1.setTextColor(getResources().getColor(R.color.white));
            csciC211Project1Name.setTextColor(getResources().getColor(R.color.white));
            csciC211Project1Description.setTextColor(getResources().getColor(R.color.white));
            csciC211Project2.setTextColor(getResources().getColor(R.color.white));
            csciC211Project2Name.setTextColor(getResources().getColor(R.color.white));
            csciC211Project2Description.setTextColor(getResources().getColor(R.color.white));
            csciC211Project3.setTextColor(getResources().getColor(R.color.white));
            csciC211Project3Name.setTextColor(getResources().getColor(R.color.white));
            csciC211Project3Description.setTextColor(getResources().getColor(R.color.white));
            csciC211Project4.setTextColor(getResources().getColor(R.color.white));
            csciC211Project4Name.setTextColor(getResources().getColor(R.color.white));
            csciC211Project4Description.setTextColor(getResources().getColor(R.color.white));
        }else if (Constants.backgroundColor == R.id.blue) {
            csciC211ScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            csciC211CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC211CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC211Project1.setTextColor(getResources().getColor(R.color.black));
            csciC211Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project1Description.setTextColor(getResources().getColor(R.color.black));
            csciC211Project2.setTextColor(getResources().getColor(R.color.black));
            csciC211Project2Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project2Description.setTextColor(getResources().getColor(R.color.black));
            csciC211Project3.setTextColor(getResources().getColor(R.color.black));
            csciC211Project3Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project3Description.setTextColor(getResources().getColor(R.color.black));
            csciC211Project4.setTextColor(getResources().getColor(R.color.black));
            csciC211Project4Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project4Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.green) {
            csciC211ScrollView.setBackgroundColor(getResources().getColor(R.color.green));
            csciC211CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC211CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC211Project1.setTextColor(getResources().getColor(R.color.black));
            csciC211Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project1Description.setTextColor(getResources().getColor(R.color.black));
            csciC211Project2.setTextColor(getResources().getColor(R.color.black));
            csciC211Project2Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project2Description.setTextColor(getResources().getColor(R.color.black));
            csciC211Project3.setTextColor(getResources().getColor(R.color.black));
            csciC211Project3Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project3Description.setTextColor(getResources().getColor(R.color.black));
            csciC211Project4.setTextColor(getResources().getColor(R.color.black));
            csciC211Project4Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project4Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.normal) {
            csciC211ScrollView.setBackgroundColor(getResources().getColor(R.color.normal));
            csciC211CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC211CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC211Project1.setTextColor(getResources().getColor(R.color.black));
            csciC211Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project1Description.setTextColor(getResources().getColor(R.color.black));
            csciC211Project2.setTextColor(getResources().getColor(R.color.black));
            csciC211Project2Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project2Description.setTextColor(getResources().getColor(R.color.black));
            csciC211Project3.setTextColor(getResources().getColor(R.color.black));
            csciC211Project3Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project3Description.setTextColor(getResources().getColor(R.color.black));
            csciC211Project4.setTextColor(getResources().getColor(R.color.black));
            csciC211Project4Name.setTextColor(getResources().getColor(R.color.black));
            csciC211Project4Description.setTextColor(getResources().getColor(R.color.black));
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
        } else if (view.equals(project4Button)) {
            openBrowser(project4URL);
        }
    }

    private void openBrowser(String url) {
        Uri uri = Uri.parse(url);
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        startActivity(intent);
    }

}
