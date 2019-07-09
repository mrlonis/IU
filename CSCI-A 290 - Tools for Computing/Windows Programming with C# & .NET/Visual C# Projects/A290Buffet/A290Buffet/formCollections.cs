/* Filename: formCollections.cs *
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
    public partial class formCollections : Form
    {
        /* mainForm will be used to call formBuffetMain */
        private formBuffetMain mainForm = null;
        /* I am calling formBuffetMain in order to link the variables between forms and allow child forms to access and modify parent form variables */
        public formCollections(Form callingForm) //Added a parameter to call formBuffetMain
        {
            mainForm = callingForm as formBuffetMain; //Call formBuffetMain
            InitializeComponent();
            BackColor = callingForm.BackColor; //Set BackColor to the same BackColor as
        }

        private void formCollections_Load(object sender, EventArgs e)
        {

        }

        private void buttonShowNames_Click(object sender, EventArgs e)
        {
            /* Steps through and shows names of all controls */
            for (int intIndex = 0; intIndex < Controls.Count; intIndex++)
            {
                MessageBox.Show("Control #" + intIndex.ToString() + " has the name " + Controls[intIndex].Name);
            }
        }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            //Exit Application
            Close();
        }

        private void buttonClose_KeyPress(object sender, KeyPressEventArgs e)
        {
            /* Binds keyboard values to close button */
            if (e.KeyChar == Convert.ToChar(Keys.Enter)) //Enter Key
            {
                //Exit Form
                Close();
            }
            else if (e.KeyChar == Convert.ToChar(Keys.Escape)) //Escape key
            {
                //Exit Form
                Close();
            }
            else
            {
                //Nothing to do here
            }
        }
    }
}
