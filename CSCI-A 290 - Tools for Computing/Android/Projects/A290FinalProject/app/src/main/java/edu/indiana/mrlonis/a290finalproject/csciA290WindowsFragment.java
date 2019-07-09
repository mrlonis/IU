package edu.indiana.mrlonis.a290finalproject;

/**
 * csciA290WindowsFragment.java
 *
 * Contains the Java code for the CSCI-A 290 Windows Fragment
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to fragment_csci_a290_windows.xml layout file
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
public class csciA290WindowsFragment extends Fragment implements View.OnClickListener {

    Button project1Button;
    String project1URL = "https://github.com/EchoesUndead/CSCI-A290-Windows_Programming_with_Csharp_and_dotNET/tree/master/Visual%20C%23%20Projects/A290FinalProject";

    ScrollView csciA290WindowsScrollView;
    TextView csciA290WindowsCourseInfo;
    TextView csciA290WindowsCourseDescription;
    TextView csciA290WindowsProject1;
    TextView csciA290WindowsProject1Name;
    TextView csciA290WindowsProject1Description;

    public csciA290WindowsFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_csci_a290_windows, container, false);

        /**
         * Link Views
         */
        project1Button = (Button) view.findViewById(R.id.csciA290WindowsProject1File);
        project1Button.setOnClickListener(this);
        csciA290WindowsScrollView = (ScrollView) view.findViewById(R.id.scroll_view_windows);
        csciA290WindowsCourseInfo = (TextView) view.findViewById(R.id.csciA290WindowsCourseInfo);
        csciA290WindowsCourseDescription = (TextView) view.findViewById(R.id.csciA290WindowsCourseDescription);
        csciA290WindowsProject1 = (TextView) view.findViewById(R.id.csciA290WindowsProject1);
        csciA290WindowsProject1Name = (TextView) view.findViewById(R.id.csciA290WindowsProject1Name);
        csciA290WindowsProject1Description = (TextView) view.findViewById(R.id.csciA290WindowsProject1Description);

        /**
         * Set Background Color/Text Color
         */
        if (Constants.backgroundColor == R.id.red) {
            csciA290WindowsScrollView.setBackgroundColor(getResources().getColor(R.color.red));
            csciA290WindowsCourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciA290WindowsCourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciA290WindowsProject1.setTextColor(getResources().getColor(R.color.white));
            csciA290WindowsProject1Name.setTextColor(getResources().getColor(R.color.white));
            csciA290WindowsProject1Description.setTextColor(getResources().getColor(R.color.white));
        } else if (Constants.backgroundColor == R.id.black) {
            csciA290WindowsScrollView.setBackgroundColor(getResources().getColor(R.color.black));
            csciA290WindowsCourseInfo.setTextColor(getResources().getColor(R.color.white));
            csciA290WindowsCourseDescription.setTextColor(getResources().getColor(R.color.white));
            csciA290WindowsProject1.setTextColor(getResources().getColor(R.color.white));
            csciA290WindowsProject1Name.setTextColor(getResources().getColor(R.color.white));
            csciA290WindowsProject1Description.setTextColor(getResources().getColor(R.color.white));
        }else if (Constants.backgroundColor == R.id.blue) {
            csciA290WindowsScrollView.setBackgroundColor(getResources().getColor(R.color.blue));
            csciA290WindowsCourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsCourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsProject1.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsProject1Name.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsProject1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.green) {
            csciA290WindowsScrollView.setBackgroundColor(getResources().getColor(R.color.green));
            csciA290WindowsCourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsCourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsProject1.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsProject1Name.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsProject1Description.setTextColor(getResources().getColor(R.color.black));
        } else if (Constants.backgroundColor == R.id.normal) {
            csciA290WindowsScrollView.setBackgroundColor(getResources().getColor(R.color.normal));
            csciA290WindowsCourseInfo.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsCourseDescription.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsProject1.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsProject1Name.setTextColor(getResources().getColor(R.color.black));
            csciA290WindowsProject1Description.setTextColor(getResources().getColor(R.color.black));
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
