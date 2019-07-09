/* Filename: formUnitConverter.cs *
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
    public partial class formUnitConverter : Form
    {
        /* Play Click Sound */
        System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");

        private formMain mainForm = null;

        /* Arrays for comboBox */
        public string[] length = new string[7] {"Kilometer(km)", "Meter(m)", "Centimeter(cm)", "Millimeter(mm)", "Mile(mi)", "Feet(ft)", "Inch(in)"};
        public string[] mass = new string[3] {"Kilogram(kg)", "Gram(g)", "Pound(lb)"};
        public string[] volume = new string[4] {"Liter(L)", "Milliliter(mL)", "Cubic Meter(m3)", "Cubic Centimeter(cm3)"};
        public string[] temperature = new string[3] {"Fahrenheit(F)", "Celcius(C)", "Kelvin(K)"};

        /* Global Variables */
        public static double doubleFirstNumber = 0;
        public static double doubleAnswer = 0;
        public static string stringFirstNumber = "";
        public static string stringAnswer = "";
        public static string stringTest = "";
        public static double doubleNumberCheck = 0;
        public static bool isNumber = false;

        public string stringType1 = "";
        public string stringType2 = "";

        public formUnitConverter(Form callingForm)
        {
            mainForm = callingForm as formMain;
            InitializeComponent();
            BackColor = mainForm.BackColor;
            Icon = Properties.Resources.Icons8_Ios7_Logos_Register_Editor;
        }

        private void formUnitConverter_Load(object sender, EventArgs e)
        {
            labelDataType.Text = "Length";
            comboBoxDataType.SelectedIndex = comboBoxDataType.FindStringExact("Length");

            comboBoxNumber1Type.Items.Clear();
            comboBoxNumber1Type.Items.AddRange(length);

            comboBoxNumber2Type.Items.Clear();
            comboBoxNumber2Type.Items.AddRange(length);

            textBoxNumber1.Text = "0";
            textBoxNumber2.Text = "";

            stringType1 = "";
            stringType2 = "";

            doubleFirstNumber = 0;
            doubleAnswer = 0;
            stringFirstNumber = "";
            stringAnswer = "";
            stringTest = "";
            doubleNumberCheck = 0;
            isNumber = false;
        }

        private void buttonClose_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            Close();
        }

        private void comboBoxDataType_SelectionChangeCommitted(object sender, EventArgs e)
        {
            /* Change ComboBoxType1 strings based on selection */
            if (comboBoxDataType.SelectedItem.ToString().Equals("Length"))
            {
                labelDataType.Text = "Length";
                comboBoxDataType.SelectedIndex = comboBoxDataType.FindStringExact("Length");

                comboBoxNumber1Type.Items.Clear();
                comboBoxNumber1Type.Items.AddRange(length);
                comboBoxNumber1Type.ResetText();

                comboBoxNumber2Type.Items.Clear();
                comboBoxNumber2Type.Items.AddRange(length);
                comboBoxNumber2Type.ResetText();

                textBoxNumber1.Text = "0";
                textBoxNumber2.Text = "";
                doubleFirstNumber = 0;
                doubleAnswer = 0;
                stringFirstNumber = "";
                stringAnswer = "";
                stringTest = "";
                doubleNumberCheck = 0;
                isNumber = false;
            }
            else if (comboBoxDataType.SelectedItem.ToString().Equals("Mass"))
            {
                labelDataType.Text = "Mass";
                comboBoxDataType.SelectedIndex = comboBoxDataType.FindStringExact("Mass");

                comboBoxNumber1Type.Items.Clear();
                comboBoxNumber1Type.Items.AddRange(mass);
                comboBoxNumber1Type.ResetText();

                comboBoxNumber2Type.Items.Clear();
                comboBoxNumber2Type.Items.AddRange(mass);
                comboBoxNumber2Type.ResetText();

                textBoxNumber1.Text = "0";
                textBoxNumber2.Text = "";
                doubleFirstNumber = 0;
                doubleAnswer = 0;
                stringFirstNumber = "";
                stringAnswer = "";
                stringTest = "";
                doubleNumberCheck = 0;
                isNumber = false;
            }
            else if (comboBoxDataType.SelectedItem.ToString().Equals("Volume"))
            {
                labelDataType.Text = "Volume";
                comboBoxDataType.SelectedIndex = comboBoxDataType.FindStringExact("Volume");

                comboBoxNumber1Type.Items.Clear();
                comboBoxNumber1Type.Items.AddRange(volume);
                comboBoxNumber1Type.ResetText();

                comboBoxNumber2Type.Items.Clear();
                comboBoxNumber2Type.Items.AddRange(volume);
                comboBoxNumber2Type.ResetText();

                textBoxNumber1.Text = "0";
                textBoxNumber2.Text = "";
                doubleFirstNumber = 0;
                doubleAnswer = 0;
                stringFirstNumber = "";
                stringAnswer = "";
                stringTest = "";
                doubleNumberCheck = 0;
                isNumber = false;
            }
            else if (comboBoxDataType.SelectedItem.ToString().Equals("Temperature"))
            {
                labelDataType.Text = "Temperature";
                comboBoxDataType.SelectedIndex = comboBoxDataType.FindStringExact("Temperature");

                comboBoxNumber1Type.Items.Clear();
                comboBoxNumber1Type.Items.AddRange(temperature);
                comboBoxNumber1Type.ResetText();

                comboBoxNumber2Type.Items.Clear();
                comboBoxNumber2Type.Items.AddRange(temperature);
                comboBoxNumber2Type.ResetText();

                textBoxNumber1.Text = "0";
                textBoxNumber2.Text = "";
                doubleFirstNumber = 0;
                doubleAnswer = 0;
                stringFirstNumber = "";
                stringAnswer = "";
                stringTest = "";
                doubleNumberCheck = 0;
                isNumber = false;
            }
        }

        private void comboBoxNumber1Type_SelectionChangeCommitted(object sender, EventArgs e)
        {
            /* Change comboBoxType2 strings based on type 1 selection */
            if (comboBoxDataType.SelectedItem.ToString().Equals("Length"))
            {
                comboBoxNumber2Type.Items.Clear();
                comboBoxNumber2Type.Items.AddRange(length);
                comboBoxNumber2Type.ResetText();
                comboBoxNumber2Type.Items.Remove(comboBoxNumber1Type.SelectedItem.ToString());

                textBoxNumber2.Text = "";
                doubleAnswer = 0;
                stringAnswer = "";
                stringTest = "";
                doubleNumberCheck = 0;
                isNumber = false;
            }
            else if (comboBoxDataType.SelectedItem.ToString().Equals("Mass"))
            {
                comboBoxNumber2Type.Items.Clear();
                comboBoxNumber2Type.Items.AddRange(mass);
                comboBoxNumber2Type.ResetText();
                comboBoxNumber2Type.Items.Remove(comboBoxNumber1Type.SelectedItem.ToString());

                textBoxNumber2.Text = "";
                doubleAnswer = 0;
                stringAnswer = "";
                stringTest = "";
                doubleNumberCheck = 0;
                isNumber = false;
            }
            else if (comboBoxDataType.SelectedItem.ToString().Equals("Volume"))
            {
                comboBoxNumber2Type.Items.Clear();
                comboBoxNumber2Type.Items.AddRange(volume);
                comboBoxNumber2Type.ResetText();
                comboBoxNumber2Type.Items.Remove(comboBoxNumber1Type.SelectedItem.ToString());

                textBoxNumber2.Text = "";
                doubleAnswer = 0;
                stringAnswer = "";
                stringTest = "";
                doubleNumberCheck = 0;
                isNumber = false;
            }
            else if (comboBoxDataType.SelectedItem.ToString().Equals("Temperature"))
            {
                comboBoxNumber2Type.Items.Clear();
                comboBoxNumber2Type.Items.AddRange(temperature);
                comboBoxNumber2Type.ResetText();
                comboBoxNumber2Type.Items.Remove(comboBoxNumber1Type.SelectedItem.ToString());

                textBoxNumber2.Text = "";
                doubleAnswer = 0;
                stringAnswer = "";
                stringTest = "";
                doubleNumberCheck = 0;
                isNumber = false;
            }

            stringType1 = comboBoxNumber1Type.SelectedItem.ToString();
        }

        private void textBoxNumber1_Leave(object sender, EventArgs e)
        {
            /* Copy text inside text box to variables */
            stringFirstNumber = textBoxNumber1.Text.ToString();
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
                textBoxNumber1.Text = "0";
                stringFirstNumber = "";
                textBoxNumber1.Lines.Initialize();
                textBoxNumber1.Focus();
            }
        }

        private void textBoxNumber1_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void textBoxNumber2_Leave(object sender, EventArgs e)
        {
            
        }

        private void textBoxNumber2_MouseDown(object sender, MouseEventArgs e)
        {
            ((TextBox)sender).SelectAll();
        }

        private void buttonReset_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            labelDataType.Text = "Length";
            comboBoxDataType.SelectedIndex = comboBoxDataType.FindStringExact("Length");

            comboBoxNumber1Type.Items.Clear();
            comboBoxNumber1Type.Items.AddRange(length);
            comboBoxNumber1Type.ResetText();

            comboBoxNumber2Type.Items.Clear();
            comboBoxNumber2Type.Items.AddRange(length);
            comboBoxNumber2Type.ResetText();

            textBoxNumber1.Text = "0";
            textBoxNumber2.Text = "";

            stringType1 = "";
            stringType2 = "";

            doubleFirstNumber = 0;
            doubleAnswer = 0;
            stringFirstNumber = "";
            stringAnswer = "";
            stringTest = "";
            doubleNumberCheck = 0;
            isNumber = false;
        }

        private void buttonConvert_Click(object sender, EventArgs e)
        {
            /* Play Click Sound */
            player.Play();

            if ((stringType1.Equals("")) || (stringType2.Equals("")))
            {
                MessageBox.Show("Incomplete Data Types for Conversion Selected");
            }
            else
            {
                /* Check Main Data Type */
                if (comboBoxDataType.SelectedItem.ToString().Equals("Length"))
                {
                    /* Check First Number's Data Type */
                    if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Kilometer(km)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Meter(m)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1000;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Centimeter(cm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 100000;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Millimeter(mm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1000000;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Mile(mi)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.621371;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Feet(ft)"))
                        {
                            doubleAnswer = doubleFirstNumber * 3280.84;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Inch(in)"))
                        {
                            doubleAnswer = doubleFirstNumber * 39370.1;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Meter(m)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Kilometer(km)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.001;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Centimeter(cm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 100;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Millimeter(mm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1000;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Mile(mi)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.000621371;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Feet(ft)"))
                        {
                            doubleAnswer = doubleFirstNumber * 3.28084;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Inch(in)"))
                        {
                            doubleAnswer = doubleFirstNumber * 39.3701;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Centimeter(cm)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Kilometer(km)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.00001;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Meter(m)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.01;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Millimeter(mm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 10;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Mile(mi)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.0000062137;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Feet(ft)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.0328084;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Inch(in)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.393701;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Millimeter(mm)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Kilometer(km)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.000001;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Meter(m)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.001;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Centimeter(cm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.1;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Mile(mi)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.00000062137;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Feet(ft)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.00328084;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Inch(in)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.0393701;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Mile(mi)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Kilometer(km)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1.60934;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Meter(m)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1609.34;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Centimeter(cm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 160934;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Millimeter(mm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1609000;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Feet(ft)"))
                        {
                            doubleAnswer = doubleFirstNumber * 5280;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Inch(in)"))
                        {
                            doubleAnswer = doubleFirstNumber * 63360;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Feet(ft)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Kilometer(km)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.0003048;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Meter(m)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.3048;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Centimeter(cm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 30.48;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Millimeter(mm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 304.8;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Mile(mi)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.000189394;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Inch(in)"))
                        {
                            doubleAnswer = doubleFirstNumber * 12;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Inch(in)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Kilometer(km)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.0000254;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Meter(m)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.0254;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Centimeter(cm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 2.54;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Millimeter(mm)"))
                        {
                            doubleAnswer = doubleFirstNumber * 25.4;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Mile(mi)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.000015783;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Feet(ft)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.0833333;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    /* End Check First Number's Data Type */
                }
                else if (comboBoxDataType.SelectedItem.ToString().Equals("Mass"))
                {
                    /* Check First Number's Data Type */
                    if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Kilogram(kg)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Gram(g)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1000;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Pounds(lb)"))
                        {
                            doubleAnswer = doubleFirstNumber * 2.20462;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Gram(g)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Kilogram(kg)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.001;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Pound(lb)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.00220462;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Pound(lb)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Kilogram(kg)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.453592;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Gram(g)"))
                        {
                            doubleAnswer = doubleFirstNumber * 453.592;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    /* End Check First Number's Data Type */
                }
                else if (comboBoxDataType.SelectedItem.ToString().Equals("Volume"))
                {
                    /* Check First Number's Data Type */
                    if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Liter(L)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Milliliter(mL)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1000;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Cubic Meter(m3)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.001;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Cubic Centimeter(cm3)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1000;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Milliliter(mL)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Liter(L)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.001;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Cubic Meter(m3)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.000001;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Cubic Centimeter(cm3)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Cubic Meter(m3)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Liter(L)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1000;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Milliliter(mL)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1000000;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Cubic centimeters(cm3)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1000000;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Cubic Centimeters(cm3)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Liter(L)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.001;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Milliliter(mL)"))
                        {
                            doubleAnswer = doubleFirstNumber * 1;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Cubic Meter(m3)"))
                        {
                            doubleAnswer = doubleFirstNumber * 0.000001;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    /* End Check First Number's Data Type */
                }
                else if (comboBoxDataType.SelectedItem.ToString().Equals("Temperature"))
                {
                    /* Check First Number's Data Type */
                    if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Fahrenheit(F)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Celcius(C)"))
                        {
                            doubleAnswer = ((doubleFirstNumber - 32.0) * (5.0 / 9.0));
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Kelvin(K)"))
                        {
                            doubleAnswer = ((doubleFirstNumber - 32.0) * (5.0 / 9.0)) + 273.15;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Celcius(C)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Fahrenheit(F)"))
                        {
                            doubleAnswer = doubleFirstNumber * (9.0 / 5.0) + 32.0;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Kelvin(K)"))
                        {
                            doubleAnswer = doubleFirstNumber + 273.15;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    else if (comboBoxNumber1Type.SelectedItem.ToString().Equals("Kelvin(K)"))
                    {
                        /* Check Second Number's Data Type */
                        if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Fahrenheit(F)"))
                        {
                            doubleAnswer = (doubleFirstNumber - 273.15) * (9.0 / 5.0) + 32.0;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        else if (comboBoxNumber2Type.SelectedItem.ToString().Equals("Celcius(C)"))
                        {
                            doubleAnswer = doubleFirstNumber - 273.15;
                            stringAnswer = doubleAnswer.ToString();
                            textBoxNumber2.Text = stringAnswer;
                        }
                        /* End Check Second Number's Data Type */
                    }
                    /* End Check First Number's Data Type */
                }
                /* End Check Main Data Type */
            }
        }

        private void comboBoxNumber2Type_SelectionChangeCommitted(object sender, EventArgs e)
        {
            stringType2 = comboBoxNumber2Type.SelectedItem.ToString();
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
    }
}
