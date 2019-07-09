namespace A290FinalProject
{
    partial class formFuelMileageCalculator
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.buttonClose = new System.Windows.Forms.Button();
            this.labelVehicleMake = new System.Windows.Forms.Label();
            this.labelVehicleModel = new System.Windows.Forms.Label();
            this.labelVehicleYear = new System.Windows.Forms.Label();
            this.labelFuel = new System.Windows.Forms.Label();
            this.labelDistance = new System.Windows.Forms.Label();
            this.labelAnswer = new System.Windows.Forms.Label();
            this.buttonCalculate = new System.Windows.Forms.Button();
            this.buttonClear = new System.Windows.Forms.Button();
            this.textBoxVehicleMake = new System.Windows.Forms.TextBox();
            this.textBoxMPG = new System.Windows.Forms.TextBox();
            this.textBoxDistance = new System.Windows.Forms.TextBox();
            this.textBoxFuel = new System.Windows.Forms.TextBox();
            this.textBoxVehicleYear = new System.Windows.Forms.TextBox();
            this.textBoxVehicleModel = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // buttonClose
            // 
            this.buttonClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonClose.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClose.FlatAppearance.BorderSize = 0;
            this.buttonClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClose.Location = new System.Drawing.Point(234, 281);
            this.buttonClose.Name = "buttonClose";
            this.buttonClose.Size = new System.Drawing.Size(90, 30);
            this.buttonClose.TabIndex = 9;
            this.buttonClose.Text = "Close";
            this.buttonClose.UseVisualStyleBackColor = false;
            this.buttonClose.Click += new System.EventHandler(this.buttonClose_Click);
            this.buttonClose.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.buttonClose_KeyPress);
            // 
            // labelVehicleMake
            // 
            this.labelVehicleMake.AutoSize = true;
            this.labelVehicleMake.Location = new System.Drawing.Point(78, 15);
            this.labelVehicleMake.Name = "labelVehicleMake";
            this.labelVehicleMake.Size = new System.Drawing.Size(108, 20);
            this.labelVehicleMake.TabIndex = 1;
            this.labelVehicleMake.Text = "Vehicle Make:";
            this.labelVehicleMake.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelVehicleModel
            // 
            this.labelVehicleModel.AutoSize = true;
            this.labelVehicleModel.Location = new System.Drawing.Point(74, 47);
            this.labelVehicleModel.Name = "labelVehicleModel";
            this.labelVehicleModel.Size = new System.Drawing.Size(112, 20);
            this.labelVehicleModel.TabIndex = 2;
            this.labelVehicleModel.Text = "Vehicle Model:";
            this.labelVehicleModel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelVehicleYear
            // 
            this.labelVehicleYear.AutoSize = true;
            this.labelVehicleYear.Location = new System.Drawing.Point(83, 79);
            this.labelVehicleYear.Name = "labelVehicleYear";
            this.labelVehicleYear.Size = new System.Drawing.Size(103, 20);
            this.labelVehicleYear.TabIndex = 3;
            this.labelVehicleYear.Text = "Vehicle Year:";
            this.labelVehicleYear.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelFuel
            // 
            this.labelFuel.AutoSize = true;
            this.labelFuel.Location = new System.Drawing.Point(13, 111);
            this.labelFuel.Name = "labelFuel";
            this.labelFuel.Size = new System.Drawing.Size(174, 20);
            this.labelFuel.TabIndex = 4;
            this.labelFuel.Text = "Fuel Amount (US gals):";
            this.labelFuel.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelDistance
            // 
            this.labelDistance.AutoSize = true;
            this.labelDistance.Location = new System.Drawing.Point(60, 143);
            this.labelDistance.Name = "labelDistance";
            this.labelDistance.Size = new System.Drawing.Size(126, 20);
            this.labelDistance.TabIndex = 5;
            this.labelDistance.Text = "Distance (Miles):";
            // 
            // labelAnswer
            // 
            this.labelAnswer.AutoSize = true;
            this.labelAnswer.Location = new System.Drawing.Point(137, 239);
            this.labelAnswer.Name = "labelAnswer";
            this.labelAnswer.Size = new System.Drawing.Size(49, 20);
            this.labelAnswer.TabIndex = 6;
            this.labelAnswer.Text = "MPG:";
            // 
            // buttonCalculate
            // 
            this.buttonCalculate.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonCalculate.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonCalculate.FlatAppearance.BorderSize = 0;
            this.buttonCalculate.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonCalculate.Location = new System.Drawing.Point(87, 187);
            this.buttonCalculate.Name = "buttonCalculate";
            this.buttonCalculate.Size = new System.Drawing.Size(237, 30);
            this.buttonCalculate.TabIndex = 6;
            this.buttonCalculate.Text = "Calculate!";
            this.buttonCalculate.UseVisualStyleBackColor = false;
            this.buttonCalculate.Click += new System.EventHandler(this.buttonCalculate_Click);
            // 
            // buttonClear
            // 
            this.buttonClear.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonClear.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClear.FlatAppearance.BorderSize = 0;
            this.buttonClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClear.Location = new System.Drawing.Point(138, 281);
            this.buttonClear.Name = "buttonClear";
            this.buttonClear.Size = new System.Drawing.Size(90, 30);
            this.buttonClear.TabIndex = 8;
            this.buttonClear.Text = "Clear";
            this.buttonClear.UseVisualStyleBackColor = false;
            this.buttonClear.Click += new System.EventHandler(this.buttonClear_Click);
            // 
            // textBoxVehicleMake
            // 
            this.textBoxVehicleMake.Location = new System.Drawing.Point(192, 12);
            this.textBoxVehicleMake.Name = "textBoxVehicleMake";
            this.textBoxVehicleMake.Size = new System.Drawing.Size(132, 26);
            this.textBoxVehicleMake.TabIndex = 1;
            this.textBoxVehicleMake.Leave += new System.EventHandler(this.textBoxVehicleMake_Leave);
            this.textBoxVehicleMake.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxVehicleMake_MouseDown);
            // 
            // textBoxMPG
            // 
            this.textBoxMPG.Location = new System.Drawing.Point(192, 236);
            this.textBoxMPG.Name = "textBoxMPG";
            this.textBoxMPG.Size = new System.Drawing.Size(132, 26);
            this.textBoxMPG.TabIndex = 7;
            // 
            // textBoxDistance
            // 
            this.textBoxDistance.Location = new System.Drawing.Point(192, 140);
            this.textBoxDistance.Name = "textBoxDistance";
            this.textBoxDistance.Size = new System.Drawing.Size(132, 26);
            this.textBoxDistance.TabIndex = 5;
            this.textBoxDistance.Leave += new System.EventHandler(this.textBoxDistance_Leave);
            this.textBoxDistance.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxDistance_MouseDown);
            // 
            // textBoxFuel
            // 
            this.textBoxFuel.Location = new System.Drawing.Point(192, 108);
            this.textBoxFuel.Name = "textBoxFuel";
            this.textBoxFuel.Size = new System.Drawing.Size(132, 26);
            this.textBoxFuel.TabIndex = 4;
            this.textBoxFuel.Leave += new System.EventHandler(this.textBoxFuel_Leave);
            this.textBoxFuel.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxFuel_MouseDown);
            // 
            // textBoxVehicleYear
            // 
            this.textBoxVehicleYear.Location = new System.Drawing.Point(192, 76);
            this.textBoxVehicleYear.Name = "textBoxVehicleYear";
            this.textBoxVehicleYear.Size = new System.Drawing.Size(132, 26);
            this.textBoxVehicleYear.TabIndex = 3;
            this.textBoxVehicleYear.Leave += new System.EventHandler(this.textBoxVehicleYear_Leave);
            this.textBoxVehicleYear.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxVehicleYear_MouseDown);
            // 
            // textBoxVehicleModel
            // 
            this.textBoxVehicleModel.Location = new System.Drawing.Point(192, 44);
            this.textBoxVehicleModel.Name = "textBoxVehicleModel";
            this.textBoxVehicleModel.Size = new System.Drawing.Size(132, 26);
            this.textBoxVehicleModel.TabIndex = 2;
            this.textBoxVehicleModel.Leave += new System.EventHandler(this.textBoxVehicleModel_Leave);
            this.textBoxVehicleModel.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxVehicleModel_MouseDown);
            // 
            // formFuelMileageCalculator
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.RosyBrown;
            this.ClientSize = new System.Drawing.Size(341, 333);
            this.Controls.Add(this.textBoxVehicleModel);
            this.Controls.Add(this.textBoxVehicleYear);
            this.Controls.Add(this.textBoxFuel);
            this.Controls.Add(this.textBoxDistance);
            this.Controls.Add(this.textBoxMPG);
            this.Controls.Add(this.textBoxVehicleMake);
            this.Controls.Add(this.buttonClear);
            this.Controls.Add(this.buttonCalculate);
            this.Controls.Add(this.labelAnswer);
            this.Controls.Add(this.labelDistance);
            this.Controls.Add(this.labelFuel);
            this.Controls.Add(this.labelVehicleYear);
            this.Controls.Add(this.labelVehicleModel);
            this.Controls.Add(this.labelVehicleMake);
            this.Controls.Add(this.buttonClose);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "formFuelMileageCalculator";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Fuel Mileage Calculator";
            this.Load += new System.EventHandler(this.formFuelMileageCalculator_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonClose;
        private System.Windows.Forms.Label labelVehicleMake;
        private System.Windows.Forms.Label labelVehicleModel;
        private System.Windows.Forms.Label labelVehicleYear;
        private System.Windows.Forms.Label labelFuel;
        private System.Windows.Forms.Label labelDistance;
        private System.Windows.Forms.Label labelAnswer;
        private System.Windows.Forms.Button buttonCalculate;
        private System.Windows.Forms.Button buttonClear;
        private System.Windows.Forms.TextBox textBoxVehicleMake;
        private System.Windows.Forms.TextBox textBoxMPG;
        private System.Windows.Forms.TextBox textBoxDistance;
        private System.Windows.Forms.TextBox textBoxFuel;
        private System.Windows.Forms.TextBox textBoxVehicleYear;
        private System.Windows.Forms.TextBox textBoxVehicleModel;
    }
}