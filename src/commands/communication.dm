/*

Copyright (C) 2012 Martin Gielsgaard Gr�nbaum

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

        command(mob/user, txt) {
            var/Room/R = user.loc;
            R.print("[user.getName()] says, '[txt]'", user);
            user.print("You say, '[txt]'");
        }

    tell
        format = "tell; %search(mob@players); any";

        command(mob/user, mob/target, txt) {
            if(target == user) {
                user.print("You tell yourself (Weirdo), '[txt]'");
                return;
            }

            target.print("[user.getName()] tells you, '[txt]'");
            user.print("You tell [target.getName()], '[txt]'");
        }

    who
        format = "who";

        command(mob/user) {
            . = "Who's online right now?\n";
            . += "<--------------->\n";
            for(var/client/other) {
                var/mob/M = other.getCharacter();
                . += "[M.getName()]\n";
            }
            . += "<--------------->\n";
            user.print(.);
        }

    look
        format = "~look; ?!at; ?~search(mob@loc)";

        command(mob/user, at, mob/M) {
            var/desc;
            if(!M) {
                if(at) {
                    user.print("Look at what?");
                    return;
                }

                if(istype(user.loc, /Room)) {
                    var/Room/R = user.loc;
                    desc = R.describe(user);
                }
            } else {
                desc = M.describe(user, CONTEXT_LONG);
            }
            user.print(desc);
        }