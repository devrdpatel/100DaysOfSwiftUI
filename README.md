# 100DaysOfSwiftUI
These are all the projects I created while following Paul Hudson's 100 Days of SwiftUI course. The course spreads 19 projects + 7 challenge projects over 100 days, where each day takes about 1-2 hours to complete. The projects in this repo are almost the same as those in the course with two exceptions: challenge features and challenge projects.

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
The full project list shown in the same order they are taught in the course. Projects listed as "Technique Projects" are not actual apps but rather projects where the course introduced more advanced techniques for a specific topic
- [WeSplit](#wesplit) -- Project 1
- [LengthConverter](#lengthconverter) -- Challenge Project 1
- [GuessTheFlag](#guess-the-flag) -- Project 2
- ViewsAndModifiers -- Project 3 (Not listed here)
- [RockPaperScissors](#rock-paper-scissors) -- Challenge Project 2
- [BetterRest](#better-rest) -- Project 4
- [WordScramble](#wordscramble) -- Project 5
- Animation -- Project 6 (Technique project for more advanced animations)
- [MultiplicationGame](#multiplication-game) ==-- Challenge Project 3
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
- [SnowSeeker](#snow-seeker) -- Project 19

### WeSplit
An app that calculates how much each person should pay when splitting a check, including the tip percentage to add. 
- Used @State variables binded to textfields to get user input and show the final price to split

### LengthConverter
Converts given units to a variety of other unit options with conversion categories of mass, distance, time, and temperature.
- Conversions are done using Swift's Measurement type which allows for less error prone conversion calculations

### Guess The Flag
A mini game that shows 3 countries' flags at a time and continues to ask questions until the game ends, at which point the final score is revealed.
- Alerts are used to display result of each quesiton and final score
- Custom flag buttons created with different animations for correct/incorrect answers.

### Rock Paper Scissors
An interesting variation of rock paper scissors where instead of actually playing the game, the computer chooses a move and the player needs to choose a move based on whether they should lose or win against the computer.
- Alerts used to show question results and final score

### Better Rest
Predicts the time a user should go to sleep based on how long they want to sleep, when they want to wake up and how much coffee they have.
- Uses a CoreML model to predict sleep times (trained on data of when people went to sleep and the amount of coffee they had)
- Automatically creates new predictions as @State variables of user input change

### WordScramble
The user is given a word and must find words that can be created using some or all of the letters in the given word, following certain rules.
- Uses List View to show words user has already guessed
- Shows alerts for incorrect or invalid words
- UITextChecker is used to verify if user's answers are real words

### Multiplication Game
A classic multiplication times table game that helps users practice their math multiplication tables upto 12 x 12.
- Questions are randomized based on the times table range selected by the user

### iExpense
An app to keep track of expenses that the user adds. These expenses are separated into personal and business.
- @StateObject class is used to maintain expenses list across multiple screens
- Expenses data is saved to UserDefaults and loaded upon app launch, if available

### Moonshot
Perfect for space enthusiasts, this app displays information about each of the Apollo space missions, organized neatly into multiple screens of data.
- Mission and Astronaut JSON data is loaded from the Bundle using a generic Bundle-Decodable extension
- Users have the option to organize mission by List or Grid View
- The app utilizes multiple DetailViews and NavgationLinks to display the information

### iHabit
Similar to iExpense, this app tracks activities added by the user, giving them the option to increment activity count.
- Stores activities in UserDefaults and loads them on app launch

### CupcakeCorner

### Bookworm

### FriendFace

### Instafilter

### BucketList

### PhotoGallery

### HotProspects

### Flashzilla

### Dice Simulator

### SnowSeeker


## Note of Appreciation
This course by Paul Hudson is an amazing way to learn SwiftUI even for beginners with zero coding experience. After completing this course, I feel that I have a solid base knowledge of how the SwiftUI framework functions and am confident that I can learn more advanced SwiftUI concepts more easily as a result of this course.
