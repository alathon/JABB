/*

Copyright (C) 2012 Martin Gielsgaard Grünbaum

Permission is hereby granted, free of charge, to any person obtaining a copy of this software
and associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.

*/

/*
A Room is the basic container for mobs and objs on this MUD.
It can have a room to its north, south, east and west, and
can have special commands associated with it, which the player
can access when inside the room.
*/

Room
	parent_type = /area
	var
		list/commands;
		Room/north;
		Room/south;
		Room/east;
		Room/west;

	proc
		/*
		Returns a list of the Command objects associated
		with the Room
		*/
		getRoomCommands() {
			if(commands) return commands;
			else return list();
		}

		/*
		Prints a message out to the room, optionally
		taking a list of atoms not to show the message to.
		*/
		print(txt, list/exclude) {
			if(!exclude) exclude = list();
			else if(istype(exclude, /atom)) exclude = list(exclude);
			for(var/mob/M in contents - exclude) {
				if(M.client) M.client.out.print(txt);
			}
		}

		/*
		Returns a text string representing the exits that
		the mob viewer can see.
		*/
		__getExitsText(mob/viewer) {
			. = "#yExits:#z ";
			if(north && istype(north, /Room)) . += "North ";
			if(south && istype(south, /Room)) . += "South ";
			if(east && istype(east, /Room)) . += "East ";
			if(west && istype(west, /Room)) . += "West ";

			if(length(.) == length("#yExits:#z ")) return "#yExits:#z None#n";
			else return "[.]#n";
		}

		/*
		Rooms describe themself to a player by first describing itself,
		and then letting anything in the room describe itself to the player.
		This gives mobs and objs a chance to be invisible, or look different
		depending on the players perception.
		*/
		__getDescFor(mob/viewer) {
			. += __getRoomDesc(viewer);
			. += __getContentsFor(viewer);
		}

		/*
		Describes the room itself, followed by its exits.
		*/
		__getRoomDesc(mob/viewer) {
			. = "";
			. += "#z[src.name]#n\n";
			. += "[src.desc]\n";
			. += "[src.__getExitsText(viewer)]\n";
		}

		/*
		Describe the mobs and objs in the room, based on
		what viewer can see. Lists mobs before objs.
		*/
		__getContentsFor(mob/viewer) {
			. = "\n";
			for(var/mob/M in src.contents) {
				var/desc = M.getRoomDescription(viewer);
				if(desc)
					. += "[desc]\n";
			}
			for(var/obj/O in src.contents) {
				var/desc = O.getRoomDescription(viewer);
				if(desc)
					. += "[desc]\n";
			}
			. = copytext(., 1, -1);
		}

	New() {
		if(ispath(north)) north = locate(north);
		if(ispath(south)) south = locate(south);
		if(ispath(east)) east = locate(east);
		if(ispath(west)) west = locate(west);
	}

	/*
	Override describe, so that if a mob tries to get
	a description, the room describes itself to that mob.
	*/
	describe(A) {
		if(istype(A, /mob)) {
			var/mob/M = A;
			var/myDesc = __getDescFor(M);
			M.print(myDesc);
		}
	}