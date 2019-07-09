/* Filename: formA290Buffet.cs *
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
    public partial class formA290Buffet : Form
    {
        /* Global Variables */
        private formMain mainForm = null;
        static bool border = false;

        /* Play Click Sound */
        System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");

        public formA290Buffet(Form callingForm)
        {
            mainForm = callingForm as formMain;
            InitializeComponent();
            BackColor = mainForm.BackColor;
            Icon = Properties.Resources.Icons8_Ios7_Logos_Register_Editor;
        }

        private void formA290Buffet_Load(object sender, EventArgs e)
        {
            labelX.Text = "";
            labelY.Text = "";
            border = false;
        }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            Close();
        }

        private void buttonEnlarge_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            Width = Width + 20;
            Height = Height + 20;
        }

        private void buttonShrink_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            Width = Width - 20;
            Height = Height - 20;
        }

        private void buttonDrawBorder_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            /* Draw Border Graphics */
            Graphics objectDrawBorder = null;
            objectDrawBorder = CreateGraphics();
            objectDrawBorder.Clear(BackColor);
            objectDrawBorder.DrawRectangle(Pens.Black, pictureBoxShowPicture.Left - 1, pictureBoxShowPicture.Top - 1, pictureBoxShowPicture.Width + 1, pictureBoxShowPicture.Height + 1);
            objectDrawBorder.Dispose();
            border = true;
        }

        private void buttonSelectPicture_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            if (openFileDialogSelectPicture.ShowDialog() == DialogResult.OK)
            {
                pictureBoxShowPicture.Image = Image.FromFile(openFileDialogSelectPicture.FileName);
                Text = string.Concat("A290 Buffet(" + openFileDialogSelectPicture.FileName + ")");
            }
        }

        private void pictureBoxShowPicture_MouseMove(object sender, MouseEventArgs e)
        {
            labelX.Text = "X: " + e.X.ToString();
            labelY.Text = "Y: " + e.Y.ToString();
        }

        private void pictureBoxShowPicture_MouseLeave(object sender, EventArgs e)
        {
            labelX.Text = "";
            labelY.Text = "";
        }

        private void formA290Buffet_Resize(object sender, EventArgs e)
        {
            Refresh();
        }

        private void buttonClose_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == Convert.ToChar(Keys.Escape))
            {
                /* Play Click Sound */
                player.Play();

                Close();
            }
        }

        private void formA290Buffet_Paint(object sender, PaintEventArgs e)
        {
            /* If border == true, redraw border graphics */
            if (border == true)
            {
                buttonDrawBorder.PerformClick();
            }
        }
    }
}
