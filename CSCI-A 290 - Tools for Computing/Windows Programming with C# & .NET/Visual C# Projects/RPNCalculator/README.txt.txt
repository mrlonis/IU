Enable Word Wrap

RPNCalculator.cs

I went with a vertical design for my calculator. I set the labels for each check box to the left of their associated text boxes to make it more obvious to the use the relationship the text boxes have. I feel the vertical design is a sleeker and more natural way to use a calculator like this. The operations are under the second number text box, but above the answer text box, as it follows the natural progression of calculation in the calculator. The controls are in a 2 x 4 layout in order to compact the controls in a neat way. However, i grouped the four basic operations in a 2x2 layout alongside another 2x2 layout containing the added controls because i felt it was more visually appealing. The bottom four buttons are placed in the very bottom because they are the least used controls in calculation (even the clear button is kind of optional if you are merely running multiple calculations back to back).

The buttons are all themed with a 'flat' style. I feel this helps give a modern look to the application. The form is also unsizeable because it helps my layout stay intact. I have all the anchors set to allow the form to resize properly but i feel it isn't necessary for the calculator design wise. Most calculators, especially on a phone or in real life are not sizeable anyway.

formHelp.cs

This form is another vertical design and lists all the buttons down from add to power. Each button is linked to the RPNCalculator form so that when the user clicks the button on the help form the calculation will be performed in the RPNCalculator form. Even if the second number is zero the form will display a message box explaining the error. I also made it so this form appears in the default windows location. Since the RPNCalculator form is set to appear center screen, this allows the help form to appear to the left of the parent form allowing the user to not only easily relate the meanings of the buttons (via the labels next to the button) to the buttons on the main form. I feel this allows for a very connected experience within the calculator, especially since the POW button isn't necessarilt intuitive.

formOptions.cs

I added this form as an extra feature. The colors in the group box are all set as very light colors to give a modern feel regardless of the color selected. I find standard colors like blue, green, red to be to bright and basic. Most phones are shifting to a very light colored feel. Even Google's android showcases a "material" color pallette and that's what i was going for. This form is centered in front of the parent form to make it clear the user can't do anything in the other forms while the options form is open.

I added a check box exit dialog because i know how to do it. It's also a nice feature.