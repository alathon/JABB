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

var/list/reverseDirections = list(  "north" = "south",
                                    "south" = "north",
                                    "east" = "west",
                                    "west" = "east");

proc
    reverseDir(dir) {
        if(dir in reverseDirections) return reverseDirections[dir];
    }

mob
    proc
        /* Movement procedures for room and turf */
        MoveRoom(Room/R) {
            if(R.Enter(src)) {
                src.loc = R;
                R.Entered(src);
                return 1;
            } else {
                return 0;
            }
        }

        MoveTurf(turf/T) {
            CRASH("Not implemented yet.");
        }

        /* The mobs prompt. */
        getPrompt() {
            return "\<Prompt here\>";
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
                            curLoc.print("[src.getName()] moves [dir].");
                            newLoc.print("[src.getName()] enters from the [reverseDir(dir)].", src);
                        } else {
                            src.print("You were unable to go [dir].");
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
                if(src.desc) {
                    return src.desc;
                } else {
                    return "[src.getName()] has no description!";
                }
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
    Move(newLoc, msgSelf) {
        if(istype(newLoc, /RoomExit)) {
            var/RoomExit/exit = newLoc;
            if(!exit.canUse(src)) return 0;
            newLoc = exit.destination;
        }

        var/ok;
        if(istype(newLoc, /Room)) {
            ok = MoveRoom(newLoc);
        } else if(istype(newLoc, /turf)) {
            ok = MoveTurf(newLoc);
        }
        if(ok) {
            if(client && msgSelf) {
                client.out.print(text = msgSelf, prompt = FALSE);
                client.Command("look");
            }
        }
        return ok;
    }

    /*
    This makes sure to delete the mob when a player disconnects from it.
    And leave a goodbye message.

    This is not the way to go normally, but this is a quick n' dirty
    solution for us right now.
    */
    Logout() {
        var/Room/R = loc;
        if(istype(R)) {
            R.print("[src.getName()] leaves the game.", src);
        }
        del src;
    }

/* A mob prototype for players who're logging in. */
mob/login
