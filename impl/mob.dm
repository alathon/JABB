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

mob
	proc
		/* The mobs prompt. */
		getPrompt() {
			return "<Prompt here>";
		}

		/* Shorthand for sending text to the client, that owns the Outputter. */
		print(text, prompt = TRUE, color = TRUE) {
			if(client) client.out.print(text, prompt, color);
		}

		/* Called by movement commands. Should also be used to move NPCs in a direction. */
		attemptMove(dir) {
			switch(dir)
				if("north","south","east","west") {
					var/Room/curLoc = src.loc;

					if(curLoc.vars[dir] != null) {
						var/ok = Move(curLoc.vars[dir], "You move [dir].\n");
						if(ok) {
							var/Room/newLoc = src.loc;
							curLoc.print("[src.describe(null, CONTEXT_SHORT)] moves [dir].");
							newLoc.print("[src.describe(null, CONTEXT_SHORT)] enters from the [dir].");
						}
					} else {
						if(client) client.out.print("You can't go [dir] here.");
					}
				}
		}

	/*
	CONTEXT_LONG is for mob descriptions
	CONTEXT_SHORT is for rooms and the like.
	If you need just the name, then use atom.name
	*/
	describe(atom/target, context) {
		switch(context) {
			if(CONTEXT_LONG) {
				return src.desc;
			}

			if(CONTEXT_SHORT) {
				if(target == src) {
					return "You are here.";
				} else {
					return "[src.getName()] is here.";
				}
			}
		}
	}

	/*
	Main procedure used to physically move an atom. Redefined for mob
	to make sure the owner of the mob gets a message about moving in
	a direction, and takes a look at the room they enter.
	*/
	Move(Room/newLoc, msgSelf) {
		var/ok = ..(newLoc);
		if(ok && client && msgSelf) {
			client.out.print(text = msgSelf, prompt = FALSE);
			client.Command("look");
		}
	}

	/*
	This is called when a client attempts to connect to a mob. In other words,
	when someone logs in. For now, just move them to a room.
	*/
	Login()
		. = ..();
		sleep(1);
		Move(locate(/Room/start/login_room), "You enter the game.\n");