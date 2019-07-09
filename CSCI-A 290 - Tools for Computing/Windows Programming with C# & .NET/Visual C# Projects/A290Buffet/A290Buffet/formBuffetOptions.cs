/* Filename: formBuffetOptions.cs *
 * Created by: Matthew Lonis *
 * Created on: 11/16/2016 *
 * Last Modified by: Matthew Lonis *
 * Last Modified on: 11/16/2016 *
 * Property Changes: For most all items I've changed their flat appearance, color, font size, borders etc. *
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
using A290Buffet;

namespace A290Buffet
{
    public partial class formBuffetOptions : Form
    {
        //Used to call formBuffetMain
        private formBuffetMain mainForm = null;

        public formBuffetOptions(Form callingForm)
        {
            mainForm = callingForm as formBuffetMain; //set mainForm to the callingForm... callingForm is our parent form given to us in the code for formBuffetMain
            InitializeComponent();
            BackColor = callingForm.BackColor; //Set BackColor to be the same as formBuffetMain color
        }

        /* These two variables are used to store data in my options form ONLY */
        public bool borderEnabled = false; //Bool that is true if user has drawn a border
        public Pen chosenPen = Pens.Black; //Saves selected pen border color

        private void buttonOkay_Click(object sender, EventArgs e)
        {
            //Exit Application
            Close();
        }

        private void buttonCancel_Click(object sender, EventArgs e)
        {
            //Exit Application
            Close();
        }

        /* For the radio buttons, i am only including comments for one color because the comments would basically be the same for all four colors */

        private void radioButtonBackgroundGreen_CheckedChanged(object sender, EventArgs e)
        {
            BackColor = Color.Green;
            this.mainForm.chosenColor = Color.Green; //Stores Chosen color in formBuffetMain variable
            this.mainForm.BackColor = Color.Green;

            /* If borderEnabled is true this code attempts to redraw it after changing the background color */
            if (borderEnabled == true)
            {
                /* Border code copied from earlier part of project */
                Graphics objGraphics = null;
                objGraphics = CreateGraphics();
                objGraphics.Clear(this.mainForm.chosenColor); //Must change to the color of the mainForm, otherwise the BackColor gets messed up
                objGraphics.DrawRectangle(chosenPen, 1, 1, 327, 288);
                objGraphics.Dispose();
            }
        }

        private void radioButtonBackgroundBlue_CheckedChanged(object sender, EventArgs e)
        {
            BackColor = Color.Blue;
            this.mainForm.chosenColor = Color.Blue;
            this.mainForm.BackColor = Color.Blue;

            if (borderEnabled == true)
            {
                Graphics objGraphics = null;
                objGraphics = CreateGraphics();
                objGraphics.Clear(this.mainForm.chosenColor);
                objGraphics.DrawRectangle(chosenPen, 1, 1, 327, 288);
                objGraphics.Dispose();
            }
        }

        private void radioButtonBackgroundRed_CheckedChanged(object sender, EventArgs e)
        {
            BackColor = Color.Red;
            this.mainForm.chosenColor = Color.Red;
            this.mainForm.BackColor = Color.Red;

            if (borderEnabled == true)
            {
                Graphics objGraphics = null;
                objGraphics = CreateGraphics();
                objGraphics.Clear(this.mainForm.chosenColor);
                objGraphics.DrawRectangle(chosenPen, 1, 1, 327, 288);
                objGraphics.Dispose();
            }
        }

        private void radioButtonBackgroundPurple_CheckedChanged(object sender, EventArgs e)
        {
            BackColor = Color.Purple;
            this.mainForm.chosenColor = Color.Purple;
            this.mainForm.BackColor = Color.Purple;

            if (borderEnabled == true)
            {
                Graphics objGraphics = null;
                objGraphics = CreateGraphics();
                objGraphics.Clear(this.mainForm.chosenColor);
                objGraphics.DrawRectangle(chosenPen, 1, 1, 327, 288);
                objGraphics.Dispose();
            }
        }

        /* Same as the radio controls, i will only put comments for one case because the comments would basically be the same */

        private void comboBoxBorderColors_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (comboBoxBorderColors.Text)
            {
                case "Red":
                    MessageBox.Show("Red was chosen");
                    Graphics objGraphicsRed = null;
                    objGraphicsRed = CreateGraphics();
                    objGraphicsRed.Clear(this.mainForm.chosenColor); //Maintain background color
                    objGraphicsRed.DrawRectangle(Pens.Red, 1, 1, 327, 288);
                    chosenPen = Pens.Red; //Store pen color so if user changes background color we know what pen the border should be
                    objGraphicsRed.Dispose();
                    borderEnabled = true; //Set boolean to be true because well.... the border has been drawn
                    break;
                case "Blue":
                    MessageBox.Show("Blue was chosen");
                    Graphics objGraphicsBlue = null;
                    objGraphicsBlue = CreateGraphics();
                    objGraphicsBlue.Clear(this.mainForm.chosenColor);
                    objGraphicsBlue.DrawRectangle(Pens.Blue, 1, 1, 327, 288);
                    chosenPen = Pens.Blue;
                    objGraphicsBlue.Dispose();
                    borderEnabled = true;
                    break;
                case "Yellow":
                    MessageBox.Show("Yellow was chosen");
                    Graphics objGraphicsYellow = null;
                    objGraphicsYellow = CreateGraphics();
                    objGraphicsYellow.Clear(this.mainForm.chosenColor);
                    objGraphicsYellow.DrawRectangle(Pens.Yellow, 1, 1, 327, 288);
                    chosenPen = Pens.Yellow;
                    objGraphicsYellow.Dispose();
                    borderEnabled = true;
                    break;
                case "Orange":
                    MessageBox.Show("Orange was chosen");
                    Graphics objGraphicsOrange = null;
                    objGraphicsOrange = CreateGraphics();
                    objGraphicsOrange.Clear(this.mainForm.chosenColor);
                    objGraphicsOrange.DrawRectangle(Pens.Orange, 1, 1, 327, 288);
                    chosenPen = Pens.Orange;
                    objGraphicsOrange.Dispose();
                    borderEnabled = true;
                    break;
                default:
                    MessageBox.Show("Back to the Default");
                    Graphics objGraphicsDefault = null;
                    objGraphicsDefault = CreateGraphics();
                    objGraphicsDefault.Clear(this.mainForm.chosenColor);
                    objGraphicsDefault.DrawRectangle(Pens.Black, 1, 1, 327, 288);
                    chosenPen = Pens.Black;
                    objGraphicsDefault.Dispose();
                    borderEnabled = true;
                    break;
            }
        }

        private void checkBoxExitDialog_CheckedChanged(object sender, EventArgs e)
        {
            //When state of check changes, change boolean
            this.mainForm.blnPromptOnExit = (checkBoxExitDialog.Checked);
        }

        private void formBuffetOptions_Load(object sender, EventArgs e)
        {
            //make our checkbox and boolean match values
            checkBoxExitDialog.Checked = this.mainForm.blnPromptOnExit; //Notice i am modifying the variable in our parent form. This is a way easier way of doing things
        }

        private void buttonOkay_KeyPress(object sender, KeyPressEventArgs e)
        {
            /* This block of code binds keyboard keys to the okay button */
            if (e.KeyChar == Convert.ToChar(Keys.Enter)) //Enter key
            {
                //Exit form
                Close();
            } else if (e.KeyChar == Convert.ToChar(Keys.Escape)) //Escape key
            {
                //Exit form
                Close();
            } else
            {
                //Nothing
            }
        }

        private void buttonCancel_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == Convert.ToChar(Keys.Enter))
            {
                Close();
            }
            else if (e.KeyChar == Convert.ToChar(Keys.Escape))
            {
                Close();
            }
            else
            {

            }
        }

        private void groupBoxDefaultBackgroundColor_Enter(object sender, EventArgs e)
        {

        }

        private void radioButtonDefault_CheckedChanged(object sender, EventArgs e)
        {
            BackColor = SystemColors.Desktop;
            this.mainForm.chosenColor = SystemColors.Desktop;
            this.mainForm.BackColor = SystemColors.Desktop;

            if (borderEnabled == true)
            {
                Graphics objGraphics = null;
                objGraphics = CreateGraphics();
                objGraphics.Clear(this.mainForm.chosenColor);
                objGraphics.DrawRectangle(chosenPen, 1, 1, 327, 288);
                objGraphics.Dispose();
            }
        }
    }
}
