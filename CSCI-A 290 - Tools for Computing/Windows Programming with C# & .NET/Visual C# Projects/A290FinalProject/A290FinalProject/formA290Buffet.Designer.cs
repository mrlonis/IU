namespace A290FinalProject
{
    partial class formA290Buffet
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
            this.openFileDialogSelectPicture = new System.Windows.Forms.OpenFileDialog();
            this.buttonSelectPicture = new System.Windows.Forms.Button();
            this.buttonDrawBorder = new System.Windows.Forms.Button();
            this.buttonEnlarge = new System.Windows.Forms.Button();
            this.buttonShrink = new System.Windows.Forms.Button();
            this.pictureBoxShowPicture = new System.Windows.Forms.PictureBox();
            this.labelX = new System.Windows.Forms.Label();
            this.labelY = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxShowPicture)).BeginInit();
            this.SuspendLayout();
            // 
            // buttonClose
            // 
            this.buttonClose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonClose.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonClose.FlatAppearance.BorderSize = 0;
            this.buttonClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonClose.Location = new System.Drawing.Point(384, 54);
            this.buttonClose.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.buttonClose.Name = "buttonClose";
            this.buttonClose.Size = new System.Drawing.Size(116, 30);
            this.buttonClose.TabIndex = 0;
            this.buttonClose.Text = "Close";
            this.buttonClose.UseVisualStyleBackColor = false;
            this.buttonClose.Click += new System.EventHandler(this.buttonClose_Click);
            this.buttonClose.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.buttonClose_KeyPress);
            // 
            // openFileDialogSelectPicture
            // 
            this.openFileDialogSelectPicture.Filter = "Image files (*.jpg, *.jpeg, *.jpe, *.jfif, *.png) | *.jpg; *.jpeg; *.jpe; *.jfif;" +
    " *.png\"";
            // 
            // buttonSelectPicture
            // 
            this.buttonSelectPicture.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonSelectPicture.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonSelectPicture.FlatAppearance.BorderSize = 0;
            this.buttonSelectPicture.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonSelectPicture.Location = new System.Drawing.Point(384, 14);
            this.buttonSelectPicture.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.buttonSelectPicture.Name = "buttonSelectPicture";
            this.buttonSelectPicture.Size = new System.Drawing.Size(116, 30);
            this.buttonSelectPicture.TabIndex = 1;
            this.buttonSelectPicture.Text = "Select Picture";
            this.buttonSelectPicture.UseVisualStyleBackColor = false;
            this.buttonSelectPicture.Click += new System.EventHandler(this.buttonSelectPicture_Click);
            // 
            // buttonDrawBorder
            // 
            this.buttonDrawBorder.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonDrawBorder.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonDrawBorder.FlatAppearance.BorderSize = 0;
            this.buttonDrawBorder.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonDrawBorder.Location = new System.Drawing.Point(384, 94);
            this.buttonDrawBorder.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.buttonDrawBorder.Name = "buttonDrawBorder";
            this.buttonDrawBorder.Size = new System.Drawing.Size(116, 30);
            this.buttonDrawBorder.TabIndex = 2;
            this.buttonDrawBorder.Text = "Draw Border";
            this.buttonDrawBorder.UseVisualStyleBackColor = false;
            this.buttonDrawBorder.Click += new System.EventHandler(this.buttonDrawBorder_Click);
            // 
            // buttonEnlarge
            // 
            this.buttonEnlarge.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonEnlarge.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonEnlarge.FlatAppearance.BorderSize = 0;
            this.buttonEnlarge.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonEnlarge.Location = new System.Drawing.Point(384, 134);
            this.buttonEnlarge.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.buttonEnlarge.Name = "buttonEnlarge";
            this.buttonEnlarge.Size = new System.Drawing.Size(116, 30);
            this.buttonEnlarge.TabIndex = 3;
            this.buttonEnlarge.Text = "Enlarge";
            this.buttonEnlarge.UseVisualStyleBackColor = false;
            this.buttonEnlarge.Click += new System.EventHandler(this.buttonEnlarge_Click);
            // 
            // buttonShrink
            // 
            this.buttonShrink.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonShrink.BackColor = System.Drawing.SystemColors.ControlLight;
            this.buttonShrink.FlatAppearance.BorderSize = 0;
            this.buttonShrink.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonShrink.Location = new System.Drawing.Point(384, 174);
            this.buttonShrink.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.buttonShrink.Name = "buttonShrink";
            this.buttonShrink.Size = new System.Drawing.Size(116, 30);
            this.buttonShrink.TabIndex = 4;
            this.buttonShrink.Text = "Shrink";
            this.buttonShrink.UseVisualStyleBackColor = false;
            this.buttonShrink.Click += new System.EventHandler(this.buttonShrink_Click);
            // 
            // pictureBoxShowPicture
            // 
            this.pictureBoxShowPicture.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pictureBoxShowPicture.Location = new System.Drawing.Point(13, 13);
            this.pictureBoxShowPicture.Name = "pictureBoxShowPicture";
            this.pictureBoxShowPicture.Size = new System.Drawing.Size(364, 344);
            this.pictureBoxShowPicture.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBoxShowPicture.TabIndex = 5;
            this.pictureBoxShowPicture.TabStop = false;
            this.pictureBoxShowPicture.MouseLeave += new System.EventHandler(this.pictureBoxShowPicture_MouseLeave);
            this.pictureBoxShowPicture.MouseMove += new System.Windows.Forms.MouseEventHandler(this.pictureBoxShowPicture_MouseMove);
            // 
            // labelX
            // 
            this.labelX.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.labelX.AutoSize = true;
            this.labelX.Location = new System.Drawing.Point(384, 234);
            this.labelX.Name = "labelX";
            this.labelX.Size = new System.Drawing.Size(24, 20);
            this.labelX.TabIndex = 6;
            this.labelX.Text = "X:";
            // 
            // labelY
            // 
            this.labelY.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.labelY.AutoSize = true;
            this.labelY.Location = new System.Drawing.Point(384, 263);
            this.labelY.Name = "labelY";
            this.labelY.Size = new System.Drawing.Size(24, 20);
            this.labelY.TabIndex = 7;
            this.labelY.Text = "Y:";
            // 
            // formA290Buffet
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.RosyBrown;
            this.ClientSize = new System.Drawing.Size(513, 405);
            this.Controls.Add(this.labelY);
            this.Controls.Add(this.labelX);
            this.Controls.Add(this.pictureBoxShowPicture);
            this.Controls.Add(this.buttonShrink);
            this.Controls.Add(this.buttonEnlarge);
            this.Controls.Add(this.buttonDrawBorder);
            this.Controls.Add(this.buttonSelectPicture);
            this.Controls.Add(this.buttonClose);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "formA290Buffet";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "A290 Buffet";
            this.Load += new System.EventHandler(this.formA290Buffet_Load);
            this.Paint += new System.Windows.Forms.PaintEventHandler(this.formA290Buffet_Paint);
            this.Resize += new System.EventHandler(this.formA290Buffet_Resize);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxShowPicture)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonClose;
        private System.Windows.Forms.OpenFileDialog openFileDialogSelectPicture;
        private System.Windows.Forms.Button buttonSelectPicture;
        private System.Windows.Forms.Button buttonDrawBorder;
        private System.Windows.Forms.Button buttonEnlarge;
        private System.Windows.Forms.Button buttonShrink;
        private System.Windows.Forms.PictureBox pictureBoxShowPicture;
        private System.Windows.Forms.Label labelX;
        private System.Windows.Forms.Label labelY;
    }
}