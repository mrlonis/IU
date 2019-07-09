namespace A290FinalProject
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
            this.groupBoxBackColorOptions = new System.Windows.Forms.GroupBox();
            this.radioButtonGreen = new System.Windows.Forms.RadioButton();
            this.radioButtonBlue = new System.Windows.Forms.RadioButton();
            this.radioButtonYellow = new System.Windows.Forms.RadioButton();
            this.radioButtonWhite = new System.Windows.Forms.RadioButton();
            this.radioButtonDefault = new System.Windows.Forms.RadioButton();
            this.labelBackColorOptions = new System.Windows.Forms.Label();
            this.checkBoxConfirmOnExit = new System.Windows.Forms.CheckBox();
            this.groupBoxBackColorOptions.SuspendLayout();
            this.SuspendLayout();
            // 
            // buttonClose
            // 
            this.buttonClose.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClose.FlatAppearance.BorderSize = 0;
            this.buttonClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClose.Location = new System.Drawing.Point(98, 285);
            this.buttonClose.Name = "buttonClose";
            this.buttonClose.Size = new System.Drawing.Size(75, 30);
            this.buttonClose.TabIndex = 0;
            this.buttonClose.Text = "Close";
            this.buttonClose.UseVisualStyleBackColor = false;
            this.buttonClose.Click += new System.EventHandler(this.buttonClose_Click);
            this.buttonClose.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.buttonClose_KeyPress);
            // 
            // groupBoxBackColorOptions
            // 
            this.groupBoxBackColorOptions.BackColor = System.Drawing.SystemColors.ControlLight;
            this.groupBoxBackColorOptions.Controls.Add(this.radioButtonGreen);
            this.groupBoxBackColorOptions.Controls.Add(this.radioButtonBlue);
            this.groupBoxBackColorOptions.Controls.Add(this.radioButtonYellow);
            this.groupBoxBackColorOptions.Controls.Add(this.radioButtonWhite);
            this.groupBoxBackColorOptions.Controls.Add(this.radioButtonDefault);
            this.groupBoxBackColorOptions.Location = new System.Drawing.Point(16, 32);
            this.groupBoxBackColorOptions.Name = "groupBoxBackColorOptions";
            this.groupBoxBackColorOptions.Size = new System.Drawing.Size(220, 199);
            this.groupBoxBackColorOptions.TabIndex = 1;
            this.groupBoxBackColorOptions.TabStop = false;
            // 
            // radioButtonGreen
            // 
            this.radioButtonGreen.AutoSize = true;
            this.radioButtonGreen.Location = new System.Drawing.Point(7, 146);
            this.radioButtonGreen.Name = "radioButtonGreen";
            this.radioButtonGreen.Size = new System.Drawing.Size(72, 24);
            this.radioButtonGreen.TabIndex = 4;
            this.radioButtonGreen.TabStop = true;
            this.radioButtonGreen.Text = "Green";
            this.radioButtonGreen.UseVisualStyleBackColor = true;
            this.radioButtonGreen.CheckedChanged += new System.EventHandler(this.radioButtonGreen_CheckedChanged);
            // 
            // radioButtonBlue
            // 
            this.radioButtonBlue.AutoSize = true;
            this.radioButtonBlue.Location = new System.Drawing.Point(7, 116);
            this.radioButtonBlue.Name = "radioButtonBlue";
            this.radioButtonBlue.Size = new System.Drawing.Size(59, 24);
            this.radioButtonBlue.TabIndex = 3;
            this.radioButtonBlue.TabStop = true;
            this.radioButtonBlue.Text = "Blue";
            this.radioButtonBlue.UseVisualStyleBackColor = true;
            this.radioButtonBlue.CheckedChanged += new System.EventHandler(this.radioButtonBlue_CheckedChanged);
            // 
            // radioButtonYellow
            // 
            this.radioButtonYellow.AutoSize = true;
            this.radioButtonYellow.Location = new System.Drawing.Point(7, 86);
            this.radioButtonYellow.Name = "radioButtonYellow";
            this.radioButtonYellow.Size = new System.Drawing.Size(73, 24);
            this.radioButtonYellow.TabIndex = 2;
            this.radioButtonYellow.TabStop = true;
            this.radioButtonYellow.Text = "Yellow";
            this.radioButtonYellow.UseVisualStyleBackColor = true;
            this.radioButtonYellow.CheckedChanged += new System.EventHandler(this.radioButtonYellow_CheckedChanged);
            // 
            // radioButtonWhite
            // 
            this.radioButtonWhite.AutoSize = true;
            this.radioButtonWhite.Location = new System.Drawing.Point(7, 56);
            this.radioButtonWhite.Name = "radioButtonWhite";
            this.radioButtonWhite.Size = new System.Drawing.Size(68, 24);
            this.radioButtonWhite.TabIndex = 1;
            this.radioButtonWhite.TabStop = true;
            this.radioButtonWhite.Text = "White";
            this.radioButtonWhite.UseVisualStyleBackColor = true;
            this.radioButtonWhite.CheckedChanged += new System.EventHandler(this.radioButtonWhite_CheckedChanged);
            // 
            // radioButtonDefault
            // 
            this.radioButtonDefault.AutoSize = true;
            this.radioButtonDefault.Location = new System.Drawing.Point(7, 26);
            this.radioButtonDefault.Name = "radioButtonDefault";
            this.radioButtonDefault.Size = new System.Drawing.Size(79, 24);
            this.radioButtonDefault.TabIndex = 0;
            this.radioButtonDefault.TabStop = true;
            this.radioButtonDefault.Text = "Default";
            this.radioButtonDefault.UseVisualStyleBackColor = true;
            this.radioButtonDefault.CheckedChanged += new System.EventHandler(this.radioButtonDefault_CheckedChanged);
            // 
            // labelBackColorOptions
            // 
            this.labelBackColorOptions.AutoSize = true;
            this.labelBackColorOptions.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelBackColorOptions.Location = new System.Drawing.Point(12, 9);
            this.labelBackColorOptions.Name = "labelBackColorOptions";
            this.labelBackColorOptions.Size = new System.Drawing.Size(224, 20);
            this.labelBackColorOptions.TabIndex = 2;
            this.labelBackColorOptions.Text = "Background Color Options:";
            // 
            // checkBoxConfirmOnExit
            // 
            this.checkBoxConfirmOnExit.AutoSize = true;
            this.checkBoxConfirmOnExit.Location = new System.Drawing.Point(16, 255);
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
            this.BackColor = System.Drawing.Color.RosyBrown;
            this.ClientSize = new System.Drawing.Size(264, 334);
            this.Controls.Add(this.checkBoxConfirmOnExit);
            this.Controls.Add(this.labelBackColorOptions);
            this.Controls.Add(this.groupBoxBackColorOptions);
            this.Controls.Add(this.buttonClose);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "formOptions";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Options";
            this.Load += new System.EventHandler(this.formOptions_Load);
            this.groupBoxBackColorOptions.ResumeLayout(false);
            this.groupBoxBackColorOptions.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonClose;
        private System.Windows.Forms.GroupBox groupBoxBackColorOptions;
        private System.Windows.Forms.RadioButton radioButtonDefault;
        private System.Windows.Forms.Label labelBackColorOptions;
        private System.Windows.Forms.RadioButton radioButtonWhite;
        private System.Windows.Forms.RadioButton radioButtonYellow;
        private System.Windows.Forms.RadioButton radioButtonBlue;
        private System.Windows.Forms.RadioButton radioButtonGreen;
        private System.Windows.Forms.CheckBox checkBoxConfirmOnExit;
    }
}