namespace RPNCalculator
{
    partial class formOptions
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.labelBackgroundColor = new System.Windows.Forms.Label();
            this.radioButtonActiveCaption = new System.Windows.Forms.RadioButton();
            this.radioButtonControl = new System.Windows.Forms.RadioButton();
            this.radioButtonInfo = new System.Windows.Forms.RadioButton();
            this.checkBoxConfirmOnExit = new System.Windows.Forms.CheckBox();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // buttonClose
            // 
            this.buttonClose.Location = new System.Drawing.Point(16, 200);
            this.buttonClose.Name = "buttonClose";
            this.buttonClose.Size = new System.Drawing.Size(81, 30);
            this.buttonClose.TabIndex = 1;
            this.buttonClose.Text = "Close";
            this.buttonClose.UseVisualStyleBackColor = true;
            this.buttonClose.Click += new System.EventHandler(this.buttonClose_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.SystemColors.Control;
            this.groupBox1.Controls.Add(this.radioButtonInfo);
            this.groupBox1.Controls.Add(this.radioButtonControl);
            this.groupBox1.Controls.Add(this.radioButtonActiveCaption);
            this.groupBox1.Location = new System.Drawing.Point(16, 32);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(200, 132);
            this.groupBox1.TabIndex = 2;
            this.groupBox1.TabStop = false;
            // 
            // labelBackgroundColor
            // 
            this.labelBackgroundColor.AutoSize = true;
            this.labelBackgroundColor.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelBackgroundColor.Location = new System.Drawing.Point(12, 9);
            this.labelBackgroundColor.Name = "labelBackgroundColor";
            this.labelBackgroundColor.Size = new System.Drawing.Size(199, 20);
            this.labelBackgroundColor.TabIndex = 0;
            this.labelBackgroundColor.Text = "Background Color Options:";
            // 
            // radioButtonActiveCaption
            // 
            this.radioButtonActiveCaption.AutoSize = true;
            this.radioButtonActiveCaption.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.radioButtonActiveCaption.ForeColor = System.Drawing.SystemColors.ControlText;
            this.radioButtonActiveCaption.Location = new System.Drawing.Point(7, 26);
            this.radioButtonActiveCaption.Name = "radioButtonActiveCaption";
            this.radioButtonActiveCaption.Size = new System.Drawing.Size(79, 24);
            this.radioButtonActiveCaption.TabIndex = 0;
            this.radioButtonActiveCaption.TabStop = true;
            this.radioButtonActiveCaption.Text = "Default";
            this.radioButtonActiveCaption.UseVisualStyleBackColor = true;
            this.radioButtonActiveCaption.CheckedChanged += new System.EventHandler(this.radioButtonActiveCaption_CheckedChanged);
            // 
            // radioButtonControl
            // 
            this.radioButtonControl.AutoSize = true;
            this.radioButtonControl.Location = new System.Drawing.Point(7, 57);
            this.radioButtonControl.Name = "radioButtonControl";
            this.radioButtonControl.Size = new System.Drawing.Size(68, 24);
            this.radioButtonControl.TabIndex = 1;
            this.radioButtonControl.TabStop = true;
            this.radioButtonControl.Text = "White";
            this.radioButtonControl.UseVisualStyleBackColor = true;
            this.radioButtonControl.CheckedChanged += new System.EventHandler(this.radioButtonControl_CheckedChanged);
            // 
            // radioButtonInfo
            // 
            this.radioButtonInfo.AutoSize = true;
            this.radioButtonInfo.ForeColor = System.Drawing.SystemColors.ControlText;
            this.radioButtonInfo.Location = new System.Drawing.Point(7, 88);
            this.radioButtonInfo.Name = "radioButtonInfo";
            this.radioButtonInfo.Size = new System.Drawing.Size(73, 24);
            this.radioButtonInfo.TabIndex = 2;
            this.radioButtonInfo.TabStop = true;
            this.radioButtonInfo.Text = "Yellow";
            this.radioButtonInfo.UseVisualStyleBackColor = true;
            this.radioButtonInfo.CheckedChanged += new System.EventHandler(this.radioButtonInfo_CheckedChanged);
            // 
            // checkBoxConfirmOnExit
            // 
            this.checkBoxConfirmOnExit.AutoSize = true;
            this.checkBoxConfirmOnExit.Location = new System.Drawing.Point(16, 170);
            this.checkBoxConfirmOnExit.Name = "checkBoxConfirmOnExit";
            this.checkBoxConfirmOnExit.Size = new System.Drawing.Size(157, 24);
            this.checkBoxConfirmOnExit.TabIndex = 3;
            this.checkBoxConfirmOnExit.Text = "Exit Confirmation?";
            this.checkBoxConfirmOnExit.UseVisualStyleBackColor = true;
            this.checkBoxConfirmOnExit.CheckedChanged += new System.EventHandler(this.checkBoxConfirmOnExit_CheckedChanged);
            // 
            // formOptions
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.ClientSize = new System.Drawing.Size(234, 243);
            this.Controls.Add(this.checkBoxConfirmOnExit);
            this.Controls.Add(this.labelBackgroundColor);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.buttonClose);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "formOptions";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Options";
            this.Load += new System.EventHandler(this.formOptions_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Button buttonClose;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.RadioButton radioButtonControl;
        private System.Windows.Forms.RadioButton radioButtonActiveCaption;
        private System.Windows.Forms.Label labelBackgroundColor;
        private System.Windows.Forms.RadioButton radioButtonInfo;
        private System.Windows.Forms.CheckBox checkBoxConfirmOnExit;
    }
}