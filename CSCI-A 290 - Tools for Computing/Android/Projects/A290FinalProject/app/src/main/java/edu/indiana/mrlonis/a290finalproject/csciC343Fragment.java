package edu.indiana.mrlonis.a290finalproject;

/**
 * csciC343Fragment.java
 *
 * Contains the Java code for the CSCI-C 343 Fragment
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to fragment_csci_c343.xml layout file
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
public class csciC343Fragment extends Fragment implements View.OnClickListener {

    Button project1Button;
    String project1URL = "https://github.com/EchoesUndead/CSCI-C343/tree/master/p1/src/p1";

    ScrollView csciC343ScrollView;
    TextView csciC343CourseInfo;
    TextView csciC343CourseDescription;
    TextView csciC343Project1;
    TextView csciC343Project1Name;
    TextView csciC343Project1Description;

    public csciC343Fragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_csci_c343, container, false);

        /**
         * Link Views
         */
        project1Button = (Button) view.findViewById(R.id.csciC343Project1File);
        project1Button.setOnClickListener(this);

        csciC343ScrollView = (ScrollView) view.findViewById(R.id.scroll_view_c343);
        csciC343CourseInfo = (TextView) view.findViewById(R.id.csciC343CourseInfo);
        csciC343CourseDescription = (TextView) view.findViewById(R.id.csciC343CourseDescription);
        csciC343Project1 = (TextView) view.findViewById(R.id.csciC343Project1);
        csciC343Project1Name = (TextView) view.findViewById(R.id.csciC343Project1Name);
        csciC343Project1Description = (TextView) view.findViewById(R.id.csciC343Project1Description);

        /**
         * Set Background Color/Text Color
         */
        if (Constants.backgroundColor == R.id.red) {
            csciC343ScrollView.setBackgroundColor(getResources().getColor(R.color.red));
            csciC343CourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciC343CourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciC343Project1.setTextColor(getResources().getColor(R.color.white));
            csciC343Project1Name.setTextColor(getResources().getColor(R.color.white));
            csciC343Project1Description.setTextColor(getResources().getColor(R.color.white));
        } else if (Constants.backgroundColor == R.id.black) {
            csciC343ScrollView.setBackgroundColor(getResources().getColor(R.color.black));
            csciC343CourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciC343CourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciC343Project1.setTextColor(getResources().getColor(R.color.white));
            csciC343Project1Name.setTextColor(getResources().getColor(R.color.white));
            csciC343Project1Description.setTextColor(getResources().getColor(R.color.white));
        }else if (Constants.backgroundColor == R.id.blue) {
            csciC343ScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            csciC343CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC343CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC343Project1.setTextColor(getResources().getColor(R.color.black));
            csciC343Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC343Project1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.green) {
            csciC343ScrollView.setBackgroundColor(getResources().getColor(R.color.green));
            csciC343CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC343CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC343Project1.setTextColor(getResources().getColor(R.color.black));
            csciC343Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC343Project1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.normal) {csciC343ScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            csciC343ScrollView.setBackgroundColor(getResources().getColor(R.color.normal));
            csciC343CourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciC343CourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciC343Project1.setTextColor(getResources().getColor(R.color.black));
            csciC343Project1Name.setTextColor(getResources().getColor(R.color.black));
            csciC343Project1Description.setTextColor(getResources().getColor(R.color.black));
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
