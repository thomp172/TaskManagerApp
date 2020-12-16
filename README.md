# Final Project - Task Manager

Allison Thompson\
1847513\
thomp172@mail.chapman.edu\
iOS App Development\
12/16/2020

### Purpose
Allow a user to manage tasks by defining a title, date, and notes and saving to a scrollable menu.

### I/O Description
A user will be able to select an app called "Task Manager" from their app list.  There is an app icon associated with the app, as well as a title image visible on the edit/create page.  First, a detail view will appear which allows a user to input new notes.  They may discard their state, or save to a scrollable collection view.  When going to the settings page, a user may toggle the option to sort by title or date, as well as toggle gray or color alerts.  When a task is past due, it will be colored red or gray, and when a task will be due within 24 hours it will be colored yellow or light gray.  When a user selects a note, the Notes page will update to the currently selected note.  They may then either edit the note or discard to return it to a create new notes page.

### Exceptions Thrown
No exceptions are handled within the app.

### Errors
If the sort switch is selected many times in a row without pausing in between, the app will crash.  I would fix it by adding an additional variable and check within the StorageHandler to buffer new clicks while the array is sorting.  I discovered this bug when trying to cause a crash by interacting with elements outside of the expected manner, so normal use will not trigger the crash.\
The entire screen moves up during the keyboard tap in a way that can make the UI title get cut off.  

### Notes
Designed using iPodTouch (7th Generation)

### References
* I used given files such as SwatchesViewController.swift and StorageHandler.swift from class and built upon them to fit the final project.  
* https://developer.apple.com/documentation/foundation/dateformatter
* https://stackoverflow.com/questions/39345101/swift-check-if-a-timestamp-is-yesterday-today-tomorrow-or-x-days-ago

### Program Files
1. ViewController.swift
3. EditViewController.swift
4. ColorHandler.swift
5. StorageHandler.swift
6. SwatchesViewController.swift
7. Main.storyboard
