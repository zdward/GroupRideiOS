# RPI_GroupRide

This repository contains/will contain the iOS and Android implementations of RPI GroUber, an application meant to make cheap transportation more accessible to RPI students.

The application acts as a social network. Students can make posts about an Uber/Lyft ride they intend to take (and at what time), notifying RPI students in their area. These notified students then have the option to join the Uber/Lyft group (a.k.a the GroupRide) and communicate with the individuals in the group.

Contributors:
Zachary Ward, Paul Lim, Kevin Kim, Farukh Saidmuratov, Alexis Joseph, Karen Mu

<br/><br/>

# ***A Guide to Creating Actions for Buttons in Xcode10 for those Who Have Never developed Apps*** #

### ***Preliminary Information:*** ###

You can create buttons by going over to the top right of Xcode IDE and clicking on the following button. ![alt text](https://i.stack.imgur.com/3J26u.png) <br/>(Image credit goes to https://stackoverflow.com/questions/50962797/where-did-the-object-library-go-in-xcode-10) <br/>

From there you scroll down until you see the "Button" object. Drag that object in the desired location in your view controller. <br/><img width="700" alt="button" src="https://user-images.githubusercontent.com/26397102/52537662-365c9880-2d37-11e9-9783-c07b2e4dd092.png"><br/>

### ***If this button was created in your first view controller, and you don't have any other view controllers in your project...*** ###

Click on the view controller that holds your button. Go over to the rightmost panel. <br/><img width="260" alt="rightmostpanel" src="https://user-images.githubusercontent.com/26397102/52537675-6015bf80-2d37-11e9-8d2a-fe6716222d8b.png"><br/>


If this panel isn't visible, be sure to toggle the right panel by using the buttons located on the top right of the window. <br/><img width="123" alt="toggle" src="https://user-images.githubusercontent.com/26397102/52537673-54c29400-2d37-11e9-890c-c25d09b74d9c.png" class="center"><br/>

Click the identity inspector which is the button that looks like a newspaper. This will open the idenity inspector tab 
<br/><img width="259" alt="identityinspector" src="https://user-images.githubusercontent.com/26397102/52537702-728ff900-2d37-11e9-9acf-b137fce086f0.png" class="center"><br/>

In this panel hover to the "class" dropdown menu underneath "Custom Class." Scroll to "ViewController" and select it. 
<br/><img width="260" alt="viewcontroller" src="https://user-images.githubusercontent.com/26397102/52537709-7face800-2d37-11e9-8660-acf0e2f17054.png" class="center"><br/>

After doing this, click the "Show Assistant Editor" toggle, which is the button that looks like a slanted venn diagram.<br/> <img width="127" alt="diagram" src="https://user-images.githubusercontent.com/26397102/52537713-8b001380-2d37-11e9-8ca4-936de968dace.png" class="center"><br/>

This will open up the viewcontroller next to your storyboard.

While holding the "control" key, click and drag your button to your "ViewController.swift" document to create a function that will control an action. 
<br/><img width="600" alt="creatraction" src="https://user-images.githubusercontent.com/26397102/52537717-97846c00-2d37-11e9-9ed1-d604983b8dac.png">
<img width="602" alt="actionfunction" src="https://user-images.githubusercontent.com/26397102/52537719-a9660f00-2d37-11e9-9e9d-594c1af2b416.png"><br/>

From there, you can specify any action you want. For example: send the user an on-screen message. 
<br/><img width="646" alt="message" src="https://user-images.githubusercontent.com/26397102/52537726-b71b9480-2d37-11e9-98ce-54b99e821bc1.png" class="center"><br/>


### ***If this was button was created in a view controller that is not the first view controller in your project...*** ###

The process of creating an action for a button not located in the first view controller in your project is very similiar. The only preliminary step is creating a cocoa touch class swift file. This can be done by clicking over to "File" in the top taskbar while in your Xcode project. Hover over to "File" and click on "New": 

<br/><img width="600" alt="screen shot 2019-02-22 at 4 23 51 pm" src="https://user-images.githubusercontent.com/26397102/53272158-7ec47080-36be-11e9-8732-a3f5fcc8a78e.png"><br/>

Once you click "New", be sure to select the "Cocoa Touch class" and no other source. 

<br/><img width="735" alt="screen shot 2019-02-22 at 4 26 22 pm" src="https://user-images.githubusercontent.com/26397102/53272202-a0bdf300-36be-11e9-8c4e-e249e611f407.png"><br/>

Name it a different name from your default view controller class, and click "create." This will create a file in your xcode10 project. In this example, our swift file is called "TestViewController2.swift":

<br/><img width="219" alt="screen shot 2019-02-22 at 4 28 33 pm" src="https://user-images.githubusercontent.com/26397102/53272325-f1355080-36be-11e9-9648-b65c130fceb5.png"><br/>

Now go over to your view controller and link the class to the through the identity inspector. This process mirrors the steps we followed in the default view controller outline above. Going forward, you can create action's by holding the control key and dragging it to your created view controller swift file. 
