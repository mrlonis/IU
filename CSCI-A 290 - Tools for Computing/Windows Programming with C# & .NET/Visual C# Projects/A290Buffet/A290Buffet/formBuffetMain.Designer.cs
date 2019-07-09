namespace A290Buffet
{
    partial class formBuffetMain
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(formBuffetMain));
            this.buttonSelectPicture = new System.Windows.Forms.Button();
            this.buttonQuit = new System.Windows.Forms.Button();
            this.buttonDrawBorder = new System.Windows.Forms.Button();
            this.buttonEnlarge = new System.Windows.Forms.Button();
            this.buttonShrink = new System.Windows.Forms.Button();
            this.pictureBoxShowPicture = new System.Windows.Forms.PictureBox();
            this.openFileDialogSelectPicture = new System.Windows.Forms.OpenFileDialog();
            this.labelX = new System.Windows.Forms.Label();
            this.labelY = new System.Windows.Forms.Label();
            this.buttonOptions = new System.Windows.Forms.Button();
            this.buttonCollections = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxShowPicture)).BeginInit();
            this.SuspendLayout();
            // 
            // buttonSelectPicture
            // 
            this.buttonSelectPicture.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonSelectPicture.BackColor = System.Drawing.SystemColors.ControlDark;
            this.buttonSelectPicture.Cursor = System.Windows.Forms.Cursors.Hand;
            this.buttonSelectPicture.FlatAppearance.BorderSize = 0;
            this.buttonSelectPicture.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonSelectPicture.ForeColor = System.Drawing.SystemColors.Window;
            this.buttonSelectPicture.Location = new System.Drawing.Point(836, 12);
            this.buttonSelectPicture.Name = "buttonSelectPicture";
            this.buttonSelectPicture.Size = new System.Drawing.Size(215, 50);
            this.buttonSelectPicture.TabIndex = 0;
            this.buttonSelectPicture.Text = "Select Picture";
            this.buttonSelectPicture.UseVisualStyleBackColor = false;
            this.buttonSelectPicture.Click += new System.EventHandler(this.buttonSelectPicture_Click);
            // 
            // buttonQuit
            // 
            this.buttonQuit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonQuit.BackColor = System.Drawing.SystemColors.ControlDark;
            this.buttonQuit.Cursor = System.Windows.Forms.Cursors.Hand;
            this.buttonQuit.FlatAppearance.BorderSize = 0;
            this.buttonQuit.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonQuit.ForeColor = System.Drawing.SystemColors.Window;
            this.buttonQuit.Location = new System.Drawing.Point(836, 68);
            this.buttonQuit.Name = "buttonQuit";
            this.buttonQuit.Size = new System.Drawing.Size(215, 50);
            this.buttonQuit.TabIndex = 1;
            this.buttonQuit.Text = "Quit";
            this.buttonQuit.UseVisualStyleBackColor = false;
            this.buttonQuit.Click += new System.EventHandler(this.buttonQuit_Click);
            this.buttonQuit.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.buttonQuit_KeyPress);
            // 
            // buttonDrawBorder
            // 
            this.buttonDrawBorder.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonDrawBorder.BackColor = System.Drawing.SystemColors.ControlDark;
            this.buttonDrawBorder.Cursor = System.Windows.Forms.Cursors.Hand;
            this.buttonDrawBorder.FlatAppearance.BorderSize = 0;
            this.buttonDrawBorder.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonDrawBorder.ForeColor = System.Drawing.SystemColors.Window;
            this.buttonDrawBorder.Location = new System.Drawing.Point(836, 124);
            this.buttonDrawBorder.Name = "buttonDrawBorder";
            this.buttonDrawBorder.Size = new System.Drawing.Size(215, 50);
            this.buttonDrawBorder.TabIndex = 2;
            this.buttonDrawBorder.Text = "Draw Border";
            this.buttonDrawBorder.UseVisualStyleBackColor = false;
            this.buttonDrawBorder.Click += new System.EventHandler(this.buttonDrawBorder_Click);
            // 
            // buttonEnlarge
            // 
            this.buttonEnlarge.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonEnlarge.BackColor = System.Drawing.SystemColors.ControlDark;
            this.buttonEnlarge.Cursor = System.Windows.Forms.Cursors.Hand;
            this.buttonEnlarge.FlatAppearance.BorderSize = 0;
            this.buttonEnlarge.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonEnlarge.ForeColor = System.Drawing.SystemColors.Window;
            this.buttonEnlarge.Location = new System.Drawing.Point(836, 406);
            this.buttonEnlarge.Name = "buttonEnlarge";
            this.buttonEnlarge.Size = new System.Drawing.Size(215, 50);
            this.buttonEnlarge.TabIndex = 3;
            this.buttonEnlarge.Text = "^";
            this.buttonEnlarge.UseVisualStyleBackColor = false;
            this.buttonEnlarge.Click += new System.EventHandler(this.buttonEnlarge_Click);
            // 
            // buttonShrink
            // 
            this.buttonShrink.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonShrink.BackColor = System.Drawing.SystemColors.ControlDark;
            this.buttonShrink.Cursor = System.Windows.Forms.Cursors.Hand;
            this.buttonShrink.FlatAppearance.BorderSize = 0;
            this.buttonShrink.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonShrink.ForeColor = System.Drawing.SystemColors.Window;
            this.buttonShrink.Location = new System.Drawing.Point(836, 462);
            this.buttonShrink.Name = "buttonShrink";
            this.buttonShrink.Size = new System.Drawing.Size(215, 50);
            this.buttonShrink.TabIndex = 4;
            this.buttonShrink.Text = "v";
            this.buttonShrink.UseVisualStyleBackColor = false;
            this.buttonShrink.Click += new System.EventHandler(this.buttonShrink_Click);
            // 
            // pictureBoxShowPicture
            // 
            this.pictureBoxShowPicture.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pictureBoxShowPicture.BackColor = System.Drawing.SystemColors.Desktop;
            this.pictureBoxShowPicture.Cursor = System.Windows.Forms.Cursors.Hand;
            this.pictureBoxShowPicture.Location = new System.Drawing.Point(12, 12);
            this.pictureBoxShowPicture.Name = "pictureBoxShowPicture";
            this.pictureBoxShowPicture.Size = new System.Drawing.Size(818, 761);
            this.pictureBoxShowPicture.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBoxShowPicture.TabIndex = 5;
            this.pictureBoxShowPicture.TabStop = false;
            this.pictureBoxShowPicture.Click += new System.EventHandler(this.pictureBoxShowPicture_Click);
            this.pictureBoxShowPicture.MouseLeave += new System.EventHandler(this.pictureBoxShowPicture_MouseLeave);
            this.pictureBoxShowPicture.MouseMove += new System.Windows.Forms.MouseEventHandler(this.pictureBoxShowPicture_MouseMove);
            this.pictureBoxShowPicture.Resize += new System.EventHandler(this.pictureBoxShowPicture_Resize);
            // 
            // openFileDialogSelectPicture
            // 
            this.openFileDialogSelectPicture.Filter = "Windows Bitmaps|*.BMP|JPEG|*.JPG|Image Files(*.BMP;*.JPG;*.GIF)|*.BMP;*.JPG;*.GIF" +
    "";
            this.openFileDialogSelectPicture.Title = "Select Picture";
            this.openFileDialogSelectPicture.FileOk += new System.ComponentModel.CancelEventHandler(this.openFileDialogSelectPicture_FileOk);
            // 
            // labelX
            // 
            this.labelX.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.labelX.AutoSize = true;
            this.labelX.BackColor = System.Drawing.SystemColors.Desktop;
            this.labelX.Cursor = System.Windows.Forms.Cursors.No;
            this.labelX.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.labelX.ForeColor = System.Drawing.SystemColors.Window;
            this.labelX.Location = new System.Drawing.Point(876, 579);
            this.labelX.Name = "labelX";
            this.labelX.Size = new System.Drawing.Size(34, 32);
            this.labelX.TabIndex = 6;
            this.labelX.Text = "X";
            this.labelX.Click += new System.EventHandler(this.labelX_Click);
            // 
            // labelY
            // 
            this.labelY.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.labelY.AutoSize = true;
            this.labelY.BackColor = System.Drawing.SystemColors.Desktop;
            this.labelY.Cursor = System.Windows.Forms.Cursors.No;
            this.labelY.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.labelY.ForeColor = System.Drawing.SystemColors.Window;
            this.labelY.Location = new System.Drawing.Point(876, 648);
            this.labelY.Name = "labelY";
            this.labelY.Size = new System.Drawing.Size(34, 32);
            this.labelY.TabIndex = 7;
            this.labelY.Text = "Y";
            // 
            // buttonOptions
            // 
            this.buttonOptions.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonOptions.BackColor = System.Drawing.SystemColors.ControlDark;
            this.buttonOptions.Cursor = System.Windows.Forms.Cursors.Hand;
            this.buttonOptions.FlatAppearance.BorderSize = 0;
            this.buttonOptions.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonOptions.ForeColor = System.Drawing.SystemColors.Window;
            this.buttonOptions.Location = new System.Drawing.Point(836, 180);
            this.buttonOptions.Name = "buttonOptions";
            this.buttonOptions.Size = new System.Drawing.Size(215, 50);
            this.buttonOptions.TabIndex = 8;
            this.buttonOptions.Text = "Options";
            this.buttonOptions.UseVisualStyleBackColor = false;
            this.buttonOptions.Click += new System.EventHandler(this.buttonOptions_Click);
            // 
            // buttonCollections
            // 
            this.buttonCollections.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonCollections.BackColor = System.Drawing.SystemColors.ControlDark;
            this.buttonCollections.Cursor = System.Windows.Forms.Cursors.Hand;
            this.buttonCollections.FlatAppearance.BorderSize = 0;
            this.buttonCollections.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonCollections.ForeColor = System.Drawing.SystemColors.Window;
            this.buttonCollections.Location = new System.Drawing.Point(836, 236);
            this.buttonCollections.Name = "buttonCollections";
            this.buttonCollections.Size = new System.Drawing.Size(215, 50);
            this.buttonCollections.TabIndex = 9;
            this.buttonCollections.Text = "Collections";
            this.buttonCollections.UseVisualStyleBackColor = false;
            this.buttonCollections.Click += new System.EventHandler(this.buttonCollections_Click);
            // 
            // formBuffetMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(16F, 31F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.Desktop;
            this.ClientSize = new System.Drawing.Size(1063, 821);
            this.Controls.Add(this.buttonCollections);
            this.Controls.Add(this.buttonOptions);
            this.Controls.Add(this.labelY);
            this.Controls.Add(this.labelX);
            this.Controls.Add(this.pictureBoxShowPicture);
            this.Controls.Add(this.buttonShrink);
            this.Controls.Add(this.buttonEnlarge);
            this.Controls.Add(this.buttonDrawBorder);
            this.Controls.Add(this.buttonQuit);
            this.Controls.Add(this.buttonSelectPicture);
            this.DoubleBuffered = true;
            this.ForeColor = System.Drawing.SystemColors.Desktop;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "formBuffetMain";
            this.Text = "A290 Buffet";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.formBuffetMain_FormClosing);
            this.Load += new System.EventHandler(this.formBuffetMain_Load);
            this.Layout += new System.Windows.Forms.LayoutEventHandler(this.formBuffetMain_Layout);
            this.Resize += new System.EventHandler(this.formBuffetMain_Resize);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxShowPicture)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonSelectPicture;
        private System.Windows.Forms.Button buttonQuit;
        private System.Windows.Forms.Button buttonDrawBorder;
        private System.Windows.Forms.Button buttonEnlarge;
        private System.Windows.Forms.Button buttonShrink;
        private System.Windows.Forms.PictureBox pictureBoxShowPicture;
        private System.Windows.Forms.OpenFileDialog openFileDialogSelectPicture;
        private System.Windows.Forms.Label labelX;
        private System.Windows.Forms.Label labelY;
        private System.Windows.Forms.Button buttonOptions;
        private System.Windows.Forms.Button buttonCollections;
    }
}

