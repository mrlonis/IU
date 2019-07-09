/* Filename: formBuffetMain.cs *
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

namespace A290Buffet
{
    public partial class formBuffetMain : Form
    {
        static bool Border = false; //Maintains whether or not we have drawn the border or not

        public formBuffetMain()
        {
            InitializeComponent();
        }

        public bool blnPromptOnExit = true; //Boolean for check box exit dialog
        public Color chosenColor = SystemColors.Desktop; //Stores chosenColor that is manipulated in formBuffetOptions

        private void openFileDialogSelectPicture_FileOk(object sender, CancelEventArgs e)
        {
        }

        private void buttonEnlarge_Click(object sender, EventArgs e)
        {
            Width = Width + 20;
            Height = Height + 20;
        }

        private void buttonQuit_Click(object sender, EventArgs e)
        {
            //Exit Application Safely
            Close();
        }

        private void buttonShrink_Click(object sender, EventArgs e)
        {
            Width = Width - 20;
            Height = Height - 20;
        }

        private void buttonDrawBorder_Click(object sender, EventArgs e)
        {
            /* This code, for the most part, will be copied in the future for options border */
            Graphics objDrawBorder = null;
            objDrawBorder = CreateGraphics();
            objDrawBorder.Clear(SystemColors.Desktop);
            objDrawBorder.DrawRectangle(Pens.Green, pictureBoxShowPicture.Left - 1, 
                pictureBoxShowPicture.Top - 1, 
                pictureBoxShowPicture.Width + 1, 
                pictureBoxShowPicture.Height + 1);
            objDrawBorder.Dispose();
            Border = true;
        }

        private void pictureBoxShowPicture_MouseMove(object sender, MouseEventArgs e)
        {
            //Use Event Handler to capture X and Y coordinates and display as text
            labelX.Text = "X: " + e.X.ToString();
            labelY.Text = "Y: " + e.Y.ToString();
        }

        private void buttonSelectPicture_Click(object sender, EventArgs e)
        {
            //Show the open file dialog box
            if (openFileDialogSelectPicture.ShowDialog() == DialogResult.OK)
            {
                // Load the picture into the picture box
                pictureBoxShowPicture.Image = Image.FromFile(openFileDialogSelectPicture.FileName);
                // Show the name of the file in the form’s caption
                Text = string.Concat("A290 Buffet(" + openFileDialogSelectPicture.FileName + ")");
            }
        }

        private void pictureBoxShowPicture_MouseLeave(object sender, EventArgs e)
        {
            /* Clear labels */
            labelX.Text = "";
            labelY.Text = "";
        }

        private void formBuffetMain_Load(object sender, EventArgs e)
        {
            /* Clear labels */
            labelX.Text = "";
            labelY.Text = "";
        }

        private void labelX_Click(object sender, EventArgs e)
        {

        }

        private void buttonOptions_Click(object sender, EventArgs e)
        {
            formBuffetOptions formBuffetOptionsDialog = new formBuffetOptions(this); //Again notice im sending 'this' aka the parent form we are currently in
            formBuffetOptionsDialog.Show();
            this.BackColor = formBuffetOptionsDialog.BackColor; //Make sure both forms are the same colors
        }

        private void pictureBoxShowPicture_Click(object sender, EventArgs e)
        {

        }

        private void pictureBoxShowPicture_Resize(object sender, EventArgs e)
        {
        }

        private void formBuffetMain_Resize(object sender, EventArgs e)
        {
            this.Refresh(); //Maintains screen fluency when resized
            
            /* If there is a border we need to redraw it */
            if (Border == true)
            {
                // Call the Click event of buttonDrawBorder.
                buttonDrawBorder.PerformClick();
            }
        }

        private void formBuffetMain_Layout(object sender, LayoutEventArgs e)
        {
        }

        private void formBuffetMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (blnPromptOnExit)
            //if box is checked,
            {
                if (MessageBox.Show("Close the Buffet Program?", "Confirm Exit", 
                    MessageBoxButtons.YesNo, 
                    MessageBoxIcon.Question) == DialogResult.No)
                //display a dialog with Yes/No buttons that asks "Close
                //the Buffet Program?,
                //uses the "?" icon, and has the caption "Confirm Exit"
                //If the user selects "No", then
                {
                    //Cancel the event frmBuffet_FormClosing
                    e.Cancel = true;
                }
                //otherwise, close the application
            }
        }

        private void buttonCollections_Click(object sender, EventArgs e)
        {
            formCollections formCollectionsDialog = new formCollections(this); //Notice im sending 'this' to the child form
            formCollectionsDialog.Show();
        }

        private void buttonQuit_KeyPress(object sender, KeyPressEventArgs e)
        {
            /* Binds keyboard values to close */
            if (e.KeyChar == Convert.ToChar(Keys.Enter)) //Enter key
            {
                //Exit Application
                Close();
            }
            else if (e.KeyChar == Convert.ToChar(Keys.Escape)) //Escape key
            {
                //Exit Application
                Close();
            }
            else
            {

            }
        }
    }
}
