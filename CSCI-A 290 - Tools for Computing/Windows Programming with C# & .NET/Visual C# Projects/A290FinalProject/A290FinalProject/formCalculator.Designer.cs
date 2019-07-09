namespace A290FinalProject
{
    partial class formCalculator
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
            this.textBoxFirstNumber = new System.Windows.Forms.TextBox();
            this.labelFirstNumber = new System.Windows.Forms.Label();
            this.labelSecondNumber = new System.Windows.Forms.Label();
            this.labelAnswer = new System.Windows.Forms.Label();
            this.textBoxSecondNumber = new System.Windows.Forms.TextBox();
            this.textBoxAnswer = new System.Windows.Forms.TextBox();
            this.buttonClear = new System.Windows.Forms.Button();
            this.buttonAdd = new System.Windows.Forms.Button();
            this.buttonTangent = new System.Windows.Forms.Button();
            this.buttonSine = new System.Windows.Forms.Button();
            this.buttonPower = new System.Windows.Forms.Button();
            this.buttonCosine = new System.Windows.Forms.Button();
            this.buttonDivide = new System.Windows.Forms.Button();
            this.buttonMultiply = new System.Windows.Forms.Button();
            this.buttonSubtract = new System.Windows.Forms.Button();
            this.buttonHelp = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // buttonClose
            // 
            this.buttonClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonClose.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClose.FlatAppearance.BorderSize = 0;
            this.buttonClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClose.Location = new System.Drawing.Point(339, 221);
            this.buttonClose.Name = "buttonClose";
            this.buttonClose.Size = new System.Drawing.Size(75, 30);
            this.buttonClose.TabIndex = 0;
            this.buttonClose.Text = "Close";
            this.buttonClose.UseVisualStyleBackColor = false;
            this.buttonClose.Click += new System.EventHandler(this.buttonClose_Click);
            this.buttonClose.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.buttonClose_KeyPress);
            // 
            // textBoxFirstNumber
            // 
            this.textBoxFirstNumber.Location = new System.Drawing.Point(160, 12);
            this.textBoxFirstNumber.Name = "textBoxFirstNumber";
            this.textBoxFirstNumber.Size = new System.Drawing.Size(254, 26);
            this.textBoxFirstNumber.TabIndex = 1;
            this.textBoxFirstNumber.Leave += new System.EventHandler(this.textBoxFirstNumber_Leave_1);
            this.textBoxFirstNumber.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxFirstNumber_MouseDown);
            // 
            // labelFirstNumber
            // 
            this.labelFirstNumber.AutoSize = true;
            this.labelFirstNumber.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelFirstNumber.Location = new System.Drawing.Point(37, 15);
            this.labelFirstNumber.Name = "labelFirstNumber";
            this.labelFirstNumber.Size = new System.Drawing.Size(117, 20);
            this.labelFirstNumber.TabIndex = 2;
            this.labelFirstNumber.Text = "First Number:";
            this.labelFirstNumber.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelSecondNumber
            // 
            this.labelSecondNumber.AutoSize = true;
            this.labelSecondNumber.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelSecondNumber.Location = new System.Drawing.Point(12, 58);
            this.labelSecondNumber.Name = "labelSecondNumber";
            this.labelSecondNumber.Size = new System.Drawing.Size(142, 20);
            this.labelSecondNumber.TabIndex = 3;
            this.labelSecondNumber.Text = "Second Number:";
            this.labelSecondNumber.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // labelAnswer
            // 
            this.labelAnswer.AutoSize = true;
            this.labelAnswer.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelAnswer.Location = new System.Drawing.Point(81, 182);
            this.labelAnswer.Name = "labelAnswer";
            this.labelAnswer.Size = new System.Drawing.Size(73, 20);
            this.labelAnswer.TabIndex = 4;
            this.labelAnswer.Text = "Answer:";
            this.labelAnswer.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // textBoxSecondNumber
            // 
            this.textBoxSecondNumber.Location = new System.Drawing.Point(160, 55);
            this.textBoxSecondNumber.Name = "textBoxSecondNumber";
            this.textBoxSecondNumber.Size = new System.Drawing.Size(254, 26);
            this.textBoxSecondNumber.TabIndex = 5;
            this.textBoxSecondNumber.Leave += new System.EventHandler(this.textBoxSecondNumber_Leave);
            this.textBoxSecondNumber.MouseDown += new System.Windows.Forms.MouseEventHandler(this.textBoxSecondNumber_MouseDown);
            // 
            // textBoxAnswer
            // 
            this.textBoxAnswer.Location = new System.Drawing.Point(160, 179);
            this.textBoxAnswer.Name = "textBoxAnswer";
            this.textBoxAnswer.Size = new System.Drawing.Size(254, 26);
            this.textBoxAnswer.TabIndex = 6;
            // 
            // buttonClear
            // 
            this.buttonClear.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonClear.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClear.FlatAppearance.BorderSize = 0;
            this.buttonClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClear.Location = new System.Drawing.Point(258, 221);
            this.buttonClear.Name = "buttonClear";
            this.buttonClear.Size = new System.Drawing.Size(75, 30);
            this.buttonClear.TabIndex = 7;
            this.buttonClear.Text = "Clear";
            this.buttonClear.UseVisualStyleBackColor = false;
            this.buttonClear.Click += new System.EventHandler(this.buttonClear_Click);
            // 
            // buttonAdd
            // 
            this.buttonAdd.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonAdd.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonAdd.FlatAppearance.BorderSize = 0;
            this.buttonAdd.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonAdd.Location = new System.Drawing.Point(96, 96);
            this.buttonAdd.Name = "buttonAdd";
            this.buttonAdd.Size = new System.Drawing.Size(75, 30);
            this.buttonAdd.TabIndex = 8;
            this.buttonAdd.Text = "+";
            this.buttonAdd.UseVisualStyleBackColor = false;
            this.buttonAdd.Click += new System.EventHandler(this.buttonAdd_Click);
            // 
            // buttonTangent
            // 
            this.buttonTangent.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonTangent.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonTangent.FlatAppearance.BorderSize = 0;
            this.buttonTangent.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonTangent.Location = new System.Drawing.Point(258, 132);
            this.buttonTangent.Name = "buttonTangent";
            this.buttonTangent.Size = new System.Drawing.Size(75, 30);
            this.buttonTangent.TabIndex = 9;
            this.buttonTangent.Text = "Tan";
            this.buttonTangent.UseVisualStyleBackColor = false;
            this.buttonTangent.Click += new System.EventHandler(this.buttonTangent_Click);
            // 
            // buttonSine
            // 
            this.buttonSine.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonSine.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonSine.FlatAppearance.BorderSize = 0;
            this.buttonSine.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonSine.Location = new System.Drawing.Point(258, 96);
            this.buttonSine.Name = "buttonSine";
            this.buttonSine.Size = new System.Drawing.Size(75, 30);
            this.buttonSine.TabIndex = 10;
            this.buttonSine.Text = "Sin";
            this.buttonSine.UseVisualStyleBackColor = false;
            this.buttonSine.Click += new System.EventHandler(this.buttonSine_Click);
            // 
            // buttonPower
            // 
            this.buttonPower.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonPower.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonPower.FlatAppearance.BorderSize = 0;
            this.buttonPower.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonPower.Location = new System.Drawing.Point(339, 132);
            this.buttonPower.Name = "buttonPower";
            this.buttonPower.Size = new System.Drawing.Size(75, 30);
            this.buttonPower.TabIndex = 11;
            this.buttonPower.Text = "POW";
            this.buttonPower.UseVisualStyleBackColor = false;
            this.buttonPower.Click += new System.EventHandler(this.buttonPower_Click);
            // 
            // buttonCosine
            // 
            this.buttonCosine.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonCosine.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonCosine.FlatAppearance.BorderSize = 0;
            this.buttonCosine.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonCosine.Location = new System.Drawing.Point(339, 96);
            this.buttonCosine.Name = "buttonCosine";
            this.buttonCosine.Size = new System.Drawing.Size(75, 30);
            this.buttonCosine.TabIndex = 12;
            this.buttonCosine.Text = "Cos";
            this.buttonCosine.UseVisualStyleBackColor = false;
            this.buttonCosine.Click += new System.EventHandler(this.buttonCosine_Click);
            // 
            // buttonDivide
            // 
            this.buttonDivide.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonDivide.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonDivide.FlatAppearance.BorderSize = 0;
            this.buttonDivide.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonDivide.Location = new System.Drawing.Point(177, 132);
            this.buttonDivide.Name = "buttonDivide";
            this.buttonDivide.Size = new System.Drawing.Size(75, 30);
            this.buttonDivide.TabIndex = 13;
            this.buttonDivide.Text = "\\";
            this.buttonDivide.UseVisualStyleBackColor = false;
            this.buttonDivide.Click += new System.EventHandler(this.buttonDivide_Click);
            // 
            // buttonMultiply
            // 
            this.buttonMultiply.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonMultiply.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonMultiply.FlatAppearance.BorderSize = 0;
            this.buttonMultiply.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonMultiply.Location = new System.Drawing.Point(96, 132);
            this.buttonMultiply.Name = "buttonMultiply";
            this.buttonMultiply.Size = new System.Drawing.Size(75, 30);
            this.buttonMultiply.TabIndex = 14;
            this.buttonMultiply.Text = "*";
            this.buttonMultiply.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.buttonMultiply.UseVisualStyleBackColor = false;
            this.buttonMultiply.Click += new System.EventHandler(this.buttonMultiply_Click);
            // 
            // buttonSubtract
            // 
            this.buttonSubtract.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonSubtract.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonSubtract.FlatAppearance.BorderSize = 0;
            this.buttonSubtract.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonSubtract.Location = new System.Drawing.Point(177, 96);
            this.buttonSubtract.Name = "buttonSubtract";
            this.buttonSubtract.Size = new System.Drawing.Size(75, 30);
            this.buttonSubtract.TabIndex = 15;
            this.buttonSubtract.Text = "-";
            this.buttonSubtract.UseVisualStyleBackColor = false;
            this.buttonSubtract.Click += new System.EventHandler(this.buttonSubtract_Click);
            // 
            // buttonHelp
            // 
            this.buttonHelp.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonHelp.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonHelp.FlatAppearance.BorderSize = 0;
            this.buttonHelp.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonHelp.Location = new System.Drawing.Point(177, 221);
            this.buttonHelp.Name = "buttonHelp";
            this.buttonHelp.Size = new System.Drawing.Size(75, 30);
            this.buttonHelp.TabIndex = 16;
            this.buttonHelp.Text = "Help";
            this.buttonHelp.UseVisualStyleBackColor = false;
            this.buttonHelp.Click += new System.EventHandler(this.buttonHelp_Click);
            // 
            // formCalculator
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.RosyBrown;
            this.ClientSize = new System.Drawing.Size(426, 283);
            this.Controls.Add(this.buttonHelp);
            this.Controls.Add(this.buttonSubtract);
            this.Controls.Add(this.buttonMultiply);
            this.Controls.Add(this.buttonDivide);
            this.Controls.Add(this.buttonCosine);
            this.Controls.Add(this.buttonPower);
            this.Controls.Add(this.buttonSine);
            this.Controls.Add(this.buttonTangent);
            this.Controls.Add(this.buttonAdd);
            this.Controls.Add(this.buttonClear);
            this.Controls.Add(this.textBoxAnswer);
            this.Controls.Add(this.textBoxSecondNumber);
            this.Controls.Add(this.labelAnswer);
            this.Controls.Add(this.labelSecondNumber);
            this.Controls.Add(this.labelFirstNumber);
            this.Controls.Add(this.textBoxFirstNumber);
            this.Controls.Add(this.buttonClose);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "formCalculator";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Calculator";
            this.Load += new System.EventHandler(this.formCalculator_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonClose;
        private System.Windows.Forms.TextBox textBoxFirstNumber;
        private System.Windows.Forms.Label labelFirstNumber;
        private System.Windows.Forms.Label labelSecondNumber;
        private System.Windows.Forms.Label labelAnswer;
        private System.Windows.Forms.TextBox textBoxSecondNumber;
        private System.Windows.Forms.TextBox textBoxAnswer;
        private System.Windows.Forms.Button buttonClear;
        private System.Windows.Forms.Button buttonHelp;
        public System.Windows.Forms.Button buttonAdd;
        public System.Windows.Forms.Button buttonTangent;
        public System.Windows.Forms.Button buttonSine;
        public System.Windows.Forms.Button buttonPower;
        public System.Windows.Forms.Button buttonCosine;
        public System.Windows.Forms.Button buttonDivide;
        public System.Windows.Forms.Button buttonMultiply;
        public System.Windows.Forms.Button buttonSubtract;
    }
}