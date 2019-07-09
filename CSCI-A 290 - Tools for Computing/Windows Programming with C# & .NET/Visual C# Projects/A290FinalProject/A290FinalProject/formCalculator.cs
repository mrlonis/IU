/* Filename: formCalculator.cs *
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
    public partial class formCalculator : Form
    {

        private formMain mainForm = null;

        public formCalculator(Form callingForm)
        {
            mainForm = callingForm as formMain;
            InitializeComponent();
            BackColor = mainForm.BackColor;
            Icon = Properties.Resources.Icons8_Ios7_Logos_Register_Editor;
        }

        /* Global Variables */
        public double doubleFirstNumber = 0;
        public double doubleSecondNumber = 0;
        public double doubleAnswer = 0;
        public string stringFirstNumber = "";
        public string stringSecondNumber = "";
        public string stringAnswer = "";
        public string stringTest = "";
        public double doubleNumberCheck = 0;
        public bool isNumber;

        private void formCalculator_Load(object sender, EventArgs e)
        {
            /* Set initial text boxes */
            textBoxFirstNumber.Text = "0";
            textBoxSecondNumber.Text = "0";
            textBoxAnswer.Text = "0";

            /* Set Global Variables */
            doubleFirstNumber = 0;
            doubleSecondNumber = 0;
            doubleAnswer = 0;
            stringFirstNumber = "";
            stringSecondNumber = "";
            stringAnswer = "";
            stringTest = "";
            doubleNumberCheck = 0;
            isNumber = false;
    }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            Close();
        }

        private void textBoxfirstNumber_Leave(object sender, EventArgs e)
        {
            //Ignore, some error caused this to remain. New event handler is called textBoxFirstNumber_Leave_1
            //See Below
        }

        private void textBoxSecondNumber_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringSecondNumber = textBoxSecondNumber.Text.ToString();
            stringTest = stringSecondNumber;

            /* Set Boolean Value */
            isNumber = double.TryParse(stringTest, out doubleNumberCheck);

            /* Operations based on boolean value */
            if (isNumber == true)
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

        private void textBoxFirstNumber_Leave_1(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringFirstNumber = textBoxFirstNumber.Text.ToString();
            stringTest = stringFirstNumber;

            /* Set Boolean Value */
            isNumber = double.TryParse(stringTest, out doubleNumberCheck);

            /* Operations based on boolean value */
            if (isNumber == true)
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

        private void textBoxFirstNumber_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxSecondNumber_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void buttonClear_Click(object sender, EventArgs e)
        {
            /* Reset Text Boxes */
            textBoxFirstNumber.Text = "0";
            textBoxSecondNumber.Text = "0";
            textBoxAnswer.Text = "0";

            /* Reset Global Variables */
            doubleFirstNumber = 0;
            doubleSecondNumber = 0;
            doubleAnswer = 0;
            stringFirstNumber = "";
            stringSecondNumber = "";
            stringAnswer = "";
            stringTest = "";
            doubleNumberCheck = 0;
            isNumber = false;

            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();
        }

        private void buttonAdd_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            doubleAnswer = doubleFirstNumber + doubleSecondNumber;
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonSubtract_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            doubleAnswer = doubleFirstNumber - doubleSecondNumber;
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonMultiply_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            doubleAnswer = doubleFirstNumber * doubleSecondNumber;
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonDivide_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            /* If number equals zero, this will pop an error via a message box */
            if (doubleSecondNumber == 0)
            {
                MessageBox.Show("Cannot divide by zero");
                textBoxSecondNumber.Focus();
            }
            else
            {
                doubleAnswer = doubleFirstNumber / doubleSecondNumber;
                stringAnswer = doubleAnswer.ToString();
                textBoxAnswer.Text = stringAnswer;
            }
        }

        private void buttonSine_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            doubleAnswer = Math.Sin(doubleFirstNumber);
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonCosine_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            doubleAnswer = Math.Cos(doubleFirstNumber);
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonTangent_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            doubleAnswer = Math.Tan(doubleFirstNumber);
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonPower_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            doubleAnswer = Math.Pow(doubleFirstNumber, doubleSecondNumber);
            stringAnswer = doubleAnswer.ToString();
            textBoxAnswer.Text = stringAnswer;
        }

        private void buttonHelp_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            formCalculatorHelp formCalculatorHelpDialog = new formCalculatorHelp(this);
            formCalculatorHelpDialog.ShowDialog();
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
