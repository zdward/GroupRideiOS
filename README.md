# RPI_GroupRide

This repository contains/will contain the iOS and Android implementations of RPI GroUber, an application meant to make cheap transportation more accessible to RPI students.

The application acts as a social network. Students can make posts about an Uber/Lyft ride they intend to take (and at what time), notifying RPI students in their area. These notified students then have the option to join the Uber/Lyft group (a.k.a the GroupRide) and communicate with the individuals in the group.

Contributors:
Zachary Ward, Paul Lim, Kevin Kim, Farukh Saidmuratov, Alexis Joseph, Karen Mu

<br/><br/>

# ***A Guide to Creating Actions for Buttons in Xcode10 for those Who Have Never developed Apps*** #
## Authored by Farukh ##

### ***Preliminary Information:*** ###

You can create buttons by going over to the top right of Xcode IDE and clicking on the following button. ![alt text](https://i.stack.imgur.com/3J26u.png) (Image credit goes to https://stackoverflow.com/questions/50962797/where-did-the-object-library-go-in-xcode-10) 

From there you scroll down until you see the "Button" object which is be a blue "B". Drag that object in the desired location in your view controller. (Insert button screenshot here) 

### ***If this button was created in your first view controller, and you don't have any other view controllers in your project...*** ###

Click on the view controller that holds your button. Go over to the rightmost panel. (insert rightmost panel here) 
If this panel isn't visible, be sure to toggle the right panel by using the buttons located on the top right of the window. (insert toggle here)
Click the identity inspector which is the button that looks like a newspaper. This will open the idenity inspector tab (insert II screenshot) 

In this panel hover to the "class" dropdown menu underneath "Custom Class." Scroll to "ViewController" and select the class. 

After doing this, click the "Show Assistant Editor" toggle, which is the button that looks like a slanted venn diagram. (insert venn diagram here)
This will open up the viewcontroller next to your storyboard.

While holding the "Alt" key, click and drag your button to your "ViewController.swift" document to create a function that will control an action. 

From there, you can specify any action you want. For example: send the user an on-screen message. 

### ***If this was button was created in a view controller that is not the first view controller in your project...*** ###

TO BE COMPLETED
