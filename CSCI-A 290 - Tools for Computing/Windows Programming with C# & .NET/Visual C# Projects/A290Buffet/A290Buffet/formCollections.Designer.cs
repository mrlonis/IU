namespace A290Buffet
{
    partial class formCollections
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(formCollections));
            this.buttonShowNames = new System.Windows.Forms.Button();
            this.buttonCollections1 = new System.Windows.Forms.Button();
            this.buttonCollections2 = new System.Windows.Forms.Button();
            this.buttonCollections3 = new System.Windows.Forms.Button();
            this.buttonCollections4 = new System.Windows.Forms.Button();
            this.textBoxCollection = new System.Windows.Forms.TextBox();
            this.buttonClose = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // buttonShowNames
            // 
            this.buttonShowNames.BackColor = System.Drawing.SystemColors.ControlDark;
            this.buttonShowNames.FlatAppearance.BorderSize = 0;
            this.buttonShowNames.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonShowNames.ForeColor = System.Drawing.SystemColors.Window;
            this.buttonShowNames.Location = new System.Drawing.Point(12, 12);
            this.buttonShowNames.Name = "buttonShowNames";
            this.buttonShowNames.Size = new System.Drawing.Size(298, 145);
            this.buttonShowNames.TabIndex = 0;
            this.buttonShowNames.Text = "Show Control Names";
            this.buttonShowNames.UseVisualStyleBackColor = false;
            this.buttonShowNames.Click += new System.EventHandler(this.buttonShowNames_Click);
            // 
            // buttonCollections1
            // 
            this.buttonCollections1.Location = new System.Drawing.Point(12, 193);
            this.buttonCollections1.Name = "buttonCollections1";
            this.buttonCollections1.Size = new System.Drawing.Size(197, 52);
            this.buttonCollections1.TabIndex = 1;
            this.buttonCollections1.Text = "Chris";
            this.buttonCollections1.UseVisualStyleBackColor = true;
            // 
            // buttonCollections2
            // 
            this.buttonCollections2.Location = new System.Drawing.Point(12, 251);
            this.buttonCollections2.Name = "buttonCollections2";
            this.buttonCollections2.Size = new System.Drawing.Size(197, 52);
            this.buttonCollections2.TabIndex = 2;
            this.buttonCollections2.Text = "Jake";
            this.buttonCollections2.UseVisualStyleBackColor = true;
            // 
            // buttonCollections3
            // 
            this.buttonCollections3.Location = new System.Drawing.Point(12, 309);
            this.buttonCollections3.Name = "buttonCollections3";
            this.buttonCollections3.Size = new System.Drawing.Size(197, 52);
            this.buttonCollections3.TabIndex = 3;
            this.buttonCollections3.Text = "Jordan";
            this.buttonCollections3.UseVisualStyleBackColor = true;
            // 
            // buttonCollections4
            // 
            this.buttonCollections4.Location = new System.Drawing.Point(12, 367);
            this.buttonCollections4.Name = "buttonCollections4";
            this.buttonCollections4.Size = new System.Drawing.Size(197, 52);
            this.buttonCollections4.TabIndex = 4;
            this.buttonCollections4.Text = "Joey";
            this.buttonCollections4.UseVisualStyleBackColor = true;
            // 
            // textBoxCollection
            // 
            this.textBoxCollection.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.textBoxCollection.Location = new System.Drawing.Point(306, 494);
            this.textBoxCollection.Name = "textBoxCollection";
            this.textBoxCollection.Size = new System.Drawing.Size(369, 38);
            this.textBoxCollection.TabIndex = 5;
            this.textBoxCollection.Text = "Matthew Lonis";
            // 
            // buttonClose
            // 
            this.buttonClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonClose.Location = new System.Drawing.Point(728, 13);
            this.buttonClose.Name = "buttonClose";
            this.buttonClose.Size = new System.Drawing.Size(203, 72);
            this.buttonClose.TabIndex = 6;
            this.buttonClose.Text = "Close";
            this.buttonClose.UseVisualStyleBackColor = true;
            this.buttonClose.Click += new System.EventHandler(this.buttonClose_Click);
            this.buttonClose.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.buttonClose_KeyPress);
            // 
            // formCollections
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(16F, 31F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.Desktop;
            this.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("$this.BackgroundImage")));
            this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.ClientSize = new System.Drawing.Size(943, 760);
            this.Controls.Add(this.buttonClose);
            this.Controls.Add(this.textBoxCollection);
            this.Controls.Add(this.buttonCollections4);
            this.Controls.Add(this.buttonCollections3);
            this.Controls.Add(this.buttonCollections2);
            this.Controls.Add(this.buttonCollections1);
            this.Controls.Add(this.buttonShowNames);
            this.ForeColor = System.Drawing.SystemColors.ControlText;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "formCollections";
            this.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "A290 Collections";
            this.Load += new System.EventHandler(this.formCollections_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonShowNames;
        private System.Windows.Forms.Button buttonCollections1;
        private System.Windows.Forms.Button buttonCollections2;
        private System.Windows.Forms.Button buttonCollections3;
        private System.Windows.Forms.Button buttonCollections4;
        private System.Windows.Forms.TextBox textBoxCollection;
        private System.Windows.Forms.Button buttonClose;
    }
}