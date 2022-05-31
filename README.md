# pranav_rathod_trail_project

This Project is an application for handheld devices that allows users to draw on the screen as well record their voice input, while logging all the interactions such as when the touch starts, updates, stops with their local position on screen as well as the time in milliseconds after the screen was loaded. The app also logs voice input after covering the data to base64 format.

Firebase's cloud firestore was used to store the data logged into two separate collections as "draw" and audio.

This application was tested on Virtual Emulator of Android Studio : Google Pixel 3 XL running API 30.

UI : 
Initial Screen : 
The initial screen, gives the user an option if they would like to draw or record voice.



# simpleDrawAndRecord
<img width="447" alt="Screen Shot 2022-05-31 at 4 44 39 PM" src="https://user-images.githubusercontent.com/79948560/171289524-9e8be693-9ff8-4316-a92f-f280cb57a041.png">

Option Draw : 
User gets the entire screen as a blank canvas along with a floating action button to record voice input.
<img width="465" alt="Screen Shot 2022-05-31 at 4 46 19 PM" src="https://user-images.githubusercontent.com/79948560/171289725-121789c0-b6d2-4c64-9fe8-fccf9bdd92e0.png">         <img width="445" alt="Screen Shot 2022-05-31 at 4 46 53 PM" src="https://user-images.githubusercontent.com/79948560/171289793-63ea57ca-4322-41aa-a578-e856bb5cf46e.png">

Option Record : 
The User can record their voice input which will be coverted and stored as base64 string.
<img width="429" alt="Screen Shot 2022-05-31 at 4 48 25 PM" src="https://user-images.githubusercontent.com/79948560/171289960-e8ce9b3d-07b0-4269-bb83-67d8ecc28560.png">
