# 100DaysOfSwiftUI
These are all the projects I created while following Paul Hudson's 100 Days of SwiftUI course (during the summer of 2023). The course spreads 19 projects + 7 challenge projects over 100 days, where each day takes about 1-2 hours to complete. The projects in this repo are almost the same as those in the course with two exceptions: challenge features and challenge projects.

## Challenge features
At the end of each project, Hudson provides a few challenge features that we could implement in our projects but gives no coding solutions for them besides a few hints. On most of the later projects, this means that the implementation of the challenge features will be largely unique.

## Challenge projects
Every 3-4 projects, Hudson includes a "Challenge" Day where he provides a rough outline of the app that we're supposed to make alongside some tips. There are no coding solutions provided by the course for these challenge days either so each of these projects are almost entirely my own implementation. From the repo, these are the challenge day projects:
- LengthConverter - [Day 19](https://www.hackingwithswift.com/100/swiftui/19)
- RockPaperScissors - [Day 25](https://www.hackingwithswift.com/guide/ios-swiftui/2/3/challenge)
- MultiplicationGame - [Day 35](https://www.hackingwithswift.com/guide/ios-swiftui/3/3/challenge)
- iHabit - [Day 47](https://www.hackingwithswift.com/guide/ios-swiftui/4/3/challenge)
- FriendFace - [Day 60](https://www.hackingwithswift.com/guide/ios-swiftui/5/3/challenge) + [Day 61](https://www.hackingwithswift.com/100/swiftui/61)
- PhotoGallery - [Day 77](https://www.hackingwithswift.com/guide/ios-swiftui/6/3/challenge) + [Day 78](https://www.hackingwithswift.com/100/swiftui/78)
- DiceSimulator - [Day 95](https://www.hackingwithswift.com/guide/ios-swiftui/7/3/challenge)

## Full project list
The full project list shown in the same order they are taught in the course. Projects listed as "Technique Projects" are not actual apps but rather projects where the course introduced more advanced techniques for a specific topic. Click on individual projects to be directed to the main technical details for that specfiic project.
- [WeSplit](#wesplit) -- Project 1
- [LengthConverter](#lengthconverter) -- Challenge Project 1
- [GuessTheFlag](#guess-the-flag) -- Project 2
- ViewsAndModifiers -- Project 3 (Not listed here)
- [RockPaperScissors](#rock-paper-scissors) -- Challenge Project 2
- [BetterRest](#better-rest) -- Project 4
- [WordScramble](#wordscramble) -- Project 5
- Animation -- Project 6 (Technique project for more advanced animations)
- [MultiplicationGame](#multiplication-game) -- Challenge Project 3
- [iExpense](#iexpense) -- Project 7
- [Moonshot](#moonshot) -- Project 8
- Drawing -- Project 9 (Technique project for custom paths, shapes, animated drawings, drawing groups, etc)
- [iHabit](#ihabit) -- Challenge Project 4
- [CupcakeCorner](#cupcakecorner) -- Project 10
- [BookWorm](#bookworm) -- Project 11
- CoreDataProject -- Project 12 (Technique project for more advanced Core Data filtering, entity relationship/constraints)
- [FriendFace](#friendface) -- Challenge Project 5
- [Instafilter](#instafilter) -- Project 13
- [BucketList](#bucketlist) -- Project 14
- Accessibility -- Project 15 (Technique project that focused entirely on accessibility features like voice over, color/motion preferences, etc)
- [PhotoGallery](#photogallery) -- Challenge Project 6
- [HotProspects](#hotprospects) -- Project 16
- [Flashzilla](#flashzilla) -- Project 17
- LayoutAndGeometry -- Project 18 (Technique project for advanced custom alignment and Geometry Reader concepts)
- [DiceSimulator](#dice-simulator) -- Challenge Project 7
- [SnowSeeker](#snowseeker) -- Project 19

## WeSplit
An app that calculates how much each person should pay when splitting a check, including the tip percentage to add. 
- Used @State variables binded to textfields to get user input and show the final price to split
- Showed tip options and split count using Pickers

## LengthConverter
Converts given units to a variety of other unit options with conversion categories of mass, distance, time, and temperature.
- Conversions are done using Swift's Measurement type which allows for less error prone conversion calculations

## Guess The Flag
A mini game that shows 3 countries' flags at a time and continues to ask questions until the game ends, at which point the final score is revealed.
- Alerts are used to display result of each quesiton and final score
- Custom flag buttons created with different animations for correct/incorrect answers.

## Rock Paper Scissors
An interesting variation of rock paper scissors where instead of actually playing the game, the computer chooses a move and the player needs to choose a move based on whether they should lose or win against the computer.
- Alerts used to show question results and final score

## Better Rest
Predicts the time a user should go to sleep based on how long they want to sleep, when they want to wake up and how much coffee they have.
- Uses a CoreML model to predict sleep times (trained on data of when people went to sleep and the amount of coffee they had)
- Automatically creates new predictions as @State variables of user input change

## WordScramble
The user is given a word and must find words that can be created using some or all of the letters in the given word, following certain rules.
- Uses List View to show words user has already guessed
- Shows alerts for incorrect or invalid words
- UITextChecker is used to verify if user's answers are real words

## Multiplication Game
A classic multiplication times table game that helps users practice their math multiplication tables upto 12 x 12.
- Questions are randomized based on the times table range selected by the user

## iExpense
An app to keep track of expenses that the user adds. These expenses are separated into personal and business.
- @StateObject class is used to maintain expenses list across multiple screens
- Expenses data is saved to UserDefaults and loaded upon app launch, if available

## Moonshot
Perfect for space enthusiasts, this app displays information about each of the Apollo space missions, organized neatly into multiple screens of data.
- Mission and Astronaut JSON data is loaded from the Bundle using a generic Bundle-Decodable extension
- Users have the option to organize mission by List or Grid View
- The app utilizes multiple DetailViews and NavgationLinks to display the information

## iHabit
Similar to iExpense, this app tracks activities added by the user, giving them the option to increment activity count.
- Stores activities in UserDefaults and loads them on app launch

## CupcakeCorner
User can add custom cupcakes of their choosing to the cart and checkout after filling out the order details.
- Order details are sent to a server that echos it back to verify that data was sent and received successfully
- A photo is fetched asynchronously and displayed at checkout through a ProgressView

## Bookworm
Created for readers, this app lets users keep track of the books they've read by creating reviews for them.
- Books are saved and loaded using Core Data
- Custom 5-star rating View for publishing book reviews

## FriendFace
Allows users to view all of their friends and additional information for each friend with the tap of a button
- Data is fetched asyncrhonously with an API call upon app launch
- The sample users data is then decoded into swift types and saved to Core Data
- Information is displayed for easy access by app users and updated with every app launch

## Instafilter
Users can choose a photo from the photo library, add various filters/effects to their image, and then save that image to their photos library.
- Uses CoreImage to apply one of the many premade filters to the user's image with slider options for available effects
- Photos can be chosen from the photo library using the PHPickerView wrapped as a SwiftUI view
- Images are saved back in the photo library using UIKit functions adapted to SwiftUI.

## BucketList
Perfect for creating bucket lists, this app allows users to mark locations on the map that they want to visit, and shows them locations near the selected location.
- Utilizes MapKit to show locations on a map and retrieve location data
- Saves encrypted location data to FileManager's docuements directory
- Fetches nearby locations asyncrhonously using wikapedia's API
- Enabled FaceID and TouchID authenticaiton for supported devices

## PhotoGallery
An app where users can upload pictures with their current location and add a description about the photo.
- Photos can be uploaded from Photo Library or taken with the camera
- Current user location at time of photo upload is saved
- Photos are compressed and saved to the FileManager's documents directory

## HotProspects
The ideal app for meeting new people in a professional setting. Users can create a profile and turn it into a QR code that others can scan and save to their list of contacts within the app. 
- TabBar View that shows list of people by contacted, uncontacted or all
- Personal QR codes created with CoreImage's qrCodeGenerator CIFilter
- Contacts' data is saved to File Manager's documents directory
- Dependency used to scan QR codes

## Flashzilla
A classic study app where users can craete a set of flashcards and study them.
- Flashcards appear "stacked" in a ZStack
- Data is saved to File Manager's documents directory
- Custom Swipe Gestures created to animate card out of stack (also animates card color for correct/incorrect)
- Accessibiliity features added for voice over and differentiate without color

## Dice Simulator
Simulates dice rolls with a variety of die counts and types. Dice rolls are saved to the history for later reference.
- TabBar View used to show current simulation or dice roll history
- Dice rolls are animated using a Time publisher
- Simulated rolls are saved to File Manager's documents directory

## SnowSeeker
This app will help users find the perfect ski resort for them based on a variety of factors, providing users with detailed information on individual ski resorts.
- Adapted to support iPadOS and max-sized phone screens through sizeClasses
- Data is loaded from the Bundle using generic Bundle decoder
- Favorites are tracked and saved to UserDefaults
- Resorts are searchable and sortable, with favorited resorts always at the top

## Note of Appreciation
This course by Paul Hudson is an amazing way to learn SwiftUI even for beginners with zero coding experience. After completing this course, I feel that I have a solid base knowledge of how the SwiftUI framework functions and am confident that I can learn more advanced SwiftUI concepts more easily as a result of this course.
