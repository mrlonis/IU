/* Filename: formInformation.cs *
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
    public partial class formInformation : Form
    {
        /* Global Variables */
        private formMain mainForm = null;

        public formInformation(Form callingForm)
        {
            mainForm = callingForm as formMain;
            InitializeComponent();
            BackColor = mainForm.BackColor;
            Icon = Properties.Resources.Icons8_Ios7_Logos_Register_Editor;
        }

        private void formInformation_Load(object sender, EventArgs e)
        {
            /* Set Text Box */
            textBoxInfo.Text = "Welcome to my A290 Final Project. In this program, I implement two forms that we worked on in class (A290 Buffet & Calculator). I then added my own form (Fuel Mileage Calculator, Tire Size Calculator/Comparison, and Unit Converter). My Fuel Mileage Calculator works very similarly to Calculator. Tire Size Calculator and Comparison take in Radial Tire measurements and converts them to inches and compares sizes between two tires. My unit converter converts units of mass, length, volume, or temperature and implement a dynamic comboBox style where the contents of the comboBox change with user input. I hope you enjoy my project and find my application easy to use!";
        }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
            player.Play();

            Close();
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
