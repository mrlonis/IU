namespace A290FinalProject
{
    partial class formUnitConverter
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
            this.labelDataType = new System.Windows.Forms.Label();
            this.comboBoxDataType = new System.Windows.Forms.ComboBox();
            this.textBoxNumber1 = new System.Windows.Forms.TextBox();
            this.labelTo = new System.Windows.Forms.Label();
            this.textBoxNumber2 = new System.Windows.Forms.TextBox();
            this.comboBoxNumber1Type = new System.Windows.Forms.ComboBox();
            this.comboBoxNumber2Type = new System.Windows.Forms.ComboBox();
            this.buttonConvert = new System.Windows.Forms.Button();
            this.labelConvert = new System.Windows.Forms.Label();
            this.buttonReset = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // buttonClose
            // 
            this.buttonClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonClose.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClose.FlatAppearance.BorderSize = 0;
            this.buttonClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClose.Location = new System.Drawing.Point(228, 277);
            this.buttonClose.Name = "buttonClose";
            this.buttonClose.Size = new System.Drawing.Size(75, 30);
            this.buttonClose.TabIndex = 4;
            this.buttonClose.Text = "Close";
            this.buttonClose.UseVisualStyleBackColor = false;
            this.buttonClose.Click += new System.EventHandler(this.buttonClose_Click);
            this.buttonClose.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.buttonClose_KeyPress);
            // 
            // labelDataType
            // 
            this.labelDataType.AutoSize = true;
            this.labelDataType.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelDataType.Location = new System.Drawing.Point(13, 13);
            this.labelDataType.Name = "labelDataType";
            this.labelDataType.Size = new System.Drawing.Size(92, 29);
            this.labelDataType.TabIndex = 1;
            this.labelDataType.Text = "Length";
            // 
            // comboBoxDataType
            // 
            this.comboBoxDataType.FormattingEnabled = true;
            this.comboBoxDataType.Items.AddRange(new object[] {
            "Length",
            "Mass",
            "Volume",
            "Temperature"});
            this.comboBoxDataType.Location = new System.Drawing.Point(182, 14);
            this.comboBoxDataType.Name = "comboBoxDataType";
            this.comboBoxDataType.Size = new System.Drawing.Size(121, 28);
            this.comboBoxDataType.TabIndex = 6;
            this.comboBoxDataType.SelectionChangeCommitted += new System.EventHandler(this.comboBoxDataType_SelectionChangeCommitted);
            // 
            // textBoxNumber1
            // 
            this.textBoxNumber1.Location = new System.Drawing.Point(18, 81);
            this.textBoxNumber1.Name = "textBoxNumber1";
            this.textBoxNumber1.Size = new System.Drawing.Size(100, 26);
            this.textBoxNumber1.TabIndex = 1;
            this.textBoxNumber1.Leave += new System.EventHandler(this.textBoxNumber1_Leave);
            this.textBoxNumber1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxNumber1_MouseDown);
            // 
            // labelTo
            // 
            this.labelTo.AutoSize = true;
            this.labelTo.Location = new System.Drawing.Point(42, 127);
            this.labelTo.Name = "labelTo";
            this.labelTo.Size = new System.Drawing.Size(27, 20);
            this.labelTo.TabIndex = 4;
            this.labelTo.Text = "To";
            // 
            // textBoxNumber2
            // 
            this.textBoxNumber2.Location = new System.Drawing.Point(18, 169);
            this.textBoxNumber2.Name = "textBoxNumber2";
            this.textBoxNumber2.Size = new System.Drawing.Size(100, 26);
            this.textBoxNumber2.TabIndex = 5;
            this.textBoxNumber2.Leave += new System.EventHandler(this.textBoxNumber2_Leave);
            this.textBoxNumber2.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxNumber2_MouseDown);
            // 
            // comboBoxNumber1Type
            // 
            this.comboBoxNumber1Type.FormattingEnabled = true;
            this.comboBoxNumber1Type.Location = new System.Drawing.Point(124, 79);
            this.comboBoxNumber1Type.Name = "comboBoxNumber1Type";
            this.comboBoxNumber1Type.Size = new System.Drawing.Size(179, 28);
            this.comboBoxNumber1Type.TabIndex = 7;
            this.comboBoxNumber1Type.SelectionChangeCommitted += new System.EventHandler(this.comboBoxNumber1Type_SelectionChangeCommitted);
            // 
            // comboBoxNumber2Type
            // 
            this.comboBoxNumber2Type.FormattingEnabled = true;
            this.comboBoxNumber2Type.Location = new System.Drawing.Point(124, 167);
            this.comboBoxNumber2Type.Name = "comboBoxNumber2Type";
            this.comboBoxNumber2Type.Size = new System.Drawing.Size(179, 28);
            this.comboBoxNumber2Type.TabIndex = 8;
            this.comboBoxNumber2Type.SelectionChangeCommitted += new System.EventHandler(this.comboBoxNumber2Type_SelectionChangeCommitted);
            // 
            // buttonConvert
            // 
            this.buttonConvert.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonConvert.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonConvert.FlatAppearance.BorderSize = 0;
            this.buttonConvert.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonConvert.Location = new System.Drawing.Point(18, 218);
            this.buttonConvert.Name = "buttonConvert";
            this.buttonConvert.Size = new System.Drawing.Size(285, 30);
            this.buttonConvert.TabIndex = 2;
            this.buttonConvert.Text = "Convert!";
            this.buttonConvert.UseVisualStyleBackColor = false;
            this.buttonConvert.Click += new System.EventHandler(this.buttonConvert_Click);
            // 
            // labelConvert
            // 
            this.labelConvert.AutoSize = true;
            this.labelConvert.Location = new System.Drawing.Point(14, 58);
            this.labelConvert.Name = "labelConvert";
            this.labelConvert.Size = new System.Drawing.Size(64, 20);
            this.labelConvert.TabIndex = 9;
            this.labelConvert.Text = "Convert";
            // 
            // buttonReset
            // 
            this.buttonReset.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonReset.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonReset.FlatAppearance.BorderSize = 0;
            this.buttonReset.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonReset.Location = new System.Drawing.Point(18, 277);
            this.buttonReset.Name = "buttonReset";
            this.buttonReset.Size = new System.Drawing.Size(75, 30);
            this.buttonReset.TabIndex = 3;
            this.buttonReset.Text = "Reset";
            this.buttonReset.UseVisualStyleBackColor = false;
            this.buttonReset.Click += new System.EventHandler(this.buttonReset_Click);
            // 
            // formUnitConverter
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.RosyBrown;
            this.ClientSize = new System.Drawing.Size(319, 331);
            this.Controls.Add(this.buttonReset);
            this.Controls.Add(this.labelConvert);
            this.Controls.Add(this.buttonConvert);
            this.Controls.Add(this.comboBoxNumber2Type);
            this.Controls.Add(this.comboBoxNumber1Type);
            this.Controls.Add(this.textBoxNumber2);
            this.Controls.Add(this.labelTo);
            this.Controls.Add(this.textBoxNumber1);
            this.Controls.Add(this.comboBoxDataType);
            this.Controls.Add(this.labelDataType);
            this.Controls.Add(this.buttonClose);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "formUnitConverter";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Unit Converter";
            this.Load += new System.EventHandler(this.formUnitConverter_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonClose;
        private System.Windows.Forms.Label labelDataType;
        private System.Windows.Forms.ComboBox comboBoxDataType;
        private System.Windows.Forms.TextBox textBoxNumber1;
        private System.Windows.Forms.Label labelTo;
        private System.Windows.Forms.TextBox textBoxNumber2;
        private System.Windows.Forms.Button buttonConvert;
        private System.Windows.Forms.Label labelConvert;
        private System.Windows.Forms.Button buttonReset;
        public System.Windows.Forms.ComboBox comboBoxNumber1Type;
        public System.Windows.Forms.ComboBox comboBoxNumber2Type;
    }
}