package edu.indiana.mrlonis.a290finalproject;

/**
 * settingsFragment.java
 *
 * Contains the Java code for the Settings Fragment
 *
 * Created by: Matthew Lonis
 * Created on: 2/27/17
 * Last Modified by: Matthew Lonis
 * Last Modified on: 3/5/17
 * Assignment/Project: A290 Final Project
 * Part of: A290FinalProject, refers to fragment_settings.xml layout file
 */

import android.content.res.ColorStateList;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
/**
 * Custom Imports
 */
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.ScrollView;
import android.widget.TextView;


/**
 * A simple {@link Fragment} subclass.
 */
public class settingsFragment extends Fragment implements View.OnClickListener {

    ScrollView scrollView;
    LinearLayout linearLayout;
    TextView backgroundColorTextView;
    RadioButton defaultRadioButton;
    RadioButton redRadioButton;
    RadioButton blueRadioButton;
    RadioButton greenRadioButton;
    RadioButton blackRadioButton;

    public settingsFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_settings, container, false);

        /**
         * Link Views from XML
         */
        scrollView = (ScrollView) view.findViewById(R.id.settings_scroll_view);
        linearLayout = (LinearLayout) view.findViewById(R.id.settings_linear_layout);
        backgroundColorTextView = (TextView) view.findViewById(R.id.background_color_text);
        defaultRadioButton = (RadioButton) view.findViewById(R.id.normal);
        redRadioButton = (RadioButton) view.findViewById(R.id.red);
        blueRadioButton = (RadioButton) view.findViewById(R.id.blue);
        greenRadioButton = (RadioButton) view.findViewById(R.id.green);
        blackRadioButton = (RadioButton) view.findViewById(R.id.black);

        /**
         * Add Click Listeners
         */
        defaultRadioButton.setOnClickListener(this);
        redRadioButton.setOnClickListener(this);
        blueRadioButton.setOnClickListener(this);
        greenRadioButton.setOnClickListener(this);
        blackRadioButton.setOnClickListener(this);

        /**
         * Set Background Color/Text Color
         */
        if (Constants.backgroundColor == R.id.red) {
            /**
             * Change Background Color
             */
            scrollView.setBackgroundColor(getResources().getColor(R.color.red));

            /**
             * Change TextColor
             */
            backgroundColorTextView.setTextColor(getResources().getColor(R.color.white));
            defaultRadioButton.setTextColor(getResources().getColor(R.color.white));
            redRadioButton.setTextColor(getResources().getColor(R.color.white));
            blueRadioButton.setTextColor(getResources().getColor(R.color.white));
            greenRadioButton.setTextColor(getResources().getColor(R.color.white));
            blackRadioButton.setTextColor(getResources().getColor(R.color.white));

            /**
             * Change Radio Button Color
             */
            defaultRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            redRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            blueRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            greenRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            blackRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
        } else if (Constants.backgroundColor == R.id.black) {
            /**
             * Change Background Color
             */
            scrollView.setBackgroundColor(getResources().getColor(R.color.black));

            /**
             * Change Text Color
             */
            backgroundColorTextView.setTextColor(getResources().getColor(R.color.white));
            defaultRadioButton.setTextColor(getResources().getColor(R.color.white));
            redRadioButton.setTextColor(getResources().getColor(R.color.white));
            blueRadioButton.setTextColor(getResources().getColor(R.color.white));
            greenRadioButton.setTextColor(getResources().getColor(R.color.white));
            blackRadioButton.setTextColor(getResources().getColor(R.color.white));

            /**
             * Change Radio Button Color
             */
            defaultRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            redRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            blueRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            greenRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            blackRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
        }else if (Constants.backgroundColor == R.id.blue) {
            /**
             * Change Background Color
             */
            scrollView.setBackgroundColor(getResources().getColor(R.color.blue));

            /**
             * Change Text color
             */
            backgroundColorTextView.setTextColor(getResources().getColor(R.color.black));
            defaultRadioButton.setTextColor(getResources().getColor(R.color.black));
            redRadioButton.setTextColor(getResources().getColor(R.color.black));
            blueRadioButton.setTextColor(getResources().getColor(R.color.black));
            greenRadioButton.setTextColor(getResources().getColor(R.color.black));
            blackRadioButton.setTextColor(getResources().getColor(R.color.black));

            /**
             * Change radio button color
             */
            defaultRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            redRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blueRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            greenRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blackRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
        } else if (Constants.backgroundColor == R.id.green) {
            /**
             * Change background color
             */
            scrollView.setBackgroundColor(getResources().getColor(R.color.green));

            /**
             * Change Text color
             */
            backgroundColorTextView.setTextColor(getResources().getColor(R.color.black));
            defaultRadioButton.setTextColor(getResources().getColor(R.color.black));
            redRadioButton.setTextColor(getResources().getColor(R.color.black));
            blueRadioButton.setTextColor(getResources().getColor(R.color.black));
            greenRadioButton.setTextColor(getResources().getColor(R.color.black));
            blackRadioButton.setTextColor(getResources().getColor(R.color.black));

            /**
             * Change Radio Button color
             */
            defaultRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            redRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blueRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            greenRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blackRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
        } else if (Constants.backgroundColor == R.id.normal) {
            /**
             * Change Background Color
             */
            scrollView.setBackgroundColor(getResources().getColor(R.color.normal));

            /**
             * Change Text Color
             */
            backgroundColorTextView.setTextColor(getResources().getColor(R.color.black));
            defaultRadioButton.setTextColor(getResources().getColor(R.color.black));
            redRadioButton.setTextColor(getResources().getColor(R.color.black));
            blueRadioButton.setTextColor(getResources().getColor(R.color.black));
            greenRadioButton.setTextColor(getResources().getColor(R.color.black));
            blackRadioButton.setTextColor(getResources().getColor(R.color.black));

            /**
             * Change Radio Button color
             */
            defaultRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            redRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blueRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            greenRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blackRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
        }

        return view;
    }

    public void onClick(View view) {
        int id = view.getId();

        if (id == R.id.normal) {
            /**
             * Change Background color
             */
            scrollView.setBackgroundColor(getResources().getColor(R.color.normal));

            /**
             * Change constant color
             */
            Constants.backgroundColor = R.id.normal;

            /**
             * Change text color
             */
            backgroundColorTextView.setTextColor(getResources().getColor(R.color.black));
            defaultRadioButton.setTextColor(getResources().getColor(R.color.black));
            redRadioButton.setTextColor(getResources().getColor(R.color.black));
            blueRadioButton.setTextColor(getResources().getColor(R.color.black));
            greenRadioButton.setTextColor(getResources().getColor(R.color.black));
            blackRadioButton.setTextColor(getResources().getColor(R.color.black));

            /**
             * Change radio button color
             */
            defaultRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            redRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blueRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            greenRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blackRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
        } else if (id == R.id.red) {
            /**
             * Change background color
             */
            scrollView.setBackgroundColor(getResources().getColor(R.color.red));

            /**
             * Change constants color
             */
            Constants.backgroundColor = R.id.red;

            /**
             * Change text color
             */
            backgroundColorTextView.setTextColor(getResources().getColor(R.color.white));
            defaultRadioButton.setTextColor(getResources().getColor(R.color.white));
            redRadioButton.setTextColor(getResources().getColor(R.color.white));
            blueRadioButton.setTextColor(getResources().getColor(R.color.white));
            greenRadioButton.setTextColor(getResources().getColor(R.color.white));
            blackRadioButton.setTextColor(getResources().getColor(R.color.white));

            /**
             * Change radio button color
             */
            defaultRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            redRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            blueRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            greenRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            blackRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
        } else if (id == R.id.blue) {
            /**
             * Change background color
             */
            scrollView.setBackgroundColor(getResources().getColor(R.color.blue));

            /**
             * Change constants color
             */
            Constants.backgroundColor = R.id.blue;

            /**
             * Change text color
             */
            backgroundColorTextView.setTextColor(getResources().getColor(R.color.black));
            defaultRadioButton.setTextColor(getResources().getColor(R.color.black));
            redRadioButton.setTextColor(getResources().getColor(R.color.black));
            blueRadioButton.setTextColor(getResources().getColor(R.color.black));
            greenRadioButton.setTextColor(getResources().getColor(R.color.black));
            blackRadioButton.setTextColor(getResources().getColor(R.color.black));

            /**
             * Change radio button color
             */
            defaultRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            redRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blueRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            greenRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blackRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
        } else if (id == R.id.green) {
            /**
             * Change background color
             */
            scrollView.setBackgroundColor(getResources().getColor(R.color.green));

            /**
             * Chnage constants color
             */
            Constants.backgroundColor = R.id.green;

            /**
             * Change text color
             */
            backgroundColorTextView.setTextColor(getResources().getColor(R.color.black));
            defaultRadioButton.setTextColor(getResources().getColor(R.color.black));
            redRadioButton.setTextColor(getResources().getColor(R.color.black));
            blueRadioButton.setTextColor(getResources().getColor(R.color.black));
            greenRadioButton.setTextColor(getResources().getColor(R.color.black));
            blackRadioButton.setTextColor(getResources().getColor(R.color.black));

            /**
             * Change radio button color
             */
            defaultRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            redRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blueRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            greenRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
            blackRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.black)));
        } else if (id == R.id.black) {
            /**
             * Chnage background color
             */
            scrollView.setBackgroundColor(getResources().getColor(R.color.black));

            /**
             * Change constants color
             */
            Constants.backgroundColor = R.id.black;

            /**
             * Change text color
             */
            backgroundColorTextView.setTextColor(getResources().getColor(R.color.white));
            defaultRadioButton.setTextColor(getResources().getColor(R.color.white));
            redRadioButton.setTextColor(getResources().getColor(R.color.white));
            blueRadioButton.setTextColor(getResources().getColor(R.color.white));
            greenRadioButton.setTextColor(getResources().getColor(R.color.white));
            blackRadioButton.setTextColor(getResources().getColor(R.color.white));

            /**
             * Change radio button color
             */
            defaultRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            redRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            blueRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            greenRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
            blackRadioButton.setButtonTintList(ColorStateList.valueOf(getResources().getColor(R.color.white)));
        }
    }

}
