# Milestone Projects 13-15 - Faces
https://www.hackingwithswift.com/100/swiftui/77 and https://www.hackingwithswift.com/100/swiftui/78

This milestone project is in 2 parts:

+ Part1 allows adding a contact from a picture in the photo library, displaying a list of contacts, and displaying details of a contact
+ Part2 adds retrieving and storing location when the contact is added, displaying location on a map

#### Note

I also added a search bar for names and descriptions, as well as the ability to fully edit an existing record, including both replacing the photo and changing the location. 
To save the data, I used a simple JSON file written out to the documents directory. The app was written using the MVVM architecture.

#### Credits

Photos by [Naim Ahmed](https://unsplash.com/@naim_13), [Nathan Dumlao](https://unsplash.com/@nate_dumlao), 
[arnie chou](https://unsplash.com/@arniechou), [Imansyah Muhamad Putera](https://unsplash.com/@imansyahmp),
[Luiza Braun](https://unsplash.com/@luizabraun), [zohaib butt](https://unsplash.com/@zohaib1122),
[mari lezhava](https://unsplash.com/@marilezhava) on [Unsplash](https://unsplash.com/collections/9256441/faces-full-neutral-suitable-for-auto-gen?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)

## Challenges 

#### 1. Photo library
From [Hacking with Swift](https://www.hackingwithswift.com/guide/ios-swiftui/6/3/challenge):

>Have you ever been to a conference or a meetup, chatted to someone new, then realized seconds after you walk away that you’ve already forgotten their name? You’re not alone, and the app you’re building today will help solve that problem and others like it.
>
>Your goal is to build an app that asks users to import a picture from their photo library, then attach a name to whatever they imported. The full collection of pictures they name should be shown in a List, and tapping an item in the list should show a detail screen with a larger version of the picture.
>
>Breaking it down, you should:
>
>+ Use PhotosPicker to let users import a photo from their photo library.
>+ Detect when a new photo is imported, and immediately ask the user to name the photo.
>+ Save that name and photo somewhere safe.
>+ Show all names and photos in a list, sorted by name.
>+ Create a detail screen that shows a picture full size.
>+ Decide on a way to save all this data.
>
>Remember to import the user's photo as Data, so you can write it out easily.
>
>You can use SwiftData for this project if you want to, but it isn’t required – a simple JSON file written out to the documents directory is fine, although you will need to add a custom conformance to Comparable to get array sorting to work.

#### 2. MapKit
From [Hacking with Swift](https://www.hackingwithswift.com/100/swiftui/78)

>Yesterday you built a new app that imports photos from the user’s library, and hopefully you’re pleased with the finished product – or at least making great progress towards the finished product.
>
>But your boss has come in and demanded a new feature: when you’re viewing a picture that was imported, you should show a map with a pin that marks where they were when that picture was added. It might be on the same screen side by side with the photo, it might be shown or hidden using a segmented control, or perhaps it’s on a different screen – it’s down to you. Regardless, you know how to drop pins, and you also know how to use the center coordinate of map views, so the only thing left to figure out is how to get the user’s location to save alongside their text and image.

## Screenshots

![](https://github.com/kvend-ac/Faces/blob/main/screenshots/AddFaceView%201.png?raw=true)
![](https://github.com/kvend-ac/Faces/blob/main/screenshots/AddFaceView%202.png?raw=true)

![Main Screen](https://github.com/kvend-ac/Faces/blob/main/screenshots/Main%20screen%201.png?raw=true) 
![FaceView](https://github.com/kvend-ac/Faces/blob/main/screenshots/FaceView-Screenshot.png?raw=true)
![MapView](https://github.com/kvend-ac/Faces/blob/main/screenshots/MapView-Screenshot.png?raw=true)

![Context Menu](https://github.com/kvend-ac/Faces/blob/main/screenshots/Main%20screen%202.png?raw=true)
![EditFaceView](https://github.com/kvend-ac/Faces/blob/main/screenshots/EditFaceView-Screenshot.png?raw=true)

![Delete Face](https://github.com/kvend-ac/Faces/blob/main/screenshots/Main%20screen%203.png?raw=true)
![Edit Face](https://github.com/kvend-ac/Faces/blob/main/screenshots/Main%20screen%204.png?raw=true)
