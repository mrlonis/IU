/* Filename: formOptions.cs *
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
    public partial class formOptions : Form
    {

        private RPNCalculator mainForm = null;

        public formOptions(Form callingForm)
        {
            mainForm = callingForm as RPNCalculator; //Links to RPNCalculator form
            InitializeComponent();
            BackColor = mainForm.bgColor; //Set BackColor to be same as bgColor variable
            checkBoxConfirmOnExit.Checked = mainForm.confirmOnExit; //Set checkBox to be checked or unchecked based on boolean in RPNCalculator form
        }

        private void formOptions_Load(object sender, EventArgs e)
        {

        }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void radioButtonActiveCaption_CheckedChanged(object sender, EventArgs e)
        {
            /* Changes BackColor of current form, RPNCalculator form, and variable in RPNCalculator form */
            BackColor = SystemColors.ActiveCaption;
            mainForm.BackColor = SystemColors.ActiveCaption;
            mainForm.bgColor = SystemColors.ActiveCaption;
        }

        private void radioButtonControl_CheckedChanged(object sender, EventArgs e)
        {
            /* Changes BackColor of current form, RPNCalculator form, and variable in RPNCalculator form */
            BackColor = Color.White;
            mainForm.BackColor = Color.White;
            mainForm.bgColor = Color.White;
        }

        private void radioButtonInfo_CheckedChanged(object sender, EventArgs e)
        {
            /* Changes BackColor of current form, RPNCalculator form, and variable in RPNCalculator form */
            BackColor = SystemColors.Info;
            mainForm.BackColor = SystemColors.Info;
            mainForm.bgColor = SystemColors.Info;
        }

        private void checkBoxConfirmOnExit_CheckedChanged(object sender, EventArgs e)
        {
            //When state of check changes, change boolean in RPNCalculator form
            mainForm.confirmOnExit = (checkBoxConfirmOnExit.Checked);
        }
    }
}
