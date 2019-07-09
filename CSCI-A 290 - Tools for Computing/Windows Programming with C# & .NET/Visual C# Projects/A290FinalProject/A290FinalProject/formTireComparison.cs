/* Filename: formTireComparison.cs *
 * Part Of: A290 Final Project *
 * Created By: Matthew Lonis *
 * Created On: 05/12/19 *
 * Last Modified By: Matthew Lonis *
 * Last Modified On: 09/12/16 *
 */

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace A290FinalProject
{
    public partial class formTireComparison : Form
    {

        private formTireSizeCalculator mainForm = null;

        /* Global Variables */
        public int integerFirstNumber = 0;
        public int integerSecondNumber = 0;
        public int integerThirdNumber = 0;
        public int integerFourthNumber = 0;
        public int integerFifthNumber = 0;
        public int integerSixthNumber = 0;

        public double doubleFirstNumber = 0;
        public double doubleSecondNumber = 0;
        public double doubleThirdNumber = 0;
        public double doubleFourthNumber = 0;
        public double doubleFifthNumber = 0;
        public double doubleSixthNumber = 0;

        public double doubleCircumference1 = 0;
        public double doubleWidth1 = 0;
        public double doubleSidewall1 = 0;
        public double doubleDiameter1 = 0;
        public double doubleRevsMile1 = 0;

        public double doubleCircumference2 = 0;
        public double doubleWidth2 = 0;
        public double doubleSidewall2 = 0;
        public double doubleDiameter2 = 0;
        public double doubleRevsMile2 = 0;

        public double doubleCircumferenceDiff = 0;
        public double doubleWidthDiff = 0;
        public double doubleSidewallDiff = 0;
        public double doubleDiameterDiff = 0;
        public double doubleRevsMileDiff = 0;

        public string stringFirstNumber = "";
        public string stringSecondNumber = "";
        public string stringThirdNumber = "";
        public string stringFourthNumber = "";
        public string stringFifthNumber = "";
        public string stringSixthNumber = "";

        public string stringCircumference1 = "";
        public string stringWidth1 = "";
        public string stringSidewall1 = "";
        public string stringDiameter1 = "";
        public string stringRevsMile1 = "";

        public string stringCircumference2 = "";
        public string stringWidth2 = "";
        public string stringSidewall2 = "";
        public string stringDiameter2 = "";
        public string stringRevsMile2 = "";

        public string stringCircumferenceDiff = "";
        public string stringWidthDiff = "";
        public string stringSidewallDiff = "";
        public string stringDiameterDiff = "";
        public string stringRevsMileDiff = "";

        public string stringTest = "";
        public int integerNumberCheck = 0;

        public bool isNumber;

        public formTireComparison(Form callingForm)
        {
            mainForm = callingForm as formTireSizeCalculator;
            InitializeComponent();
            BackColor = mainForm.BackColor;
            Icon = Properties.Resources.Icons8_Ios7_Logos_Register_Editor;
        }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            Close();
        }

        private void formTireComparison_Load(object sender, EventArgs e)
        {
            /* Set Global Variables */
            integerFirstNumber = 0;
            integerSecondNumber = 0;
            integerThirdNumber = 0;
            integerFourthNumber = 0;
            integerFifthNumber = 0;
            integerSixthNumber = 0;

            doubleFirstNumber = 0;
            doubleSecondNumber = 0;
            doubleThirdNumber = 0;
            doubleFourthNumber = 0;
            doubleFifthNumber = 0;
            doubleSixthNumber = 0;

            doubleCircumference1 = 0;
            doubleWidth1 = 0;
            doubleSidewall1 = 0;
            doubleDiameter1 = 0;
            doubleRevsMile1 = 0;

            doubleCircumference2 = 0;
            doubleWidth2 = 0;
            doubleSidewall2 = 0;
            doubleDiameter2 = 0;
            doubleRevsMile2 = 0;

            doubleCircumferenceDiff = 0;
            doubleWidthDiff = 0;
            doubleSidewallDiff = 0;
            doubleDiameterDiff = 0;
            doubleRevsMileDiff = 0;

            stringFirstNumber = "";
            stringSecondNumber = "";
            stringThirdNumber = "";
            stringFourthNumber = "";
            stringFifthNumber = "";
            stringSixthNumber = "";

            stringCircumference1 = "";
            stringWidth1 = "";
            stringSidewall1 = "";
            stringDiameter1 = "";
            stringRevsMile1 = "";

            stringCircumference2 = "";
            stringWidth2 = "";
            stringSidewall2 = "";
            stringDiameter2 = "";
            stringRevsMile2 = "";

            stringCircumferenceDiff = "";
            stringWidthDiff = "";
            stringSidewallDiff = "";
            stringDiameterDiff = "";
            stringRevsMileDiff = "";

            stringTest = "";
            integerNumberCheck = 0;

            isNumber = false;

            /* Set Boxes */
            textBoxNum1.Text = "0";
            textBoxNum2.Text = "0";
            textBoxNum3.Text = "0";
            textBoxNum4.Text = "0";
            textBoxNum5.Text = "0";
            textBoxNum6.Text = "0";
            textBoxDiameter1.Text = "";
            textBoxRevsMile1.Text = "";
            textBoxWidth1.Text = "";
            textBoxSidewall1.Text = "";
            textBoxCircumference1.Text = "";
            textBoxDiameter2.Text = "";
            textBoxRevsMile2.Text = "";
            textBoxWidth2.Text = "";
            textBoxSidewall2.Text = "";
            textBoxCircumference2.Text = "";
            textBoxDiameter3.Text = "";
            textBoxRevsMile3.Text = "";
            textBoxWidth3.Text = "";
            textBoxSidewall3.Text = "";
            textBoxCircumference3.Text = "";
        }

        private void textBoxNum1_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringFirstNumber = textBoxNum1.Text.ToString();
            stringTest = stringFirstNumber;

            /* Set Boolean Value */
            isNumber = int.TryParse(stringTest, out integerNumberCheck);

            /* Operations based on boolean value */
            if (isNumber == true)
            {
                integerFirstNumber = int.Parse(stringFirstNumber);
                doubleFirstNumber = integerFirstNumber;
            }
            else
            {
                textBoxNum1.Text = "";
                stringFirstNumber = "";
                textBoxNum1.Lines.Initialize();
                MessageBox.Show("This is an integer only field");
                textBoxNum1.Focus();
            }
        }

        private void textBoxNum2_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringSecondNumber = textBoxNum2.Text.ToString();
            stringTest = stringSecondNumber;

            /* Set Boolean Value */
            isNumber = int.TryParse(stringTest, out integerNumberCheck);

            /* Operations based on boolean value */
            if (isNumber == true)
            {
                integerSecondNumber = int.Parse(stringSecondNumber);
                doubleSecondNumber = integerSecondNumber;
            }
            else
            {
                textBoxNum2.Text = "";
                stringSecondNumber = "";
                textBoxNum2.Lines.Initialize();
                MessageBox.Show("This is an integer only field");
                textBoxNum2.Focus();
            }
        }

        private void textBoxNum3_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringThirdNumber = textBoxNum3.Text.ToString();
            stringTest = stringThirdNumber;

            /* Set Boolean Value */
            isNumber = int.TryParse(stringTest, out integerNumberCheck);

            /* Operations based on boolean value */
            if (isNumber == true)
            {
                integerThirdNumber = int.Parse(stringThirdNumber);
                doubleThirdNumber = integerThirdNumber;
            }
            else
            {
                textBoxNum3.Text = "";
                stringThirdNumber = "";
                textBoxNum3.Lines.Initialize();
                MessageBox.Show("This is an integer only field");
                textBoxNum3.Focus();
            }
        }

        private void textBoxNum4_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringFourthNumber = textBoxNum4.Text.ToString();
            stringTest = stringFourthNumber;

            /* Set Boolean Value */
            isNumber = int.TryParse(stringTest, out integerNumberCheck);

            /* Operations based on boolean value */
            if (isNumber == true)
            {
                integerFourthNumber = int.Parse(stringFourthNumber);
                doubleFourthNumber = integerFourthNumber;
            }
            else
            {
                textBoxNum4.Text = "";
                stringFourthNumber = "";
                textBoxNum4.Lines.Initialize();
                MessageBox.Show("This is an integer only field");
                textBoxNum4.Focus();
            }
        }

        private void textBoxNum5_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringFifthNumber = textBoxNum5.Text.ToString();
            stringTest = stringFifthNumber;

            /* Set Boolean Value */
            isNumber = int.TryParse(stringTest, out integerNumberCheck);

            /* Operations based on boolean value */
            if (isNumber == true)
            {
                integerFifthNumber = int.Parse(stringFifthNumber);
                doubleFifthNumber = integerFifthNumber;
            }
            else
            {
                textBoxNum5.Text = "";
                stringFifthNumber = "";
                textBoxNum5.Lines.Initialize();
                MessageBox.Show("This is an integer only field");
                textBoxNum5.Focus();
            }
        }

        private void textBoxNum6_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringSixthNumber = textBoxNum6.Text.ToString();
            stringTest = stringSixthNumber;

            /* Set Boolean Value */
            isNumber = int.TryParse(stringTest, out integerNumberCheck);

            /* Operations based on boolean value */
            if (isNumber == true)
            {
                integerSixthNumber = int.Parse(stringSixthNumber);
                doubleSixthNumber = integerSixthNumber;
            }
            else
            {
                textBoxNum6.Text = "";
                stringSixthNumber = "";
                textBoxNum6.Lines.Initialize();
                MessageBox.Show("This is an integer only field");
                textBoxNum6.Focus();
            }
        }

        private void textBoxNum1_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxNum2_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxNum3_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxNum4_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxNum5_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxNum6_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void buttonCompare_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            if ((integerFirstNumber <= 0) || (integerSecondNumber <= 0) || (integerThirdNumber <= 0) || (integerFourthNumber <= 0) || (integerFifthNumber <= 0) || (integerSixthNumber <= 0))
            {
                MessageBox.Show("Incompatible tire sizes. None of the numbers can be less than or equal to zero.");
            }
            else
            {
                /* Tire 1 Sizes */
                doubleDiameter1 = (((doubleFirstNumber * (doubleSecondNumber / 100)) * 2) / 25.4) + doubleThirdNumber;
                doubleWidth1 = doubleFirstNumber / 25.4;
                doubleSidewall1 = (doubleFirstNumber * (doubleSecondNumber / 100)) / 25.4;
                doubleCircumference1 = doubleDiameter1 * Math.PI;
                doubleRevsMile1 = 63360 / doubleCircumference1;

                stringDiameter1 = doubleDiameter1.ToString();
                stringWidth1 = doubleWidth1.ToString();
                stringSidewall1 = doubleSidewall1.ToString();
                stringCircumference1 = doubleCircumference1.ToString();
                stringRevsMile1 = doubleRevsMile1.ToString();

                textBoxDiameter1.Text = stringDiameter1;
                textBoxWidth1.Text = stringWidth1;
                textBoxSidewall1.Text = stringSidewall1;
                textBoxCircumference1.Text = stringCircumference1;
                textBoxRevsMile1.Text = stringRevsMile1;

                /* Tire 2 Sizes */
                doubleDiameter2 = (((doubleFourthNumber * (doubleFifthNumber / 100)) * 2) / 25.4) + doubleSixthNumber;
                doubleWidth2 = doubleFourthNumber / 25.4;
                doubleSidewall2 = (doubleFourthNumber * (doubleFifthNumber / 100)) / 25.4;
                doubleCircumference2 = doubleDiameter2 * Math.PI;
                doubleRevsMile2 = 63360 / doubleCircumference2;

                stringDiameter2 = doubleDiameter2.ToString();
                stringWidth2 = doubleWidth2.ToString();
                stringSidewall2 = doubleSidewall2.ToString();
                stringCircumference2 = doubleCircumference2.ToString();
                stringRevsMile2 = doubleRevsMile2.ToString();

                textBoxDiameter2.Text = stringDiameter2;
                textBoxWidth2.Text = stringWidth2;
                textBoxSidewall2.Text = stringSidewall2;
                textBoxCircumference2.Text = stringCircumference2;
                textBoxRevsMile2.Text = stringRevsMile2;

                /* Tire Difference Sizes */
                doubleDiameterDiff = doubleDiameter2 - doubleDiameter1;
                doubleWidthDiff = doubleWidth2 - doubleWidth1;
                doubleSidewallDiff = doubleSidewall2 - doubleSidewall1;
                doubleCircumferenceDiff = doubleCircumference2 - doubleCircumference1;
                doubleRevsMileDiff = doubleRevsMile2 - doubleRevsMile1;

                stringDiameterDiff = doubleDiameterDiff.ToString();
                stringWidthDiff = doubleWidthDiff.ToString();
                stringSidewallDiff = doubleSidewallDiff.ToString();
                stringCircumferenceDiff = doubleCircumferenceDiff.ToString();
                stringRevsMileDiff = doubleRevsMileDiff.ToString();

                textBoxDiameter3.Text = stringDiameterDiff;
                textBoxWidth3.Text = stringWidthDiff;
                textBoxSidewall3.Text = stringSidewallDiff;
                textBoxCircumference3.Text = stringCircumferenceDiff;
                textBoxRevsMile3.Text = stringRevsMileDiff;
            }
        }

        private void buttonClear_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            /* Reset Global Variables */
            integerFirstNumber = 0;
            integerSecondNumber = 0;
            integerThirdNumber = 0;
            integerFourthNumber = 0;
            integerFifthNumber = 0;
            integerSixthNumber = 0;

            doubleFirstNumber = 0;
            doubleSecondNumber = 0;
            doubleThirdNumber = 0;
            doubleFourthNumber = 0;
            doubleFifthNumber = 0;
            doubleSixthNumber = 0;

            doubleCircumference1 = 0;
            doubleWidth1 = 0;
            doubleSidewall1 = 0;
            doubleDiameter1 = 0;
            doubleRevsMile1 = 0;

            doubleCircumference2 = 0;
            doubleWidth2 = 0;
            doubleSidewall2 = 0;
            doubleDiameter2 = 0;
            doubleRevsMile2 = 0;

            doubleCircumferenceDiff = 0;
            doubleWidthDiff = 0;
            doubleSidewallDiff = 0;
            doubleDiameterDiff = 0;
            doubleRevsMileDiff = 0;

            stringFirstNumber = "";
            stringSecondNumber = "";
            stringThirdNumber = "";
            stringFourthNumber = "";
            stringFifthNumber = "";
            stringSixthNumber = "";

            stringCircumference1 = "";
            stringWidth1 = "";
            stringSidewall1 = "";
            stringDiameter1 = "";
            stringRevsMile1 = "";

            stringCircumference2 = "";
            stringWidth2 = "";
            stringSidewall2 = "";
            stringDiameter2 = "";
            stringRevsMile2 = "";

            stringCircumferenceDiff = "";
            stringWidthDiff = "";
            stringSidewallDiff = "";
            stringDiameterDiff = "";
            stringRevsMileDiff = "";

            stringTest = "";
            integerNumberCheck = 0;

            isNumber = false;

            /* Reset Text Boxes */
            textBoxNum1.Text = "0";
            textBoxNum2.Text = "0";
            textBoxNum3.Text = "0";
            textBoxNum4.Text = "0";
            textBoxNum5.Text = "0";
            textBoxNum6.Text = "0";
            textBoxDiameter1.Text = "";
            textBoxRevsMile1.Text = "";
            textBoxWidth1.Text = "";
            textBoxSidewall1.Text = "";
            textBoxCircumference1.Text = "";
            textBoxDiameter2.Text = "";
            textBoxRevsMile2.Text = "";
            textBoxWidth2.Text = "";
            textBoxSidewall2.Text = "";
            textBoxCircumference2.Text = "";
            textBoxDiameter3.Text = "";
            textBoxRevsMile3.Text = "";
            textBoxWidth3.Text = "";
            textBoxSidewall3.Text = "";
            textBoxCircumference3.Text = "";
        }

        private void buttonClose_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == Convert.ToChar(Keys.Escape))
            {
                /* Play Click Sound */
                System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
                player.Play();

                Close();
            }
        }
    }
}
