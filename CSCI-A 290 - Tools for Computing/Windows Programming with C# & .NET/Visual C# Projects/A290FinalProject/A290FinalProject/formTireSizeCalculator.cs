/* Filename: formTireSizeCalculator.cs *
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
    public partial class formTireSizeCalculator : Form
    {
        /* Global Variables */
        private formMain mainForm = null;

        public int integerFirstNumber = 0;
        public int integerSecondNumber = 0;
        public int integerThirdNumber = 0;
        public double doubleFirstNumber = 0;
        public double doubleSecondNumber = 0;
        public double doubleThirdNumber = 0;

        public double doubleCircumference = 0;
        public double doubleWidth = 0;
        public double doubleSidewall = 0;
        public double doubleDiameter = 0;
        public double doubleRevsMile = 0;

        public string stringFirstNumber = "";
        public string stringSecondNumber = "";
        public string stringThirdNumber = "";

        public string stringCircumference = "";
        public string stringWidth = "";
        public string stringSidewall = "";
        public string stringDiameter = "";
        public string stringRevsMile = "";

        public string stringTest = "";
        public int integerNumberCheck = 0;

        public bool isNumber;

        public formTireSizeCalculator(Form callingForm)
        {
            mainForm = callingForm as formMain;
            InitializeComponent();
            BackColor = mainForm.BackColor;
            Icon = Properties.Resources.Icons8_Ios7_Logos_Register_Editor;
        }

        private void formTireSizeCalculator_Load(object sender, EventArgs e)
        {
            /* Set Global Variables */
            integerFirstNumber = 0;
            integerSecondNumber = 0;
            integerThirdNumber = 0;
            doubleFirstNumber = 0;
            doubleSecondNumber = 0;
            doubleThirdNumber = 0;

            doubleCircumference = 0;
            doubleWidth = 0;
            doubleSidewall = 0;
            doubleDiameter = 0;
            doubleRevsMile = 0;

            stringFirstNumber = "";
            stringSecondNumber = "";
            stringThirdNumber = "";

            stringCircumference = "";
            stringWidth = "";
            stringSidewall = "";
            stringDiameter = "";
            stringRevsMile = "";

            stringTest = "";
            integerNumberCheck = 0;

            isNumber = false;

            /* Set Boxes */
            textBoxNumber1.Text = "0";
            textBoxNumber2.Text = "0";
            textBoxNumber3.Text = "0";
            textBoxDiameter.Text = "";
            textBoxWidth.Text = "";
            textBoxSidewall.Text = "";
            textBoxCircumference.Text = "";
    }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            Close();
        }

        private void buttonTireComparison_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            formTireComparison formTireComparisonDialog = new A290FinalProject.formTireComparison(this);
            formTireComparisonDialog.ShowDialog();
        }

        private void buttonClear_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            /* reset Global Variables */
            integerFirstNumber = 0;
            integerSecondNumber = 0;
            integerThirdNumber = 0;
            doubleFirstNumber = 0;
            doubleSecondNumber = 0;
            doubleThirdNumber = 0;

            doubleCircumference = 0;
            doubleWidth = 0;
            doubleSidewall = 0;
            doubleDiameter = 0;
            doubleRevsMile = 0;

            stringFirstNumber = "";
            stringSecondNumber = "";
            stringThirdNumber = "";

            stringCircumference = "";
            stringWidth = "";
            stringSidewall = "";
            stringDiameter = "";
            stringRevsMile = "";

            stringTest = "";
            integerNumberCheck = 0;

            isNumber = false;

            /* Reset Text Boxes */
            textBoxNumber1.Text = "0";
            textBoxNumber2.Text = "0";
            textBoxNumber3.Text = "0";
            textBoxDiameter.Text = "";
            textBoxRevsMile.Text = "";
            textBoxWidth.Text = "";
            textBoxSidewall.Text = "";
            textBoxCircumference.Text = "";
        }

        private void textBoxNumber1_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringFirstNumber = textBoxNumber1.Text.ToString();
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
                textBoxNumber1.Text = "";
                stringFirstNumber = "";
                textBoxNumber1.Lines.Initialize();
                MessageBox.Show("This is an integer only field");
                textBoxNumber1.Focus();
            }
        }

        private void textBoxNumber2_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringSecondNumber = textBoxNumber2.Text.ToString();
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
                textBoxNumber2.Text = "";
                stringSecondNumber = "";
                textBoxNumber2.Lines.Initialize();
                MessageBox.Show("This is an integer only field");
                textBoxNumber2.Focus();
            }
        }

        private void textBoxNumber3_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringThirdNumber = textBoxNumber3.Text.ToString();
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
                textBoxNumber3.Text = "";
                stringThirdNumber = "";
                textBoxNumber3.Lines.Initialize();
                MessageBox.Show("This is an integer only field");
                textBoxNumber3.Focus();
            }
        }

        private void textBoxNumber1_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxNumber2_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxNumber3_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void buttonCalculate_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            if ((integerFirstNumber <= 0) || (integerSecondNumber <= 0) || (integerThirdNumber <= 0))
            {
                MessageBox.Show("Incompatible tire size. None of the numbers can be less than or equal to zero.");
            }
            else
            {
                doubleDiameter = (((doubleFirstNumber * (doubleSecondNumber / 100)) * 2) / 25.4) + doubleThirdNumber;
                doubleWidth = doubleFirstNumber / 25.4;
                doubleSidewall = (doubleFirstNumber * (doubleSecondNumber / 100)) / 25.4;
                doubleCircumference = doubleDiameter * Math.PI;
                doubleRevsMile = 63360 / doubleCircumference;

                stringDiameter = doubleDiameter.ToString();
                stringWidth = doubleWidth.ToString();
                stringSidewall = doubleSidewall.ToString();
                stringCircumference = doubleCircumference.ToString();
                stringRevsMile = doubleRevsMile.ToString();

                textBoxDiameter.Text = stringDiameter;
                textBoxWidth.Text = stringWidth;
                textBoxSidewall.Text = stringSidewall;
                textBoxCircumference.Text = stringCircumference;
                textBoxRevsMile.Text = stringRevsMile;
            }
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
