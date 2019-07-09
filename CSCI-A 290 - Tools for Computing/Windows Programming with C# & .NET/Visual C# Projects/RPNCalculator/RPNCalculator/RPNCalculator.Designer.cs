namespace RPNCalculator
{
    partial class RPNCalculator
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
            this.labelFirstNumber = new System.Windows.Forms.Label();
            this.labelSecondNumber = new System.Windows.Forms.Label();
            this.labelAnswer = new System.Windows.Forms.Label();
            this.textBoxFirstNumber = new System.Windows.Forms.TextBox();
            this.textBoxSecondNumber = new System.Windows.Forms.TextBox();
            this.textBoxAnswer = new System.Windows.Forms.TextBox();
            this.buttonAdd = new System.Windows.Forms.Button();
            this.buttonClear = new System.Windows.Forms.Button();
            this.buttonClose = new System.Windows.Forms.Button();
            this.buttonHelp = new System.Windows.Forms.Button();
            this.buttonDivide = new System.Windows.Forms.Button();
            this.buttonMultiply = new System.Windows.Forms.Button();
            this.buttonSubtract = new System.Windows.Forms.Button();
            this.buttonPower = new System.Windows.Forms.Button();
            this.buttonTangent = new System.Windows.Forms.Button();
            this.buttonSine = new System.Windows.Forms.Button();
            this.buttonCosine = new System.Windows.Forms.Button();
            this.buttonOptions = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // labelFirstNumber
            // 
            this.labelFirstNumber.AutoSize = true;
            this.labelFirstNumber.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelFirstNumber.Location = new System.Drawing.Point(33, 16);
            this.labelFirstNumber.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.labelFirstNumber.Name = "labelFirstNumber";
            this.labelFirstNumber.Size = new System.Drawing.Size(117, 20);
            this.labelFirstNumber.TabIndex = 0;
            this.labelFirstNumber.Text = "First Number:";
            this.labelFirstNumber.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelSecondNumber
            // 
            this.labelSecondNumber.AutoSize = true;
            this.labelSecondNumber.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelSecondNumber.Location = new System.Drawing.Point(8, 45);
            this.labelSecondNumber.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.labelSecondNumber.Name = "labelSecondNumber";
            this.labelSecondNumber.Size = new System.Drawing.Size(142, 20);
            this.labelSecondNumber.TabIndex = 1;
            this.labelSecondNumber.Text = "Second Number:";
            this.labelSecondNumber.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelAnswer
            // 
            this.labelAnswer.AutoSize = true;
            this.labelAnswer.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelAnswer.Location = new System.Drawing.Point(77, 149);
            this.labelAnswer.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.labelAnswer.Name = "labelAnswer";
            this.labelAnswer.Size = new System.Drawing.Size(73, 20);
            this.labelAnswer.TabIndex = 2;
            this.labelAnswer.Text = "Answer:";
            this.labelAnswer.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // textBoxFirstNumber
            // 
            this.textBoxFirstNumber.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.textBoxFirstNumber.Location = new System.Drawing.Point(157, 10);
            this.textBoxFirstNumber.Name = "textBoxFirstNumber";
            this.textBoxFirstNumber.Size = new System.Drawing.Size(213, 26);
            this.textBoxFirstNumber.TabIndex = 1;
            this.textBoxFirstNumber.Leave += new System.EventHandler(this.textBoxFirstNumber_Leave);
            this.textBoxFirstNumber.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxFirstNumber_MouseDown);
            // 
            // textBoxSecondNumber
            // 
            this.textBoxSecondNumber.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.textBoxSecondNumber.Location = new System.Drawing.Point(157, 42);
            this.textBoxSecondNumber.Name = "textBoxSecondNumber";
            this.textBoxSecondNumber.Size = new System.Drawing.Size(213, 26);
            this.textBoxSecondNumber.TabIndex = 2;
            this.textBoxSecondNumber.Leave += new System.EventHandler(this.textBoxSecondNumber_Leave);
            this.textBoxSecondNumber.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxSecondNumber_MouseDown);
            // 
            // textBoxAnswer
            // 
            this.textBoxAnswer.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.textBoxAnswer.Location = new System.Drawing.Point(157, 146);
            this.textBoxAnswer.Name = "textBoxAnswer";
            this.textBoxAnswer.Size = new System.Drawing.Size(213, 26);
            this.textBoxAnswer.TabIndex = 11;
            // 
            // buttonAdd
            // 
            this.buttonAdd.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonAdd.FlatAppearance.BorderSize = 0;
            this.buttonAdd.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonAdd.Location = new System.Drawing.Point(30, 74);
            this.buttonAdd.Name = "buttonAdd";
            this.buttonAdd.Size = new System.Drawing.Size(81, 30);
            this.buttonAdd.TabIndex = 3;
            this.buttonAdd.Text = "+";
            this.buttonAdd.UseVisualStyleBackColor = false;
            this.buttonAdd.Click += new System.EventHandler(this.buttonAdd_Click);
            // 
            // buttonClear
            // 
            this.buttonClear.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClear.FlatAppearance.BorderSize = 0;
            this.buttonClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClear.Location = new System.Drawing.Point(202, 178);
            this.buttonClear.Name = "buttonClear";
            this.buttonClear.Size = new System.Drawing.Size(81, 33);
            this.buttonClear.TabIndex = 14;
            this.buttonClear.Text = "Clear";
            this.buttonClear.UseVisualStyleBackColor = false;
            this.buttonClear.Click += new System.EventHandler(this.buttonClear_Click);
            // 
            // buttonClose
            // 
            this.buttonClose.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClose.FlatAppearance.BorderSize = 0;
            this.buttonClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClose.Location = new System.Drawing.Point(289, 178);
            this.buttonClose.Name = "buttonClose";
            this.buttonClose.Size = new System.Drawing.Size(81, 33);
            this.buttonClose.TabIndex = 15;
            this.buttonClose.Text = "Close";
            this.buttonClose.UseVisualStyleBackColor = false;
            this.buttonClose.Click += new System.EventHandler(this.buttonClose_Click);
            // 
            // buttonHelp
            // 
            this.buttonHelp.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonHelp.FlatAppearance.BorderSize = 0;
            this.buttonHelp.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonHelp.Location = new System.Drawing.Point(29, 178);
            this.buttonHelp.Name = "buttonHelp";
            this.buttonHelp.Size = new System.Drawing.Size(81, 33);
            this.buttonHelp.TabIndex = 12;
            this.buttonHelp.Text = "Help";
            this.buttonHelp.UseVisualStyleBackColor = false;
            this.buttonHelp.Click += new System.EventHandler(this.buttonHelp_Click);
            // 
            // buttonDivide
            // 
            this.buttonDivide.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonDivide.FlatAppearance.BorderSize = 0;
            this.buttonDivide.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonDivide.Location = new System.Drawing.Point(115, 110);
            this.buttonDivide.Name = "buttonDivide";
            this.buttonDivide.Size = new System.Drawing.Size(81, 30);
            this.buttonDivide.TabIndex = 6;
            this.buttonDivide.Text = "\\";
            this.buttonDivide.UseVisualStyleBackColor = false;
            this.buttonDivide.Click += new System.EventHandler(this.buttonDivide_Click);
            // 
            // buttonMultiply
            // 
            this.buttonMultiply.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonMultiply.FlatAppearance.BorderSize = 0;
            this.buttonMultiply.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonMultiply.Location = new System.Drawing.Point(29, 110);
            this.buttonMultiply.Name = "buttonMultiply";
            this.buttonMultiply.Size = new System.Drawing.Size(80, 30);
            this.buttonMultiply.TabIndex = 5;
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
            this.buttonSubtract.Location = new System.Drawing.Point(117, 74);
            this.buttonSubtract.Name = "buttonSubtract";
            this.buttonSubtract.Size = new System.Drawing.Size(80, 30);
            this.buttonSubtract.TabIndex = 4;
            this.buttonSubtract.Text = "-";
            this.buttonSubtract.UseVisualStyleBackColor = false;
            this.buttonSubtract.Click += new System.EventHandler(this.buttonSubtract_Click);
            // 
            // buttonPower
            // 
            this.buttonPower.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonPower.FlatAppearance.BorderSize = 0;
            this.buttonPower.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonPower.Location = new System.Drawing.Point(289, 110);
            this.buttonPower.Name = "buttonPower";
            this.buttonPower.Size = new System.Drawing.Size(81, 30);
            this.buttonPower.TabIndex = 10;
            this.buttonPower.Text = "POW";
            this.buttonPower.UseVisualStyleBackColor = false;
            this.buttonPower.Click += new System.EventHandler(this.buttonPower_Click);
            // 
            // buttonTangent
            // 
            this.buttonTangent.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonTangent.FlatAppearance.BorderSize = 0;
            this.buttonTangent.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonTangent.Location = new System.Drawing.Point(202, 110);
            this.buttonTangent.Name = "buttonTangent";
            this.buttonTangent.Size = new System.Drawing.Size(81, 30);
            this.buttonTangent.TabIndex = 9;
            this.buttonTangent.Text = "Tan";
            this.buttonTangent.UseVisualStyleBackColor = false;
            this.buttonTangent.Click += new System.EventHandler(this.buttonTangent_Click);
            // 
            // buttonSine
            // 
            this.buttonSine.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonSine.FlatAppearance.BorderSize = 0;
            this.buttonSine.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonSine.Location = new System.Drawing.Point(202, 74);
            this.buttonSine.Name = "buttonSine";
            this.buttonSine.Size = new System.Drawing.Size(81, 30);
            this.buttonSine.TabIndex = 7;
            this.buttonSine.Text = "Sin";
            this.buttonSine.UseVisualStyleBackColor = false;
            this.buttonSine.Click += new System.EventHandler(this.buttonSine_Click);
            // 
            // buttonCosine
            // 
            this.buttonCosine.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonCosine.FlatAppearance.BorderSize = 0;
            this.buttonCosine.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonCosine.Location = new System.Drawing.Point(289, 74);
            this.buttonCosine.Name = "buttonCosine";
            this.buttonCosine.Size = new System.Drawing.Size(81, 30);
            this.buttonCosine.TabIndex = 8;
            this.buttonCosine.Text = "Cos";
            this.buttonCosine.UseVisualStyleBackColor = false;
            this.buttonCosine.Click += new System.EventHandler(this.buttonCosine_Click);
            // 
            // buttonOptions
            // 
            this.buttonOptions.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonOptions.FlatAppearance.BorderSize = 0;
            this.buttonOptions.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonOptions.Location = new System.Drawing.Point(116, 178);
            this.buttonOptions.Name = "buttonOptions";
            this.buttonOptions.Size = new System.Drawing.Size(81, 33);
            this.buttonOptions.TabIndex = 13;
            this.buttonOptions.Text = "Options";
            this.buttonOptions.UseVisualStyleBackColor = false;
            this.buttonOptions.Click += new System.EventHandler(this.buttonOptions_Click);
            // 
            // RPNCalculator
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.ClientSize = new System.Drawing.Size(382, 233);
            this.Controls.Add(this.buttonOptions);
            this.Controls.Add(this.buttonCosine);
            this.Controls.Add(this.buttonSine);
            this.Controls.Add(this.buttonTangent);
            this.Controls.Add(this.buttonPower);
            this.Controls.Add(this.buttonSubtract);
            this.Controls.Add(this.buttonMultiply);
            this.Controls.Add(this.buttonDivide);
            this.Controls.Add(this.buttonHelp);
            this.Controls.Add(this.buttonClose);
            this.Controls.Add(this.buttonClear);
            this.Controls.Add(this.buttonAdd);
            this.Controls.Add(this.textBoxAnswer);
            this.Controls.Add(this.textBoxSecondNumber);
            this.Controls.Add(this.textBoxFirstNumber);
            this.Controls.Add(this.labelAnswer);
            this.Controls.Add(this.labelSecondNumber);
            this.Controls.Add(this.labelFirstNumber);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "RPNCalculator";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "RPN Calculator";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.RPNCalculator_FormClosing);
            this.Load += new System.EventHandler(this.RPNCalculator_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labelFirstNumber;
        private System.Windows.Forms.Label labelSecondNumber;
        private System.Windows.Forms.Label labelAnswer;
        private System.Windows.Forms.TextBox textBoxFirstNumber;
        private System.Windows.Forms.TextBox textBoxSecondNumber;
        private System.Windows.Forms.TextBox textBoxAnswer;
        private System.Windows.Forms.Button buttonClear;
        private System.Windows.Forms.Button buttonClose;
        private System.Windows.Forms.Button buttonHelp;
        private System.Windows.Forms.Button buttonOptions;
        public System.Windows.Forms.Button buttonAdd;
        public System.Windows.Forms.Button buttonDivide;
        public System.Windows.Forms.Button buttonMultiply;
        public System.Windows.Forms.Button buttonSubtract;
        public System.Windows.Forms.Button buttonPower;
        public System.Windows.Forms.Button buttonTangent;
        public System.Windows.Forms.Button buttonSine;
        public System.Windows.Forms.Button buttonCosine;
    }
}

