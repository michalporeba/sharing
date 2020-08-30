# A PowerShell Tool - Demo
*A journey from a script to a published module*

PowerShell can be used - among many other things - to automate repetitive tasks in our daily jobs as system administrators. 
Often I have seen scripts which are useful, but fail to fully capitalise on the power of PowerShell. This tutorial 
is my attempt at demonstrating how to convert a typical PowerShell script into a published, reusable module, and how to 
harness the many additional features at the same time.  

## The scenario

Typically the PowerShell modules I use or create deal with things very dependant on environments in which they operate.
For example, I manage SQL Servers using [dbatools](https://dbatools.io)
 and monitor them using [dbachecks](https://dbachecks.readthedocs.io/en/latest/). IIS can be managed with 
[IISAdministration](https://blogs.iis.net/iisteam/introducing-iisadministration-in-the-powershell-gallery), 
and the Active Directory with [RSAT module](https://support.microsoft.com/en-gb/help/2693643/remote-server-administration-tools-rsat-for-windows-operating-systems) (Remote Server Administration Tools). 

While demos using any of the above modules (or many others) could be more real, and obvious, they tend to be very 
dependant on the environment in which they are executed and therefor are not very good to let you download and
and play with the examples. 

To solve this problem we will use local file system to pretend we perform some operations on servers in mulitple
requirements. A folder within a test directory will represent an environment, a group of servers, and individual files
will represent the servers. Perhaps a bit made up example, but it will work in any environment so it will be more universal. 

## Create a simple script

First, we need a scenario that simulates creating some form of utility script, perhaps for an administrator of some sort. 
The challenge is to create a scenario which is not dependant on local resources, so it can be tried out by anybody on any system. 

A simple scenario might be to check files (representing servers) in a folder (perhaps representing an environment). 
To make the usecase a bit more realistick, we will check if the file exists, whether it is empty, or if it is too long (over 3 lines). 
If it doesn't exist the fix will be to create it, if it is empty the fix is to put word "OK" into it, and if it is over 3 lines long
the fix is to remove everything but the last 3 lines from it. 

## Steps
- how typical solutions evolve 
- functions are better than scripts and simple dot sourcing can move things along nicely
- independent functions allow to use piping, filters and ogv
- help comments help
- code and data shouldn't mix
- splitting into multiple files (isn't it getting worse)
- creating a module
- publishing a module

- pipelines, tests and automation
- advanced features
...

take it a step further. can we contain blocks with checks for easy retesting after fixing?
