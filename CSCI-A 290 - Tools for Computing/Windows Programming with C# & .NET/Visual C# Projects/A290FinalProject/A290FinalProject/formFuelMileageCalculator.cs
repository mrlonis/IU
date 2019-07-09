/* Filename: formFuelMileageCalculator.cs *
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
    public partial class formFuelMileageCalculator : Form
    {

        private formMain mainForm = null;

        public formFuelMileageCalculator(Form callingForm)
        {
            mainForm = callingForm as formMain;
            InitializeComponent();
            BackColor = mainForm.BackColor;
            Icon = Properties.Resources.Icons8_Ios7_Logos_Register_Editor;
        }

        /* Global Variables */
        public double doubleFuel = 0;
        public double doubleDistance = 0;
        public double doubleAnswer = 0;
        public string stringFuel = "";
        public string stringDistance = "";
        public string stringAnswer = "";
        public string stringTest = "";
        public double doubleNumberCheck = 0;
        public bool isNumber;

        public string stringVehicleMake = "";
        public string stringVehicleModel = "";
        public string stringVehicleYear = "";
        public int intNumberCheck = 0;
        public int intVehicleYear = 0;

        private void formFuelMileageCalculator_Load(object sender, EventArgs e)
        {
            /* Set Global Variables */
            doubleFuel = 0;
            doubleDistance = 0;
            doubleAnswer = 0;
            stringFuel = "";
            stringDistance = "";
            stringAnswer = "";
            stringTest = "";
            doubleNumberCheck = 0;
            isNumber = false;

            stringVehicleMake = "";
            stringVehicleModel = "";
            stringVehicleYear = "";
            intNumberCheck = 0;
            intVehicleYear = 0;

            /* Set Text Boxes */
            textBoxVehicleMake.Text = "";
            textBoxVehicleModel.Text = "";
            textBoxVehicleYear.Text = "0";
            textBoxFuel.Text = "0";
            textBoxDistance.Text = "0";
            textBoxMPG.Text = "0";
    }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            Close();
        }

        private void textBoxVehicleMake_Leave(object sender, EventArgs e)
        {
            stringVehicleMake = textBoxVehicleMake.Text.ToString();
        }

        private void textBoxVehicleModel_Leave(object sender, EventArgs e)
        {
            stringVehicleModel = textBoxVehicleModel.Text.ToString();
        }

        private void textBoxVehicleYear_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringVehicleYear = textBoxVehicleYear.Text.ToString();
            stringTest = stringVehicleYear;

            /* Set Boolean Value */
            isNumber = int.TryParse(stringTest, out intNumberCheck);

            /* Operations based on boolean value */
            if (isNumber == true)
            {
                intVehicleYear = int.Parse(stringVehicleYear);
            }
            else
            {
                textBoxVehicleYear.Text = "0";
                stringVehicleYear = "";
                textBoxVehicleYear.Lines.Initialize();
                MessageBox.Show("This is an integer only field");
                textBoxVehicleYear.Focus();
            }

            /* If verhicle year is less than 1885 or greater than or equal to 2020, the following messages will appear */
            if (intVehicleYear >= 2020)
            {
                MessageBox.Show("No vehicles for this year have been made yet...");
                textBoxVehicleYear.Text = "0";
                stringVehicleYear = "";
                textBoxVehicleYear.Lines.Initialize();
                textBoxVehicleYear.Focus();
            }
            else if (intVehicleYear < 1885)
            {
                MessageBox.Show("Really? Your car was made before 1885? The year the first car was made?");
                textBoxVehicleYear.Text = "0";
                stringVehicleYear = "";
                textBoxVehicleYear.Lines.Initialize();
                textBoxVehicleYear.Focus();
            }
        }

        private void textBoxFuel_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringFuel = textBoxFuel.Text.ToString();
            stringTest = stringFuel;

            /* Set Boolean Value */
            isNumber = double.TryParse(stringTest, out doubleNumberCheck);

            /* Operations based on boolean value */
            if (isNumber == true)
            {
                doubleFuel = double.Parse(stringFuel);
            }
            else
            {
                textBoxFuel.Text = "0";
                stringFuel = "";
                textBoxFuel.Lines.Initialize();
                MessageBox.Show("This is a number only field");
                textBoxFuel.Focus();
            }

            /* If fuel amount is less than or equal to zero the following message will appear */
            if (doubleFuel <=0)
            {
                MessageBox.Show("Your fuel amount cannot be less than or equal to zero...");
                textBoxFuel.Text = "0";
                stringFuel = "";
                textBoxFuel.Lines.Initialize();
                textBoxFuel.Focus();
            }
        }

        private void textBoxDistance_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringDistance = textBoxDistance.Text.ToString();
            stringTest = stringDistance;

            /* Set Boolean Value */
            isNumber = double.TryParse(stringTest, out doubleNumberCheck);

            /* Operations based on boolean value */
            if (isNumber == true)
            {
                doubleDistance = double.Parse(stringDistance);
            }
            else
            {
                textBoxDistance.Text = "0";
                stringDistance = "";
                textBoxDistance.Lines.Initialize();
                MessageBox.Show("This is a number only field");
                textBoxDistance.Focus();
            }

            /* If distance is less than zero, the following message will appear */
            if (doubleDistance < 0)
            {
                MessageBox.Show("Your distance cannot be less than zero...");
                textBoxDistance.Text = "0";
                stringDistance = "";
                textBoxDistance.Lines.Initialize();
                textBoxDistance.Focus();
            }
        }

        private void textBoxMPG_Leave(object sender, EventArgs e)
        {
            //Ignore
        }

        private void buttonClear_Click(object sender, EventArgs e)
        {
            /* Reset Global Variables */
            doubleFuel = 0;
            doubleDistance = 0;
            doubleAnswer = 0;
            stringFuel = "";
            stringDistance = "";
            stringAnswer = "";
            stringTest = "";
            doubleNumberCheck = 0;
            isNumber = false;

            stringVehicleMake = "";
            stringVehicleModel = "";
            stringVehicleYear = "";
            intNumberCheck = 0;
            intVehicleYear = 0;

            /* Reset Text Boxes */
            textBoxVehicleMake.Text = "";
            textBoxVehicleModel.Text = "";
            textBoxVehicleYear.Text = "0";
            textBoxFuel.Text = "0";
            textBoxDistance.Text = "0";
            textBoxMPG.Text = "0";

            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();
        }

        private void textBoxVehicleMake_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxVehicleModel_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxVehicleYear_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxFuel_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxDistance_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void buttonCalculate_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            if (((doubleFuel == 0) && (doubleDistance == 0)) || (stringVehicleMake.Equals("")) || (stringVehicleModel.Equals("")) || (intVehicleYear == 0))
            {
                MessageBox.Show("Incomplete Vehicle Information");
            }
            else
            {
                doubleAnswer = doubleDistance / doubleFuel;
                stringAnswer = doubleAnswer.ToString();
                textBoxMPG.Text = stringAnswer;
                MessageBox.Show("Your " + stringVehicleYear + " " + stringVehicleMake + " " + stringVehicleModel + " is getting " + stringAnswer + " miles per gallon based on your given inputs");
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
