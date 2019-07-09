package edu.indiana.mrlonis.a290finalproject;

/**
 * resumeFragment.java
 *
 * Contains the Java code for the Resume Fragment
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to fragment_resume.xml layout file & TouchImageView java file
 */

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;


/**
 * A simple {@link Fragment} subclass.
 */
public class resumeFragment extends Fragment {

    FrameLayout resumeFrameLayout;

    public resumeFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_resume, container, false);

        /**
         * Link Views
         */
        resumeFrameLayout = (FrameLayout) view.findViewById(R.id.frame_layout_resume);

        /**
         * Set Background Color/Text Color
         */
        if (Constants.backgroundColor == R.id.red) {
            resumeFrameLayout.setBackgroundColor(getResources().getColor(R.color.red));
        } else if (Constants.backgroundColor == R.id.black) {
            resumeFrameLayout.setBackgroundColor(getResources().getColor(R.color.black));
        }else if (Constants.backgroundColor == R.id.blue) {
            resumeFrameLayout.setBackgroundColor(getResources().getColor(R.color.blue));
        } else if (Constants.backgroundColor == R.id.green) {
            resumeFrameLayout.setBackgroundColor(getResources().getColor(R.color.green));
        } else if (Constants.backgroundColor == R.id.normal) {
            resumeFrameLayout.setBackgroundColor(getResources().getColor(R.color.normal));
        }

        return view;
    }

}
