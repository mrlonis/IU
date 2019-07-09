namespace A290Buffet
{
    partial class formBuffetOptions
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(formBuffetOptions));
            this.buttonOkay = new System.Windows.Forms.Button();
            this.buttonCancel = new System.Windows.Forms.Button();
            this.groupBoxDefaultBackgroundColor = new System.Windows.Forms.GroupBox();
            this.radioButtonBackgroundPurple = new System.Windows.Forms.RadioButton();
            this.radioButtonBackgroundRed = new System.Windows.Forms.RadioButton();
            this.radioButtonBackgroundBlue = new System.Windows.Forms.RadioButton();
            this.radioButtonBackgroundGreen = new System.Windows.Forms.RadioButton();
            this.comboBoxBorderColors = new System.Windows.Forms.ComboBox();
            this.checkBoxExitDialog = new System.Windows.Forms.CheckBox();
            this.labelUserName = new System.Windows.Forms.Label();
            this.textBoxUserName = new System.Windows.Forms.TextBox();
            this.radioButtonDefault = new System.Windows.Forms.RadioButton();
            this.groupBoxDefaultBackgroundColor.SuspendLayout();
            this.SuspendLayout();
            // 
            // buttonOkay
            // 
            this.buttonOkay.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonOkay.BackColor = System.Drawing.SystemColors.ControlDark;
            this.buttonOkay.FlatAppearance.BorderSize = 0;
            this.buttonOkay.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonOkay.ForeColor = System.Drawing.SystemColors.Window;
            this.buttonOkay.Location = new System.Drawing.Point(652, 12);
            this.buttonOkay.Name = "buttonOkay";
            this.buttonOkay.Size = new System.Drawing.Size(215, 50);
            this.buttonOkay.TabIndex = 0;
            this.buttonOkay.Text = "Okay";
            this.buttonOkay.UseVisualStyleBackColor = false;
            this.buttonOkay.Click += new System.EventHandler(this.buttonOkay_Click);
            this.buttonOkay.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.buttonOkay_KeyPress);
            // 
            // buttonCancel
            // 
            this.buttonCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonCancel.BackColor = System.Drawing.SystemColors.ControlDark;
            this.buttonCancel.FlatAppearance.BorderSize = 0;
            this.buttonCancel.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonCancel.ForeColor = System.Drawing.SystemColors.Window;
            this.buttonCancel.Location = new System.Drawing.Point(652, 68);
            this.buttonCancel.Name = "buttonCancel";
            this.buttonCancel.Size = new System.Drawing.Size(215, 50);
            this.buttonCancel.TabIndex = 1;
            this.buttonCancel.Text = "Cancel";
            this.buttonCancel.UseVisualStyleBackColor = false;
            this.buttonCancel.Click += new System.EventHandler(this.buttonCancel_Click);
            this.buttonCancel.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.buttonCancel_KeyPress);
            // 
            // groupBoxDefaultBackgroundColor
            // 
            this.groupBoxDefaultBackgroundColor.BackColor = System.Drawing.SystemColors.Control;
            this.groupBoxDefaultBackgroundColor.Controls.Add(this.radioButtonDefault);
            this.groupBoxDefaultBackgroundColor.Controls.Add(this.radioButtonBackgroundPurple);
            this.groupBoxDefaultBackgroundColor.Controls.Add(this.radioButtonBackgroundRed);
            this.groupBoxDefaultBackgroundColor.Controls.Add(this.radioButtonBackgroundBlue);
            this.groupBoxDefaultBackgroundColor.Controls.Add(this.radioButtonBackgroundGreen);
            this.groupBoxDefaultBackgroundColor.Location = new System.Drawing.Point(13, 13);
            this.groupBoxDefaultBackgroundColor.Name = "groupBoxDefaultBackgroundColor";
            this.groupBoxDefaultBackgroundColor.Size = new System.Drawing.Size(628, 191);
            this.groupBoxDefaultBackgroundColor.TabIndex = 2;
            this.groupBoxDefaultBackgroundColor.TabStop = false;
            this.groupBoxDefaultBackgroundColor.Text = "Options Default Background Color";
            this.groupBoxDefaultBackgroundColor.Enter += new System.EventHandler(this.groupBoxDefaultBackgroundColor_Enter);
            // 
            // radioButtonBackgroundPurple
            // 
            this.radioButtonBackgroundPurple.AutoSize = true;
            this.radioButtonBackgroundPurple.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.1F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radioButtonBackgroundPurple.ForeColor = System.Drawing.Color.Purple;
            this.radioButtonBackgroundPurple.Location = new System.Drawing.Point(267, 122);
            this.radioButtonBackgroundPurple.Name = "radioButtonBackgroundPurple";
            this.radioButtonBackgroundPurple.Size = new System.Drawing.Size(141, 36);
            this.radioButtonBackgroundPurple.TabIndex = 3;
            this.radioButtonBackgroundPurple.TabStop = true;
            this.radioButtonBackgroundPurple.Text = "Purple";
            this.radioButtonBackgroundPurple.UseVisualStyleBackColor = true;
            this.radioButtonBackgroundPurple.CheckedChanged += new System.EventHandler(this.radioButtonBackgroundPurple_CheckedChanged);
            // 
            // radioButtonBackgroundRed
            // 
            this.radioButtonBackgroundRed.AutoSize = true;
            this.radioButtonBackgroundRed.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.1F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radioButtonBackgroundRed.ForeColor = System.Drawing.Color.Red;
            this.radioButtonBackgroundRed.Location = new System.Drawing.Point(267, 55);
            this.radioButtonBackgroundRed.Name = "radioButtonBackgroundRed";
            this.radioButtonBackgroundRed.Size = new System.Drawing.Size(107, 36);
            this.radioButtonBackgroundRed.TabIndex = 2;
            this.radioButtonBackgroundRed.TabStop = true;
            this.radioButtonBackgroundRed.Text = "Red";
            this.radioButtonBackgroundRed.UseVisualStyleBackColor = true;
            this.radioButtonBackgroundRed.CheckedChanged += new System.EventHandler(this.radioButtonBackgroundRed_CheckedChanged);
            // 
            // radioButtonBackgroundBlue
            // 
            this.radioButtonBackgroundBlue.AutoSize = true;
            this.radioButtonBackgroundBlue.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.1F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radioButtonBackgroundBlue.ForeColor = System.Drawing.Color.Blue;
            this.radioButtonBackgroundBlue.Location = new System.Drawing.Point(33, 122);
            this.radioButtonBackgroundBlue.Name = "radioButtonBackgroundBlue";
            this.radioButtonBackgroundBlue.Size = new System.Drawing.Size(114, 36);
            this.radioButtonBackgroundBlue.TabIndex = 1;
            this.radioButtonBackgroundBlue.TabStop = true;
            this.radioButtonBackgroundBlue.Text = "Blue";
            this.radioButtonBackgroundBlue.UseVisualStyleBackColor = true;
            this.radioButtonBackgroundBlue.CheckedChanged += new System.EventHandler(this.radioButtonBackgroundBlue_CheckedChanged);
            // 
            // radioButtonBackgroundGreen
            // 
            this.radioButtonBackgroundGreen.AutoSize = true;
            this.radioButtonBackgroundGreen.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.1F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radioButtonBackgroundGreen.ForeColor = System.Drawing.Color.Green;
            this.radioButtonBackgroundGreen.Location = new System.Drawing.Point(33, 55);
            this.radioButtonBackgroundGreen.Name = "radioButtonBackgroundGreen";
            this.radioButtonBackgroundGreen.Size = new System.Drawing.Size(136, 36);
            this.radioButtonBackgroundGreen.TabIndex = 0;
            this.radioButtonBackgroundGreen.TabStop = true;
            this.radioButtonBackgroundGreen.Text = "Green";
            this.radioButtonBackgroundGreen.UseVisualStyleBackColor = true;
            this.radioButtonBackgroundGreen.CheckedChanged += new System.EventHandler(this.radioButtonBackgroundGreen_CheckedChanged);
            // 
            // comboBoxBorderColors
            // 
            this.comboBoxBorderColors.FormattingEnabled = true;
            this.comboBoxBorderColors.Items.AddRange(new object[] {
            "Default",
            "Red",
            "Blue",
            "Yellow",
            "Orange"});
            this.comboBoxBorderColors.Location = new System.Drawing.Point(13, 226);
            this.comboBoxBorderColors.Name = "comboBoxBorderColors";
            this.comboBoxBorderColors.Size = new System.Drawing.Size(528, 39);
            this.comboBoxBorderColors.TabIndex = 3;
            this.comboBoxBorderColors.Text = "Border Colors";
            this.comboBoxBorderColors.SelectedIndexChanged += new System.EventHandler(this.comboBoxBorderColors_SelectedIndexChanged);
            // 
            // checkBoxExitDialog
            // 
            this.checkBoxExitDialog.AutoSize = true;
            this.checkBoxExitDialog.Location = new System.Drawing.Point(13, 307);
            this.checkBoxExitDialog.Name = "checkBoxExitDialog";
            this.checkBoxExitDialog.Size = new System.Drawing.Size(286, 36);
            this.checkBoxExitDialog.TabIndex = 4;
            this.checkBoxExitDialog.Text = "Exit Confirmation?";
            this.checkBoxExitDialog.UseVisualStyleBackColor = true;
            this.checkBoxExitDialog.CheckedChanged += new System.EventHandler(this.checkBoxExitDialog_CheckedChanged);
            // 
            // labelUserName
            // 
            this.labelUserName.AutoSize = true;
            this.labelUserName.Location = new System.Drawing.Point(7, 460);
            this.labelUserName.Name = "labelUserName";
            this.labelUserName.Size = new System.Drawing.Size(153, 32);
            this.labelUserName.TabIndex = 5;
            this.labelUserName.Text = "Username:";
            // 
            // textBoxUserName
            // 
            this.textBoxUserName.Location = new System.Drawing.Point(13, 532);
            this.textBoxUserName.Multiline = true;
            this.textBoxUserName.Name = "textBoxUserName";
            this.textBoxUserName.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.textBoxUserName.Size = new System.Drawing.Size(569, 38);
            this.textBoxUserName.TabIndex = 6;
            this.textBoxUserName.Text = "This is some simple text";
            // 
            // radioButtonDefault
            // 
            this.radioButtonDefault.AutoSize = true;
            this.radioButtonDefault.BackColor = System.Drawing.SystemColors.Control;
            this.radioButtonDefault.ForeColor = System.Drawing.SystemColors.Desktop;
            this.radioButtonDefault.Location = new System.Drawing.Point(479, 55);
            this.radioButtonDefault.Name = "radioButtonDefault";
            this.radioButtonDefault.Size = new System.Drawing.Size(143, 36);
            this.radioButtonDefault.TabIndex = 4;
            this.radioButtonDefault.TabStop = true;
            this.radioButtonDefault.Text = "Default";
            this.radioButtonDefault.UseVisualStyleBackColor = false;
            this.radioButtonDefault.CheckedChanged += new System.EventHandler(this.radioButtonDefault_CheckedChanged);
            // 
            // formBuffetOptions
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(16F, 31F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.Desktop;
            this.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("$this.BackgroundImage")));
            this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.ClientSize = new System.Drawing.Size(879, 730);
            this.Controls.Add(this.textBoxUserName);
            this.Controls.Add(this.labelUserName);
            this.Controls.Add(this.checkBoxExitDialog);
            this.Controls.Add(this.comboBoxBorderColors);
            this.Controls.Add(this.groupBoxDefaultBackgroundColor);
            this.Controls.Add(this.buttonCancel);
            this.Controls.Add(this.buttonOkay);
            this.ForeColor = System.Drawing.SystemColors.Window;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "formBuffetOptions";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "A290 Buffet Options";
            this.Load += new System.EventHandler(this.formBuffetOptions_Load);
            this.groupBoxDefaultBackgroundColor.ResumeLayout(false);
            this.groupBoxDefaultBackgroundColor.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonOkay;
        private System.Windows.Forms.Button buttonCancel;
        private System.Windows.Forms.GroupBox groupBoxDefaultBackgroundColor;
        private System.Windows.Forms.RadioButton radioButtonBackgroundPurple;
        private System.Windows.Forms.RadioButton radioButtonBackgroundRed;
        private System.Windows.Forms.RadioButton radioButtonBackgroundBlue;
        private System.Windows.Forms.RadioButton radioButtonBackgroundGreen;
        private System.Windows.Forms.ComboBox comboBoxBorderColors;
        private System.Windows.Forms.CheckBox checkBoxExitDialog;
        private System.Windows.Forms.Label labelUserName;
        private System.Windows.Forms.TextBox textBoxUserName;
        private System.Windows.Forms.RadioButton radioButtonDefault;
    }
}