/* Filename: RPNCalculator.cs *
 * Part of: Project 3 *
 * Created on: 11/30/2016 *
 * Created by: Matthew Lonis *
 * Last Modified on: 12/03/2016 *
 * Last Modified by: Matthew Lonis */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace RPNCalculator
{
    public partial class RPNCalculator : Form
    {

        public bool confirmOnExit = false; //Controls prompt on exit dialog
        public Color bgColor = SystemColors.ActiveCaption; //Controls BackColor for all forms

        public RPNCalculator()
        {
            InitializeComponent();
        }

        /* Function to check if text boxes are empty before calculation (unused but function remains to showcase my work
         * This function, although inactive, causes no errors */
        private void textBoxCheck()
        {
            if (stringFirstNumber.Equals("") && stringSecondNumber.Equals(""))
            {
                MessageBox.Show("Please enter your first and second number");
            } else if (stringFirstNumber.Equals(""))
            {
                MessageBox.Show("Please enter your first number");
            } else if (stringSecondNumber.Equals(""))
            {
                MessageBox.Show("Please enter your second number");
            }
        }

        /* Global Variables. All made public for linkage between forms */
        public double doubleFirstNumber = 0;
        public double doubleSecondNumber = 0;
        public double doubleAnswer = 0;
        public string stringFirstNumber = "0";
        public string stringSecondNumber = "0";
        public string stringAnswer = "0";
        public string stringTest = "0";
        public double doubleNumberCheck = 0;
        public bool isNumber;

        private void textBoxFirstNumber_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringFirstNumber = textBoxFirstNumber.Text.ToString();
            stringTest = stringFirstNumber;

            /* Set boolean Value */
            isNumber = double.TryParse(stringTest, out doubleNumberCheck);

            /* Operations based on boolean value */
            if (isNumber)
            {
                doubleFirstNumber = double.Parse(stringFirstNumber);
            }
            else
            {
                textBoxFirstNumber.Text = "0";
                stringFirstNumber = "";
                textBoxFirstNumber.Lines.Initialize();
                MessageBox.Show("This is a number only field");
                textBoxFirstNumber.Focus();
            }
        }

        private void textBoxSecondNumber_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringSecondNumber = textBoxSecondNumber.Text.ToString();
            stringTest = stringSecondNumber;

            /* Set boolean Value */
            isNumber = double.TryParse(stringTest, out doubleNumberCheck);

            /* Operations based on boolean value */
            if (isNumber)
            {
                doubleSecondNumber = double.Parse(stringSecondNumber);
            }
            else
            {
                textBoxSecondNumber.Text = "0";
                stringSecondNumber = "";
                textBoxSecondNumber.Lines.Initialize();
                MessageBox.Show("This is a number only field");
                textBoxSecondNumber.Focus();
            }
        }

        private void RPNCalculator_Load(object sender, EventArgs e)
        {
            /* Sets initial text boxes programmatically */
            textBoxFirstNumber.Text = "0";
            textBoxSecondNumber.Text = "0";
            textBoxAnswer.Text = "0";
        }

        private void textBoxFirstNumber_MouseDown(object sender, MouseEventArgs e)
        {
            /* Erases whatever may be in the box, and selects the entire box for easy deletion */
            textBoxFirstNumber.Text = "0";
            ((TextBox)sender).SelectAll();
        }

        private void textBoxSecondNumber_MouseDown(object sender, MouseEventArgs e)
        {
            /* Erases whatever may be in the box, and selects the entire box for easy deletion */
            textBoxSecondNumber.Text = "0";
            ((TextBox)sender).SelectAll();
        }

        private void buttonClear_Click(object sender, EventArgs e)
        {
            /* Reset Text Boxes text property */
            textBoxFirstNumber.Text = "0";
            textBoxSecondNumber.Text = "0";
            textBoxAnswer.Text = "0";

            /* Reset Global Variables */
            doubleFirstNumber = 0;
            doubleSecondNumber = 0;
            doubleAnswer = 0;
            stringFirstNumber = "0";
            stringSecondNumber = "0";
            stringAnswer = "0";
            stringTest = "0";
            doubleNumberCheck = 0;
        }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            Close();
        }

        public void buttonAdd_Click(object sender, EventArgs e)
        {
            textBoxCheck();

            doubleAnswer = (doubleFirstNumber + doubleSecondNumber);
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonSubtract_Click(object sender, EventArgs e)
        {
            textBoxCheck();

            doubleAnswer = (doubleFirstNumber - doubleSecondNumber);
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonMultiply_Click(object sender, EventArgs e)
        {
            textBoxCheck();

            doubleAnswer = (doubleFirstNumber * doubleSecondNumber);
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonDivide_Click(object sender, EventArgs e)
        {
            textBoxCheck();

            /* Gives error if second number equals zero */
            if (doubleSecondNumber == 0)
            {
                MessageBox.Show("Cannot divide by zero");
                textBoxSecondNumber.Focus();
            }
            else
            {
                doubleAnswer = (doubleFirstNumber / doubleSecondNumber);
                stringAnswer = doubleAnswer.ToString();
                textBoxAnswer.Text = stringAnswer;
            }
        }

        private void buttonHelp_Click(object sender, EventArgs e)
        {
            /* Made this form a dialog because I don't know how to change the background color of this form is all three forms
             * (Help, Options, and Main) because only main will be updated. Making this a dialog avoids this discrepency */
            formHelp formHelpDialog = new formHelp(this);
            formHelpDialog.ShowDialog();
        }

        private void buttonSine_Click(object sender, EventArgs e)
        {
            doubleAnswer = Math.Sin(doubleFirstNumber);
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonCosine_Click(object sender, EventArgs e)
        {
            doubleAnswer = Math.Cos(doubleFirstNumber);
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonTangent_Click(object sender, EventArgs e)
        {
            doubleAnswer = Math.Tan(doubleFirstNumber);
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonPower_Click(object sender, EventArgs e)
        {
            doubleAnswer = Math.Pow(doubleFirstNumber, doubleSecondNumber);
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonOptions_Click(object sender, EventArgs e)
        {
            formOptions formOptionsDialog = new formOptions(this);
            formOptionsDialog.ShowDialog();
        }

        private void RPNCalculator_FormClosing(object sender, FormClosingEventArgs e)
        {
            //If box is checked,
            if (confirmOnExit == true)
            {
                /*display a dialog with Yes/No buttons that asks "Close A290Calculator?", uses the "?" icon, and has the caption "Confirm Exit" 
                 * If the user selects "No", then */
                if (MessageBox.Show("Close A290Calculator?", "Confirm Exit", 
                    MessageBoxButtons.YesNo, 
                    MessageBoxIcon.Question) == DialogResult.No)
                {
                    //Cancel the event frmBuffet_FormClosing
                    e.Cancel = true;
                }
                //otherwise, close the application
            }
        }
    }   
}   
