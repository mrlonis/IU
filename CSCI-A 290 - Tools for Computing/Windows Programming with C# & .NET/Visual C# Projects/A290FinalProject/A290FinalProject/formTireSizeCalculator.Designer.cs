namespace A290FinalProject
{
    partial class formTireSizeCalculator
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
            this.buttonTireComparison = new System.Windows.Forms.Button();
            this.labelSize = new System.Windows.Forms.Label();
            this.labelR = new System.Windows.Forms.Label();
            this.labelSlash = new System.Windows.Forms.Label();
            this.textBoxNumber1 = new System.Windows.Forms.TextBox();
            this.textBoxNumber2 = new System.Windows.Forms.TextBox();
            this.textBoxNumber3 = new System.Windows.Forms.TextBox();
            this.buttonCalculate = new System.Windows.Forms.Button();
            this.labelDiameter = new System.Windows.Forms.Label();
            this.labelWidth = new System.Windows.Forms.Label();
            this.labelSidewall = new System.Windows.Forms.Label();
            this.labelCircumference = new System.Windows.Forms.Label();
            this.labelInches1 = new System.Windows.Forms.Label();
            this.labelInches2 = new System.Windows.Forms.Label();
            this.labelInches3 = new System.Windows.Forms.Label();
            this.labelInches4 = new System.Windows.Forms.Label();
            this.textBoxCircumference = new System.Windows.Forms.TextBox();
            this.textBoxSidewall = new System.Windows.Forms.TextBox();
            this.textBoxWidth = new System.Windows.Forms.TextBox();
            this.textBoxDiameter = new System.Windows.Forms.TextBox();
            this.buttonClear = new System.Windows.Forms.Button();
            this.labelRevsMile = new System.Windows.Forms.Label();
            this.textBoxRevsMile = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // buttonClose
            // 
            this.buttonClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonClose.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClose.FlatAppearance.BorderSize = 0;
            this.buttonClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClose.Location = new System.Drawing.Point(126, 273);
            this.buttonClose.Name = "buttonClose";
            this.buttonClose.Size = new System.Drawing.Size(108, 52);
            this.buttonClose.TabIndex = 6;
            this.buttonClose.Text = "Close";
            this.buttonClose.UseVisualStyleBackColor = false;
            this.buttonClose.Click += new System.EventHandler(this.buttonClose_Click);
            this.buttonClose.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.buttonClose_KeyPress);
            // 
            // buttonTireComparison
            // 
            this.buttonTireComparison.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonTireComparison.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonTireComparison.FlatAppearance.BorderSize = 0;
            this.buttonTireComparison.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonTireComparison.Location = new System.Drawing.Point(240, 273);
            this.buttonTireComparison.Name = "buttonTireComparison";
            this.buttonTireComparison.Size = new System.Drawing.Size(106, 52);
            this.buttonTireComparison.TabIndex = 7;
            this.buttonTireComparison.Text = "Tire Comparison";
            this.buttonTireComparison.UseVisualStyleBackColor = false;
            this.buttonTireComparison.Click += new System.EventHandler(this.buttonTireComparison_Click);
            // 
            // labelSize
            // 
            this.labelSize.AutoSize = true;
            this.labelSize.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelSize.Location = new System.Drawing.Point(12, 14);
            this.labelSize.Name = "labelSize";
            this.labelSize.Size = new System.Drawing.Size(49, 20);
            this.labelSize.TabIndex = 2;
            this.labelSize.Text = "Size:";
            this.labelSize.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelR
            // 
            this.labelR.AutoSize = true;
            this.labelR.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelR.Location = new System.Drawing.Point(245, 14);
            this.labelR.Name = "labelR";
            this.labelR.Size = new System.Drawing.Size(22, 20);
            this.labelR.TabIndex = 3;
            this.labelR.Text = "R";
            this.labelR.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // labelSlash
            // 
            this.labelSlash.AutoSize = true;
            this.labelSlash.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelSlash.Location = new System.Drawing.Point(146, 14);
            this.labelSlash.Name = "labelSlash";
            this.labelSlash.Size = new System.Drawing.Size(14, 20);
            this.labelSlash.TabIndex = 4;
            this.labelSlash.Text = "/";
            this.labelSlash.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // textBoxNumber1
            // 
            this.textBoxNumber1.Location = new System.Drawing.Point(67, 11);
            this.textBoxNumber1.Name = "textBoxNumber1";
            this.textBoxNumber1.Size = new System.Drawing.Size(73, 26);
            this.textBoxNumber1.TabIndex = 1;
            this.textBoxNumber1.Leave += new System.EventHandler(this.textBoxNumber1_Leave);
            this.textBoxNumber1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxNumber1_MouseDown);
            // 
            // textBoxNumber2
            // 
            this.textBoxNumber2.Location = new System.Drawing.Point(166, 11);
            this.textBoxNumber2.Name = "textBoxNumber2";
            this.textBoxNumber2.Size = new System.Drawing.Size(73, 26);
            this.textBoxNumber2.TabIndex = 2;
            this.textBoxNumber2.Leave += new System.EventHandler(this.textBoxNumber2_Leave);
            this.textBoxNumber2.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxNumber2_MouseDown);
            // 
            // textBoxNumber3
            // 
            this.textBoxNumber3.Location = new System.Drawing.Point(273, 11);
            this.textBoxNumber3.Name = "textBoxNumber3";
            this.textBoxNumber3.Size = new System.Drawing.Size(73, 26);
            this.textBoxNumber3.TabIndex = 3;
            this.textBoxNumber3.Leave += new System.EventHandler(this.textBoxNumber3_Leave);
            this.textBoxNumber3.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxNumber3_MouseDown);
            // 
            // buttonCalculate
            // 
            this.buttonCalculate.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonCalculate.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonCalculate.FlatAppearance.BorderSize = 0;
            this.buttonCalculate.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonCalculate.Location = new System.Drawing.Point(67, 52);
            this.buttonCalculate.Name = "buttonCalculate";
            this.buttonCalculate.Size = new System.Drawing.Size(279, 30);
            this.buttonCalculate.TabIndex = 4;
            this.buttonCalculate.Text = "Calculate!";
            this.buttonCalculate.UseVisualStyleBackColor = false;
            this.buttonCalculate.Click += new System.EventHandler(this.buttonCalculate_Click);
            // 
            // labelDiameter
            // 
            this.labelDiameter.AutoSize = true;
            this.labelDiameter.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelDiameter.Location = new System.Drawing.Point(12, 101);
            this.labelDiameter.Name = "labelDiameter";
            this.labelDiameter.Size = new System.Drawing.Size(78, 20);
            this.labelDiameter.TabIndex = 9;
            this.labelDiameter.Text = "Diameter:";
            this.labelDiameter.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelWidth
            // 
            this.labelWidth.AutoSize = true;
            this.labelWidth.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelWidth.Location = new System.Drawing.Point(12, 130);
            this.labelWidth.Name = "labelWidth";
            this.labelWidth.Size = new System.Drawing.Size(54, 20);
            this.labelWidth.TabIndex = 10;
            this.labelWidth.Text = "Width:";
            this.labelWidth.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelSidewall
            // 
            this.labelSidewall.AutoSize = true;
            this.labelSidewall.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelSidewall.Location = new System.Drawing.Point(12, 160);
            this.labelSidewall.Name = "labelSidewall";
            this.labelSidewall.Size = new System.Drawing.Size(71, 20);
            this.labelSidewall.TabIndex = 11;
            this.labelSidewall.Text = "Sidewall:";
            this.labelSidewall.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelCircumference
            // 
            this.labelCircumference.AutoSize = true;
            this.labelCircumference.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelCircumference.Location = new System.Drawing.Point(12, 190);
            this.labelCircumference.Name = "labelCircumference";
            this.labelCircumference.Size = new System.Drawing.Size(116, 20);
            this.labelCircumference.TabIndex = 12;
            this.labelCircumference.Text = "Circumference:";
            this.labelCircumference.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelInches1
            // 
            this.labelInches1.AutoSize = true;
            this.labelInches1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelInches1.Location = new System.Drawing.Point(214, 101);
            this.labelInches1.Name = "labelInches1";
            this.labelInches1.Size = new System.Drawing.Size(57, 20);
            this.labelInches1.TabIndex = 13;
            this.labelInches1.Text = "Inches";
            this.labelInches1.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelInches2
            // 
            this.labelInches2.AutoSize = true;
            this.labelInches2.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelInches2.Location = new System.Drawing.Point(214, 130);
            this.labelInches2.Name = "labelInches2";
            this.labelInches2.Size = new System.Drawing.Size(57, 20);
            this.labelInches2.TabIndex = 14;
            this.labelInches2.Text = "Inches";
            this.labelInches2.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelInches3
            // 
            this.labelInches3.AutoSize = true;
            this.labelInches3.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelInches3.Location = new System.Drawing.Point(214, 160);
            this.labelInches3.Name = "labelInches3";
            this.labelInches3.Size = new System.Drawing.Size(57, 20);
            this.labelInches3.TabIndex = 15;
            this.labelInches3.Text = "Inches";
            this.labelInches3.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelInches4
            // 
            this.labelInches4.AutoSize = true;
            this.labelInches4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelInches4.Location = new System.Drawing.Point(214, 190);
            this.labelInches4.Name = "labelInches4";
            this.labelInches4.Size = new System.Drawing.Size(57, 20);
            this.labelInches4.TabIndex = 16;
            this.labelInches4.Text = "Inches";
            this.labelInches4.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // textBoxCircumference
            // 
            this.textBoxCircumference.Location = new System.Drawing.Point(134, 187);
            this.textBoxCircumference.Name = "textBoxCircumference";
            this.textBoxCircumference.Size = new System.Drawing.Size(73, 26);
            this.textBoxCircumference.TabIndex = 11;
            // 
            // textBoxSidewall
            // 
            this.textBoxSidewall.Location = new System.Drawing.Point(134, 157);
            this.textBoxSidewall.Name = "textBoxSidewall";
            this.textBoxSidewall.Size = new System.Drawing.Size(73, 26);
            this.textBoxSidewall.TabIndex = 10;
            // 
            // textBoxWidth
            // 
            this.textBoxWidth.Location = new System.Drawing.Point(134, 127);
            this.textBoxWidth.Name = "textBoxWidth";
            this.textBoxWidth.Size = new System.Drawing.Size(73, 26);
            this.textBoxWidth.TabIndex = 9;
            // 
            // textBoxDiameter
            // 
            this.textBoxDiameter.Location = new System.Drawing.Point(134, 98);
            this.textBoxDiameter.Name = "textBoxDiameter";
            this.textBoxDiameter.Size = new System.Drawing.Size(73, 26);
            this.textBoxDiameter.TabIndex = 8;
            // 
            // buttonClear
            // 
            this.buttonClear.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonClear.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClear.FlatAppearance.BorderSize = 0;
            this.buttonClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClear.Location = new System.Drawing.Point(12, 273);
            this.buttonClear.Name = "buttonClear";
            this.buttonClear.Size = new System.Drawing.Size(108, 52);
            this.buttonClear.TabIndex = 5;
            this.buttonClear.Text = "Clear";
            this.buttonClear.UseVisualStyleBackColor = false;
            this.buttonClear.Click += new System.EventHandler(this.buttonClear_Click);
            // 
            // labelRevsMile
            // 
            this.labelRevsMile.AutoSize = true;
            this.labelRevsMile.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelRevsMile.Location = new System.Drawing.Point(12, 220);
            this.labelRevsMile.Name = "labelRevsMile";
            this.labelRevsMile.Size = new System.Drawing.Size(81, 20);
            this.labelRevsMile.TabIndex = 22;
            this.labelRevsMile.Text = "Revs/Mile:";
            this.labelRevsMile.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // textBoxRevsMile
            // 
            this.textBoxRevsMile.Location = new System.Drawing.Point(134, 217);
            this.textBoxRevsMile.Name = "textBoxRevsMile";
            this.textBoxRevsMile.Size = new System.Drawing.Size(73, 26);
            this.textBoxRevsMile.TabIndex = 12;
            // 
            // formTireSizeCalculator
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.RosyBrown;
            this.ClientSize = new System.Drawing.Size(364, 347);
            this.Controls.Add(this.textBoxRevsMile);
            this.Controls.Add(this.labelRevsMile);
            this.Controls.Add(this.buttonClear);
            this.Controls.Add(this.textBoxDiameter);
            this.Controls.Add(this.textBoxWidth);
            this.Controls.Add(this.textBoxSidewall);
            this.Controls.Add(this.textBoxCircumference);
            this.Controls.Add(this.labelInches4);
            this.Controls.Add(this.labelInches3);
            this.Controls.Add(this.labelInches2);
            this.Controls.Add(this.labelInches1);
            this.Controls.Add(this.labelCircumference);
            this.Controls.Add(this.labelSidewall);
            this.Controls.Add(this.labelWidth);
            this.Controls.Add(this.labelDiameter);
            this.Controls.Add(this.buttonCalculate);
            this.Controls.Add(this.textBoxNumber3);
            this.Controls.Add(this.textBoxNumber2);
            this.Controls.Add(this.textBoxNumber1);
            this.Controls.Add(this.labelSlash);
            this.Controls.Add(this.labelR);
            this.Controls.Add(this.labelSize);
            this.Controls.Add(this.buttonTireComparison);
            this.Controls.Add(this.buttonClose);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "formTireSizeCalculator";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Tire Size Calculator";
            this.Load += new System.EventHandler(this.formTireSizeCalculator_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonClose;
        private System.Windows.Forms.Button buttonTireComparison;
        private System.Windows.Forms.Label labelSize;
        private System.Windows.Forms.Label labelR;
        private System.Windows.Forms.Label labelSlash;
        private System.Windows.Forms.TextBox textBoxNumber1;
        private System.Windows.Forms.TextBox textBoxNumber2;
        private System.Windows.Forms.TextBox textBoxNumber3;
        private System.Windows.Forms.Button buttonCalculate;
        private System.Windows.Forms.Label labelDiameter;
        private System.Windows.Forms.Label labelWidth;
        private System.Windows.Forms.Label labelSidewall;
        private System.Windows.Forms.Label labelCircumference;
        private System.Windows.Forms.Label labelInches1;
        private System.Windows.Forms.Label labelInches2;
        private System.Windows.Forms.Label labelInches3;
        private System.Windows.Forms.Label labelInches4;
        private System.Windows.Forms.TextBox textBoxCircumference;
        private System.Windows.Forms.TextBox textBoxSidewall;
        private System.Windows.Forms.TextBox textBoxWidth;
        private System.Windows.Forms.TextBox textBoxDiameter;
        private System.Windows.Forms.Button buttonClear;
        private System.Windows.Forms.Label labelRevsMile;
        private System.Windows.Forms.TextBox textBoxRevsMile;
    }
}