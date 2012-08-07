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

JABB *will* implement all of the following
-----------------------------
* Standard Room-based world with N/S/E/W exits.
* Basic commands often found on MUDs for interaction with the world.
* A simple login process where you select name, gender and class.
* Commands attached to rooms and to physical objects in the game.
* Simple player-customizable prompts.
* A basic notion of character attributes, levels and experience.
* Items, inventories, equipment.
* Respawn points, for respawning mobs / objs.
* Basic MUD-like concept of an 'area' or 'zone'.
* Basic saving and loading of areas and players, based on a simple flat-file
format.

JABB *might* implement the following:
-------------------------------------
* Commands for editing rooms.
* A tool to convert some of the existing .ARE files into the game.
* Instanced zones/rooms.
* The notion of death, leaving behind a corpse and respawning.
* A very basic, very untuned turn-based combat system.
* A simple little webserver daemon that can act as a form of RMI, to query via HTTP
about information in the game or do things (Such as list who's online, kick a player,
view logs, etc).

The libraries behind JABB
-------------------------
JABB uses the following libraries:

* <a href="http://www.byond.com/developer/Alathon/Alaparser">Alaparser</a> by me, a command parser. (On GitHub <a href="https://github.com/alathon/InputGrabber">here</a>)
* <a href="http://www.byond.com/developer/Alathon/InputGrabber">InputGrabber</a> by me, a library for querying for client input. (On GitHub <a href="https://github.com/alathon/Alaparser">here</a>)
* <a href="http://www.byond.com/developer/Stephen001/EventScheduling">EventScheduling</a> by Stephen001, an event scheduling library.
* <a href="http://www.byond.com/developer/Keeth/kText">kText</a> by Keeth, a text-processing library.

Because BYOND library dependency management isn't all that peachy on Linux (They auto-update on Windows),
I'll be whipping up a script to run which updates/downloads libraries declared by the project. Until then,
the above 4 libraries need to be downloaded manually first. This is a 1-click deal on Windows with BYOND installed,
and requires you to run the DreamDownload application with the above URLs, on nix.
