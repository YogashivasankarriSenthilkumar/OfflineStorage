Objective:
The Offline Files App allows users to create, manage, and organize folders with the ability to add files and photos. It leverages Core Data to persist folder and file structures locally. Users can mark folders as favorites, assign colors to folders, and sort folders by creation date or name. 

Features
Create Folders:
Users can create new folders with a custom name and color. Each folder can be marked as a favorite for quick access.

Display Folder List:
The app displays a list of all folders created by the user, showing their name, color, and favorite status.

Add Files & Photos to Folders:
Users can add files and photos to each folder. These files can be local files (documents, images, etc.), and they are stored under the respective folder.

Core Data Persistence:
The app uses Core Data for persistent storage of folders and files. Each folder will have a name, color, favorite status, and a collection of files or photos associated with it.

Favorite Folders:
Folders can be marked as "favorites", allowing users to easily identify and access them.

Assign Colors to Folders:
Each folder can have a custom color to help visually organize folders. The user can choose from a range of colors.

Sorting Folders:
Users can sort the folder list by:

Creation Date: Sort folders by when they were created.
Name: Sort folders alphabetically by name. 

Installation & Setup
Prerequisites:
Xcode (latest version)
iOS 15.0+
Steps:
Clone the repository:
git clone https://github.com/YogashivasankarriSenthilkumar/OfflineStorage.git

Open the project in Xcode:

open OfflineStorage.xcodeproj
Run the project:

Select the target device (Simulator or real device).
Click the Run button to build and launch the app.
