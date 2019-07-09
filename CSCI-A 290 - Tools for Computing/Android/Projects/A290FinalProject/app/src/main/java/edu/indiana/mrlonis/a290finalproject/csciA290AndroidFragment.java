package edu.indiana.mrlonis.a290finalproject;

/**
 * csciA290AndroidFragment.java
 *
 * Contains the Java code for the CSCI-A 290 Android Fragment
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to fragment_csci_a290_android.xml layout file
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
public class csciA290AndroidFragment extends Fragment implements View.OnClickListener {

    Button project1Button;
    String project1URL = "https://github.com/EchoesUndead/CSCI-C212/tree/master/Project/Part%203";

    ScrollView csciA290AndroidScrollView;
    TextView csciA290AndroidCourseInfo;
    TextView csciA290AndroidCourseDescription;
    TextView csciA290AndroidProject1;
    TextView csciA290AndroidProject1Name;
    TextView csciA290AndroidProject1Description;

    public csciA290AndroidFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_csci_a290_android, container, false);

        /**
         * Link Views
         */
        project1Button = (Button) view.findViewById(R.id.csciA290AndroidProject1File);
        project1Button.setOnClickListener(this);
        csciA290AndroidScrollView = (ScrollView) view.findViewById(R.id.scroll_view_android);
        csciA290AndroidCourseInfo = (TextView) view.findViewById(R.id.csciA290AndroidCourseInfo);
        csciA290AndroidCourseDescription = (TextView) view.findViewById(R.id.csciA290AndroidCourseDescription);
        csciA290AndroidProject1 = (TextView) view.findViewById(R.id.csciA290AndroidProject1);
        csciA290AndroidProject1Name = (TextView) view.findViewById(R.id.csciA290AndroidProject1Name);
        csciA290AndroidProject1Description = (TextView) view.findViewById(R.id.csciA290AndroidProject1Description);

        /**
         * Set Background Color/Text Color
         */
        if (Constants.backgroundColor == R.id.red) {
            csciA290AndroidScrollView.setBackgroundColor(getResources().getColor(R.color.red));
            csciA290AndroidCourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciA290AndroidCourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciA290AndroidProject1.setTextColor(getResources().getColor(R.color.white));
            csciA290AndroidProject1Name.setTextColor(getResources().getColor(R.color.white));
            csciA290AndroidProject1Description.setTextColor(getResources().getColor(R.color.white));
        } else if (Constants.backgroundColor == R.id.black) {
            csciA290AndroidScrollView.setBackgroundColor(getResources().getColor(R.color.black));
            csciA290AndroidCourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciA290AndroidCourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciA290AndroidProject1.setTextColor(getResources().getColor(R.color.white));
            csciA290AndroidProject1Name.setTextColor(getResources().getColor(R.color.white));
            csciA290AndroidProject1Description.setTextColor(getResources().getColor(R.color.white));
        }else if (Constants.backgroundColor == R.id.blue) {
            csciA290AndroidScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            csciA290AndroidCourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidCourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidProject1.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidProject1Name.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidProject1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.green) {
            csciA290AndroidScrollView.setBackgroundColor(getResources().getColor(R.color.green));
            csciA290AndroidCourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidCourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidProject1.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidProject1Name.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidProject1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.normal) {
            csciA290AndroidScrollView.setBackgroundColor(getResources().getColor(R.color.normal));
            csciA290AndroidCourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidCourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidProject1.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidProject1Name.setTextColor(getResources().getColor(R.color.black));
            csciA290AndroidProject1Description.setTextColor(getResources().getColor(R.color.black));
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
