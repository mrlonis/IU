/* Filename: formMain.cs *
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
    public partial class formMain : Form
    {

        public bool confirmOnExit = false;

        /* Play Click Sound */
        System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");

        public formMain()
        {
            InitializeComponent();
            pictureBoxMain.Image = Properties.Resources.Senior_Picture;
            Icon = Properties.Resources.Icons8_Ios7_Logos_Register_Editor;
        }

        private void formMain_Load(object sender, EventArgs e)
        {

        }

        private void buttonExit_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            Close();
        }

        private void buttonA290Buffet_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            formA290Buffet formA290BuffetDialog = new A290FinalProject.formA290Buffet(this);
            formA290BuffetDialog.ShowDialog();
        }

        private void buttonCalculator_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            formCalculator formCalculatorDialog = new A290FinalProject.formCalculator(this);
            formCalculatorDialog.ShowDialog();
        }

        private void buttonFuelMileageCalculator_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            formFuelMileageCalculator formFuelMileageCalculatorDialog = new A290FinalProject.formFuelMileageCalculator(this);
            formFuelMileageCalculatorDialog.ShowDialog();
        }

        private void buttonTireSizeCalculator_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            formTireSizeCalculator formTireSizeCalculatorDialog = new A290FinalProject.formTireSizeCalculator(this);
            formTireSizeCalculatorDialog.ShowDialog();
        }

        private void buttonUnitConverter_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            formUnitConverter formUnitConverterDialog = new A290FinalProject.formUnitConverter(this);
            formUnitConverterDialog.ShowDialog();
        }

        private void buttonOptions_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            formOptions formOptionsDialog = new A290FinalProject.formOptions(this);
            formOptionsDialog.ShowDialog();
        }

        private void buttonInformation_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            formInformation formInformationDialog = new A290FinalProject.formInformation(this);
            formInformationDialog.ShowDialog();
        }

        private void formMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (confirmOnExit == true)
            {
                if (MessageBox.Show("Close the program?", "Confirm Exit", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
                {
                    e.Cancel = true;
                }
                //Otherwise, close the program
            }
        }

        private void buttonExit_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == Convert.ToChar(Keys.Escape))
            {
                /* Play Click Sound */
                player.Play();

                Close();
            }
        }
    }
}
