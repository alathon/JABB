JABB
====

Just Another Barebones Base is a BYOND-based (http://www.byond.com/) demo MUD
showcasing the use of a variety of different libraries that I've written for
BYOND, which together provide a strong suite from which to create a MUD and focus
on the design and content instead of the nitty-gritty.

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
