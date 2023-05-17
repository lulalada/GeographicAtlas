# GeographicAtlas
GeographicAtlas for STRONG TEAM 
* link to the recorded video: https://drive.google.com/file/d/1kzGQLA1fs6ad3WuMr60FD6BwmEAkPi2n/view?usp=sharing

GeographicAtlas is an iOS app that provides information about countries around the world. It allows you to explore a list of 
countries with expandable cells, view detailed information about a selected country, and even receive push notifications with 
interesting facts about random countries. The app also includes unit test to ensure the accuracy of network calls.

# Features
* List of Countries: The app displays a list of countries with expandable cells. Each cell provides basic information about the country, 
  such as its name and capital.
* Detailed Country Information: When you tap on a country cell, you are directed to a new page that displays detailed information about 
  the selected country. This includes additional data such as area, capital coordinates currency used and so on.
* Capital Coordinates: Within the detailed country view, you can click on the coordinates label of the capital city. This action redirects 
  you to a webpage with more information about the capital.
* Push Notifications: The app sends push notifications with interesting facts about random countries. When you tap on a notification, it 
  redirects you to the detailed page of the country mentioned in the notification.
* Unit Test: The app includes unit test to ensure the accuracy and reliability of network calls made to fetch country data. 
 

# Requirements
* iOS 13.0 or later
* Xcode 12.0 or later
* Swift 5

# Installation
* Clone or download the GeographicAtlas repository.
* Open the project in Xcode.
* Build and run the app on a simulator or physical device.

# Usage
* Launch the app to view the list of countries.
* Expand or collapse the cells to see more or less information about each country.
* Tap on Learn More in country cell to view its detailed information.
* In the detailed view, click on the coordinates label to open a webpage about the capital city.
* Receive push notifications with interesting facts about random countries.
* Tap on a push notification to be redirected to the detailed view of the mentioned country.

# Acknowledgments
GeographicAtlas uses the Rest Countries API to fetch country data. To test the network call, one unit test was added
