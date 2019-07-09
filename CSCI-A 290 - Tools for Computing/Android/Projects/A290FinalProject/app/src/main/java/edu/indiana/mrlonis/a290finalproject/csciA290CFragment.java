package edu.indiana.mrlonis.a290finalproject;

/**
 * csciA290CFragment.java
 *
 * Contains the Java code for the CSCI-A 290 C & UNIX Basics Fragment
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to fragment_csci_a290_c.xml layout file
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
public class csciA290CFragment extends Fragment implements View.OnClickListener {

    Button project1Button;
    String project1URL = "https://github.com/EchoesUndead/CSCI-A290-C_and_UNIX_Basics/blob/master/Programs/Program%204/P4.c";

    ScrollView csciA290CScrollView;
    TextView csciA290CCourseInfo;
    TextView csciA290CCourseDescription;
    TextView csciA290CProject1;
    TextView csciA290CProject1Name;
    TextView csciA290CProject1Description;

    public csciA290CFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_csci_a290_c, container, false);

        /**
         * Link Views
         */
        project1Button = (Button) view.findViewById(R.id.csciA290CProject1File);
        project1Button.setOnClickListener(this);
        csciA290CScrollView = (ScrollView) view.findViewById(R.id.scroll_view_c);
        csciA290CCourseInfo = (TextView) view.findViewById(R.id.csciA290CCourseInfo);
        csciA290CCourseDescription = (TextView) view.findViewById(R.id.csciA290CCourseDescription);
        csciA290CProject1 = (TextView) view.findViewById(R.id.csciA290CProject1);
        csciA290CProject1Name = (TextView) view.findViewById(R.id.csciA290CProject1Name);
        csciA290CProject1Description = (TextView) view.findViewById(R.id.csciA290CProject1Description);

        /**
         * Set Background Color/Text Color
         */
        if (Constants.backgroundColor == R.id.red) {
            csciA290CScrollView.setBackgroundColor(getResources().getColor(R.color.red));
            csciA290CCourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciA290CCourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciA290CProject1.setTextColor(getResources().getColor(R.color.white));
            csciA290CProject1Name.setTextColor(getResources().getColor(R.color.white));
            csciA290CProject1Description.setTextColor(getResources().getColor(R.color.white));
        } else if (Constants.backgroundColor == R.id.black) {
            csciA290CScrollView.setBackgroundColor(getResources().getColor(R.color.black));
            csciA290CCourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciA290CCourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciA290CProject1.setTextColor(getResources().getColor(R.color.white));
            csciA290CProject1Name.setTextColor(getResources().getColor(R.color.white));
            csciA290CProject1Description.setTextColor(getResources().getColor(R.color.white));
        }else if (Constants.backgroundColor == R.id.blue) {
            csciA290CScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            csciA290CCourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciA290CCourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciA290CProject1.setTextColor(getResources().getColor(R.color.black));
            csciA290CProject1Name.setTextColor(getResources().getColor(R.color.black));
            csciA290CProject1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.green) {
            csciA290CScrollView.setBackgroundColor(getResources().getColor(R.color.green));
            csciA290CCourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciA290CCourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciA290CProject1.setTextColor(getResources().getColor(R.color.black));
            csciA290CProject1Name.setTextColor(getResources().getColor(R.color.black));
            csciA290CProject1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.normal) {
            csciA290CScrollView.setBackgroundColor(getResources().getColor(R.color.normal));
            csciA290CCourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciA290CCourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciA290CProject1.setTextColor(getResources().getColor(R.color.black));
            csciA290CProject1Name.setTextColor(getResources().getColor(R.color.black));
            csciA290CProject1Description.setTextColor(getResources().getColor(R.color.black));
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
