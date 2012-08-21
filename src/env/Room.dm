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
        templateId;
        list/commands;
        RoomExit/north;
        RoomExit/south;
        RoomExit/east;
        RoomExit/west;

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
            if(istype(north, /RoomExit)) . += "North ";
            if(istype(south)) . += "South ";
            if(istype(east)) . += "East ";
            if(istype(west)) . += "West ";

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
            var/content = __getContentsFor(viewer);
            if(content != "") {
                . += "\n[content]";
            }
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
        what viewer can see. Lists mobs before objs, and
        excludes the viewer.
        */
        __getContentsFor(mob/viewer) {
            . = "";
            var/len = length(src.contents);
            for(var/mob/M in src.contents) {
                if(M == viewer) continue;
                var/desc = M.describe(viewer, CONTEXT_SHORT);
                if(desc) {
                    . += "[desc]\n";
                }
            }
            for(var/obj/O in src.contents) {
                var/desc = O.describe(viewer, CONTEXT_SHORT);
                if(desc) {
                    . += "[desc]\n";
                }
            }
        }

    describe(atom/target, context) {
        if(istype(target, /mob)) {
            return src.__getDescFor(target);
        }
    }

/*
A /RoomExit is a passage from a source room
to a destination room. The passage can optionally
be blocked (not yet implemented) by f.ex a door,
a magical barrier or something else.
*/
RoomExit
    New(Room/source, Room/destination) {
        src.source = source;
        src.destination = destination;
    }

    var
        Room/source;
        Room/destination;

    proc
        canUse(mob/user) {
            return TRUE;
        }
