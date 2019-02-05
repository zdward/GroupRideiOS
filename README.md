# RPI_GroupRide

This repository contains/will contain the iOS and Android implementations of RPI GroUber, an application meant to make cheap transportation more accessible to RPI students.

The application acts as a social network. Students can make posts about an Uber/Lyft ride they intend to take (and at what time), notifying RPI students in their area. These notified students then have the option to join the Uber/Lyft group (a.k.a the GroupRide) and communicate with the individuals in the group.

Contributors:
Zachary Ward, Paul Lim, Kevin Kim, Farukh Saidmuratov, Alexis Joseph, Karen Mu


Tutorial of how to set up Firebase:

1. Install cocoa pod :
- use in command line: sudo gem install cocoapods

2. Init pod file

3. inside pod file  below the last end write 
pod 'Firebase/Core'
pod 'Firebase'

4. In command line run, pod install 
    - Will add all the firebase 



If Build failed due to Could not build Objective-C module 'Firebase’:
1. Quit Xcode.
2. Delete project's temp files located at ~/Library/Developer/Xcode/DerivedData
3. Delete ProjectName.xcworkspace
4. Delete Podfile.lock file and Pods folder
5. Run pod install.
6. Open the newly created ProjectName.xcworkspace file and build and use THIS file to create and test your builds.


