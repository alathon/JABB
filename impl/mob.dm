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
		print(text, prompt = TRUE, color = TRUE) {
			if(client) client.out.print(text, prompt, color);
		}

		attemptMove(dir) {
			switch(dir)
				if("north","south","east","west") {
					var/Room/curLoc = src.loc;

					if(curLoc.vars[dir] != null) {
						var/ok = Move(curLoc.vars[dir], "You move [dir].");
						if(ok) {
							var/Room/newLoc = src.loc;
							curLoc.print("[src.getRoomDescription()] moves [dir].");
							newLoc.print("[src.getRoomDescription()] enters from the [dir].");
						}
					} else {
						if(client) client.out.print("You can't go [dir] here.");
					}
				}
		}

	Move(Room/newLoc, msgSelf) {
		var/ok = ..(newLoc);
		if(ok && client && msgSelf) {
			client.out.print(msgSelf);
			client.Command("look");
		}
	}

	Login()
		. = ..();
		sleep(1);
		Move(locate(/Room/start/login_room), "You enter the game.");