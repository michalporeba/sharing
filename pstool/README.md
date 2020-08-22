# PS Tool

How to go from a typical PowerShell script file to a reusable module?


## 1. Create a simple script

First, we need a scenario that simulates creating some form of utility script, perhaps for an administrator of some sort. 
The challenge is to create a scenario which is not dependant on local resources, so it can be tried out by anybody on any system. 

A simple scenario might be to check files (representing servers) in a folder (perhaps representing an environment). 
To make the usecase a bit more realistick, we will check if the file exists, whether it is empty, or if it is too long (over 3 lines). 
If it doesn't exist the fix will be to create it, if it is empty the fix is to put word "OK" into it, and if it is over 3 lines long
the fix is to remove everything but the last 3 lines from it. 


...

take it a step further. can we contain blocks with checks for easy retesting after fixing?