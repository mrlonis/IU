namespace RPNCalculator
{
    partial class formHelp
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
            this.labelTitle = new System.Windows.Forms.Label();
            this.buttonAdd = new System.Windows.Forms.Button();
            this.labelAddDescription = new System.Windows.Forms.Label();
            this.buttonDivide = new System.Windows.Forms.Button();
            this.buttonMultiply = new System.Windows.Forms.Button();
            this.buttonSubtract = new System.Windows.Forms.Button();
            this.labelDivisionDescription = new System.Windows.Forms.Label();
            this.labelMultiplicationDescription = new System.Windows.Forms.Label();
            this.labelSubtractDescription = new System.Windows.Forms.Label();
            this.buttonPower = new System.Windows.Forms.Button();
            this.buttonTangent = new System.Windows.Forms.Button();
            this.buttonCosine = new System.Windows.Forms.Button();
            this.buttonSine = new System.Windows.Forms.Button();
            this.labelSineDescription = new System.Windows.Forms.Label();
            this.labelCosineDescription = new System.Windows.Forms.Label();
            this.labelTangentDescription = new System.Windows.Forms.Label();
            this.labelPowerDescription = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // buttonClose
            // 
            this.buttonClose.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonClose.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClose.FlatAppearance.BorderSize = 0;
            this.buttonClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClose.Location = new System.Drawing.Point(262, 450);
            this.buttonClose.Name = "buttonClose";
            this.buttonClose.Size = new System.Drawing.Size(75, 33);
            this.buttonClose.TabIndex = 9;
            this.buttonClose.Text = "Exit";
            this.buttonClose.UseVisualStyleBackColor = false;
            this.buttonClose.Click += new System.EventHandler(this.buttonClose_Click);
            // 
            // labelTitle
            // 
            this.labelTitle.AutoSize = true;
            this.labelTitle.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelTitle.Location = new System.Drawing.Point(12, 20);
            this.labelTitle.Name = "labelTitle";
            this.labelTitle.Size = new System.Drawing.Size(426, 20);
            this.labelTitle.TabIndex = 1;
            this.labelTitle.Text = "Buttons functions and their associated descriptions:";
            this.labelTitle.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // buttonAdd
            // 
            this.buttonAdd.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonAdd.FlatAppearance.BorderSize = 0;
            this.buttonAdd.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonAdd.Location = new System.Drawing.Point(16, 60);
            this.buttonAdd.Name = "buttonAdd";
            this.buttonAdd.Size = new System.Drawing.Size(81, 30);
            this.buttonAdd.TabIndex = 1;
            this.buttonAdd.Text = "+";
            this.buttonAdd.UseVisualStyleBackColor = false;
            this.buttonAdd.Click += new System.EventHandler(this.buttonAdd_Click);
            // 
            // labelAddDescription
            // 
            this.labelAddDescription.AutoSize = true;
            this.labelAddDescription.Location = new System.Drawing.Point(103, 65);
            this.labelAddDescription.Name = "labelAddDescription";
            this.labelAddDescription.Size = new System.Drawing.Size(382, 20);
            this.labelAddDescription.TabIndex = 3;
            this.labelAddDescription.Text = "= Returns the result of Number 1 Added to Number 2";
            // 
            // buttonDivide
            // 
            this.buttonDivide.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonDivide.FlatAppearance.BorderSize = 0;
            this.buttonDivide.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonDivide.Location = new System.Drawing.Point(16, 210);
            this.buttonDivide.Name = "buttonDivide";
            this.buttonDivide.Size = new System.Drawing.Size(81, 30);
            this.buttonDivide.TabIndex = 4;
            this.buttonDivide.Text = "\\";
            this.buttonDivide.UseVisualStyleBackColor = false;
            this.buttonDivide.Click += new System.EventHandler(this.buttonDivide_Click);
            // 
            // buttonMultiply
            // 
            this.buttonMultiply.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonMultiply.FlatAppearance.BorderSize = 0;
            this.buttonMultiply.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonMultiply.Location = new System.Drawing.Point(16, 160);
            this.buttonMultiply.Name = "buttonMultiply";
            this.buttonMultiply.Size = new System.Drawing.Size(81, 30);
            this.buttonMultiply.TabIndex = 3;
            this.buttonMultiply.Text = "*";
            this.buttonMultiply.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.buttonMultiply.UseVisualStyleBackColor = false;
            this.buttonMultiply.Click += new System.EventHandler(this.buttonMultiply_Click);
            // 
            // buttonSubtract
            // 
            this.buttonSubtract.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonSubtract.FlatAppearance.BorderSize = 0;
            this.buttonSubtract.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonSubtract.Location = new System.Drawing.Point(16, 110);
            this.buttonSubtract.Name = "buttonSubtract";
            this.buttonSubtract.Size = new System.Drawing.Size(81, 30);
            this.buttonSubtract.TabIndex = 2;
            this.buttonSubtract.Text = "-";
            this.buttonSubtract.UseVisualStyleBackColor = false;
            this.buttonSubtract.Click += new System.EventHandler(this.buttonSubtract_Click);
            // 
            // labelDivisionDescription
            // 
            this.labelDivisionDescription.AutoSize = true;
            this.labelDivisionDescription.Location = new System.Drawing.Point(103, 215);
            this.labelDivisionDescription.Name = "labelDivisionDescription";
            this.labelDivisionDescription.Size = new System.Drawing.Size(389, 20);
            this.labelDivisionDescription.TabIndex = 7;
            this.labelDivisionDescription.Text = "= Returns the result of Number 1 Divided by Number 2";
            // 
            // labelMultiplicationDescription
            // 
            this.labelMultiplicationDescription.AutoSize = true;
            this.labelMultiplicationDescription.Location = new System.Drawing.Point(103, 165);
            this.labelMultiplicationDescription.Name = "labelMultiplicationDescription";
            this.labelMultiplicationDescription.Size = new System.Drawing.Size(403, 20);
            this.labelMultiplicationDescription.TabIndex = 8;
            this.labelMultiplicationDescription.Text = "= Returns the result of Number 1 Multiplied by Number 2";
            // 
            // labelSubtractDescription
            // 
            this.labelSubtractDescription.AutoSize = true;
            this.labelSubtractDescription.Location = new System.Drawing.Point(103, 115);
            this.labelSubtractDescription.Name = "labelSubtractDescription";
            this.labelSubtractDescription.Size = new System.Drawing.Size(432, 20);
            this.labelSubtractDescription.TabIndex = 9;
            this.labelSubtractDescription.Text = "= Returns the result of Number 2 Subtracted from Number 1";
            // 
            // buttonPower
            // 
            this.buttonPower.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonPower.FlatAppearance.BorderSize = 0;
            this.buttonPower.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonPower.Location = new System.Drawing.Point(16, 410);
            this.buttonPower.Name = "buttonPower";
            this.buttonPower.Size = new System.Drawing.Size(81, 30);
            this.buttonPower.TabIndex = 8;
            this.buttonPower.Text = "POW";
            this.buttonPower.UseVisualStyleBackColor = false;
            this.buttonPower.Click += new System.EventHandler(this.buttonPower_Click);
            // 
            // buttonTangent
            // 
            this.buttonTangent.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonTangent.FlatAppearance.BorderSize = 0;
            this.buttonTangent.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonTangent.Location = new System.Drawing.Point(16, 360);
            this.buttonTangent.Name = "buttonTangent";
            this.buttonTangent.Size = new System.Drawing.Size(81, 30);
            this.buttonTangent.TabIndex = 7;
            this.buttonTangent.Text = "Tan";
            this.buttonTangent.UseVisualStyleBackColor = false;
            this.buttonTangent.Click += new System.EventHandler(this.buttonTangent_Click);
            // 
            // buttonCosine
            // 
            this.buttonCosine.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonCosine.FlatAppearance.BorderSize = 0;
            this.buttonCosine.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonCosine.Location = new System.Drawing.Point(16, 310);
            this.buttonCosine.Name = "buttonCosine";
            this.buttonCosine.Size = new System.Drawing.Size(81, 30);
            this.buttonCosine.TabIndex = 6;
            this.buttonCosine.Text = "Cos";
            this.buttonCosine.UseVisualStyleBackColor = false;
            this.buttonCosine.Click += new System.EventHandler(this.buttonCosine_Click);
            // 
            // buttonSine
            // 
            this.buttonSine.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonSine.FlatAppearance.BorderSize = 0;
            this.buttonSine.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonSine.Location = new System.Drawing.Point(16, 260);
            this.buttonSine.Name = "buttonSine";
            this.buttonSine.Size = new System.Drawing.Size(81, 30);
            this.buttonSine.TabIndex = 5;
            this.buttonSine.Text = "Sin";
            this.buttonSine.UseVisualStyleBackColor = false;
            this.buttonSine.Click += new System.EventHandler(this.buttonSine_Click);
            // 
            // labelSineDescription
            // 
            this.labelSineDescription.AutoSize = true;
            this.labelSineDescription.Location = new System.Drawing.Point(103, 265);
            this.labelSineDescription.Name = "labelSineDescription";
            this.labelSineDescription.Size = new System.Drawing.Size(339, 20);
            this.labelSineDescription.TabIndex = 14;
            this.labelSineDescription.Text = "= Returns the Sine of Number 1 (Radian Input)";
            // 
            // labelCosineDescription
            // 
            this.labelCosineDescription.AutoSize = true;
            this.labelCosineDescription.Location = new System.Drawing.Point(103, 315);
            this.labelCosineDescription.Name = "labelCosineDescription";
            this.labelCosineDescription.Size = new System.Drawing.Size(356, 20);
            this.labelCosineDescription.TabIndex = 15;
            this.labelCosineDescription.Text = "= Returns the Cosine of Number 1 (Radian Input)";
            // 
            // labelTangentDescription
            // 
            this.labelTangentDescription.AutoSize = true;
            this.labelTangentDescription.Location = new System.Drawing.Point(103, 365);
            this.labelTangentDescription.Name = "labelTangentDescription";
            this.labelTangentDescription.Size = new System.Drawing.Size(366, 20);
            this.labelTangentDescription.TabIndex = 16;
            this.labelTangentDescription.Text = "= Returns the Tangent of Number 1 (Radian Input)";
            // 
            // labelPowerDescription
            // 
            this.labelPowerDescription.AutoSize = true;
            this.labelPowerDescription.Location = new System.Drawing.Point(103, 415);
            this.labelPowerDescription.Name = "labelPowerDescription";
            this.labelPowerDescription.Size = new System.Drawing.Size(471, 20);
            this.labelPowerDescription.TabIndex = 17;
            this.labelPowerDescription.Text = "= Returns the result of Number 1 raised to the Power of Number 2";
            // 
            // formHelp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.ClientSize = new System.Drawing.Size(580, 502);
            this.Controls.Add(this.labelPowerDescription);
            this.Controls.Add(this.labelTangentDescription);
            this.Controls.Add(this.labelCosineDescription);
            this.Controls.Add(this.labelSineDescription);
            this.Controls.Add(this.buttonSine);
            this.Controls.Add(this.buttonCosine);
            this.Controls.Add(this.buttonTangent);
            this.Controls.Add(this.buttonPower);
            this.Controls.Add(this.labelSubtractDescription);
            this.Controls.Add(this.labelMultiplicationDescription);
            this.Controls.Add(this.labelDivisionDescription);
            this.Controls.Add(this.buttonSubtract);
            this.Controls.Add(this.buttonMultiply);
            this.Controls.Add(this.buttonDivide);
            this.Controls.Add(this.labelAddDescription);
            this.Controls.Add(this.buttonAdd);
            this.Controls.Add(this.labelTitle);
            this.Controls.Add(this.buttonClose);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "formHelp";
            this.Text = "Help & Information";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonClose;
        private System.Windows.Forms.Label labelTitle;
        private System.Windows.Forms.Button buttonAdd;
        private System.Windows.Forms.Label labelAddDescription;
        private System.Windows.Forms.Button buttonDivide;
        private System.Windows.Forms.Button buttonMultiply;
        private System.Windows.Forms.Button buttonSubtract;
        private System.Windows.Forms.Label labelDivisionDescription;
        private System.Windows.Forms.Label labelMultiplicationDescription;
        private System.Windows.Forms.Label labelSubtractDescription;
        private System.Windows.Forms.Button buttonPower;
        private System.Windows.Forms.Button buttonTangent;
        private System.Windows.Forms.Button buttonCosine;
        private System.Windows.Forms.Button buttonSine;
        private System.Windows.Forms.Label labelSineDescription;
        private System.Windows.Forms.Label labelCosineDescription;
        private System.Windows.Forms.Label labelTangentDescription;
        private System.Windows.Forms.Label labelPowerDescription;
    }
}