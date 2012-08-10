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

Command
	say
		format = "say; any;"

		command(client/C, txt) {
			var/mob/M = C.getCharacter();
			var/Room/R = M.loc;
			R.print("[C] says, '[txt]'", M);
			C.out.print("You say, '[txt]'");
		}

	tell
		format = "tell; %search(client@clients); any";

		command(client/C, client/target, txt) {
			if(target == C) {
				C.out.print("You tell yourself (Weirdo), '[txt]'");
				return;
			}

			target.out.print("[C] tells you, '[txt]'");
			C.out.print("You tell [target], '[txt]'");
		}

	who
		format = "who";

		command(client/C) {
			. = "Who's online right now?\n";
			. += "<--------------->\n";
			for(var/client/other) {
				var/mob/M = other.getCharacter();
				. += "[M.getName()]\n";
			}
			. += "<--------------->\n";
			C.out.print(.);
		}

	look
		format = "~look; ?!at; ?~search(mob@loc)";

		command(client/C, at, mob/M) {
			if(!M) {
				if(at) {
					C.out.print("Look at what?");
					return;
				}

				var/mob/Char = C.getCharacter();
				if(istype(Char.loc, /Room)) {
					var/Room/R = Char.loc;
					R.describe(Char);
				}
			} else {
				M.describe(C);
			}
		}