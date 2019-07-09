Enable word wrap please

Important note which may cause issues on other computers:

On all my button click event handlers i have this line of code - 

/* Play Click Sound */
                System.Media.SoundPlayer player = new System.Media.SoundPlayer(@"C:\Windows\Media\Windows Startup.wav");
                player.Play();

The folder path referenced here is standard accross all windows machines (Windows 7, 8 , 10) HOWEVER, this assumes the central drive used is the C drive. If windows is not installed on the C drive you will need to edit this path. Should only require you changing the C to D or whatever your hard drive letter is.

Other issues:

I know you mentioned how "recycling" material from earlier in the clas would cause me to be graded harder on those parts of this project. However, my A290 buffet i chose not to include the collections or options page because i felt the collections page was a little unneccessary and didn't showcase anything spectacular and i removed the options page because i already have an options page connected to my main page. MY goal with this project was to create my own kind of "buffet" project to showcase multiple things in my code and in my presentation for when i put this on my resume or show any potential future employers. This is also why i didn't change my calculator form a whole lot because i felt it was already really nice, clean, and simple to use. I wanted to add more buttons or a way to swap the calculator buttons out but due to time constraints this was not a focus of mine. I hope you can accept those two forms for what they are and understand my reasoning.

It is also important to note that due to time constraints i only have a limited number of units to choose from in my unit converter combo boxes. I wanted to add more but was running out of time a kept what i had going for me. The combo boxes have a lot of options and i used a bunch of tree-d if cases to run the calculations so in order to test every possible type of conversion, a lot of time may be necessary. My conversion factors are usually to 4~5 decimal places (if needed) and a farily accurate. My conversion factors came from google.

ALSO:

My main page includes my senior picture which should display on the main page. I embedded this picture into the resource portion of the project, however, if this fails, the picture is located in my own "custom" resource folder which can be found in the project folder. Thank You For a Great Semester! I Enjoyed both of your 290 classes and opted to take next semester's 290 classes with you! You've shown me just how easy it is to do things i thought were going to be challenging to do! Coming from java where we had to use jFrames and even racket where we had to make a custom display for a game, i figured building UI based applications was some "black magic" as you call it but you taught me otherwise.