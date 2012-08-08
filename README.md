JABB
====

Just Another Barebones Base is a BYOND-based MUD
showcasing the use of a variety of different libraries that I've written for
BYOND. Together they provide a strong suite from which to create a MUD.

Why should you be using JABB?
-----------------------------
JABB is meant to be a demonstration, or a base from which you can create your own
MUD. It will primarily appeal to those looking to start from scratch,
those new to programming, or those who find the rapid development pace of writing
something in BYOND appealing.

What is BYOND?
--------------
BYOND is a free software suite, game community, programming language and VM.
Software written with it must run in the BYOND virtual-machine. While BYOND is
capable of creating graphical games as well, I believe its a very strong tool
for creating MUDs.

It is installable both on nix and Windows, and has been around for over 10 years
by now. The language, the website, the VM and the software are all still under
active development to this day.

The programming language itself is expressive, simple and easy
to work with. It reminds me a little of a mix between Java and Python. The VM
handles a lot of niceties for you (Such as networking and garbage collection),
leaving you to create stuff instead.

For information on what JABB plans to implement, the design decisions made, documentation
on the inner workings of JABB and so on, read the Google document published
<a href="https://docs.google.com/a/port7.dk/document/pub?id=131JPJ5tb88omzicJO3NjZBB3EZ-uG0vhT_RdsLfLLMw">here</a>

The libraries behind JABB
-------------------------
JABB uses the following libraries:

* <a href="http://www.byond.com/developer/Alathon/Alaparser">Alaparser</a> by me, a command parser. (On GitHub <a href="https://github.com/alathon/InputGrabber">here</a>)
* <a href="http://www.byond.com/developer/Alathon/InputGrabber">InputGrabber</a> by me, a library for querying for client input. (On GitHub <a href="https://github.com/alathon/Alaparser">here</a>)
* <a href="http://www.byond.com/developer/Stephen001/EventScheduling">EventScheduling</a> by Stephen001, an event scheduling library.
* <a href="http://www.byond.com/developer/Keeth/kText">kText</a> by Keeth, a text-processing library.

Because BYOND library dependency management isn't all that peachy on Linux (They auto-update on Windows),
its not very easy to download and update BYOND libraries on Linux right now. For now you can use the above links
to download the libraries from the BYOND website, which is a 1-click deal if you're on Windows.

If you're on Linux, you need to use the DreamDownload application that comes with the BYOND suite.

As soon as time permits, there may be a script to manage this automatically, and to update them.