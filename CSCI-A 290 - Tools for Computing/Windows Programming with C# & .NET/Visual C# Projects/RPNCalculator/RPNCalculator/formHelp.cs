/* Filename: formHelp.cs *
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
    public partial class formHelp : Form
    {
        /* mainForm variable to represent and hold RPNCalculator */
        private RPNCalculator mainForm = null;

        public formHelp(Form callingForm)
        {
            mainForm = callingForm as RPNCalculator; //Set mainForm to be callingForm. Links RPNCalculator form to this form
            InitializeComponent();
            BackColor = mainForm.bgColor; //Set BackColor to be same as RPNCalculator form
        }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void buttonAdd_Click(object sender, EventArgs e)
        {
            /* Performs associated button click so user can see results in the RPNCalculator form without leaving the help form */
            mainForm.buttonAdd.PerformClick();
        }

        private void buttonSubtract_Click(object sender, EventArgs e)
        {
            /* Performs associated button click so user can see results in the RPNCalculator form without leaving the help form */
            mainForm.buttonSubtract.PerformClick();
        }

        private void buttonMultiply_Click(object sender, EventArgs e)
        {
            /* Performs associated button click so user can see results in the RPNCalculator form without leaving the help form */
            mainForm.buttonMultiply.PerformClick();
        }

        private void buttonDivide_Click(object sender, EventArgs e)
        {
            /* Performs associated button click so user can see results in the RPNCalculator form without leaving the help form
             * If RPNCalculator second number is 0, message box will appear explaining the error, even while inside the help form */
            if (mainForm.doubleSecondNumber == 0)
            {
                MessageBox.Show("Cannot divide by zero.\n\nClose the help form and change your second number.");
            }
            else
            {
                mainForm.buttonDivide.PerformClick();
            }
        }

        private void buttonSine_Click(object sender, EventArgs e)
        {
            /* Performs associated button click so user can see results in the RPNCalculator form without leaving the help form */
            mainForm.buttonSine.PerformClick();
        }

        private void buttonCosine_Click(object sender, EventArgs e)
        {
            /* Performs associated button click so user can see results in the RPNCalculator form without leaving the help form */
            mainForm.buttonCosine.PerformClick();
        }

        private void buttonTangent_Click(object sender, EventArgs e)
        {
            /* Performs associated button click so user can see results in the RPNCalculator form without leaving the help form */
            mainForm.buttonTangent.PerformClick();
        }

        private void buttonPower_Click(object sender, EventArgs e)
        {
            /* Performs associated button click so user can see results in the RPNCalculator form without leaving the help form */
            mainForm.buttonPower.PerformClick();
        }
    }
}
