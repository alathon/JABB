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


client
    New() {
        var/mob/login/l = new();
        l.key = src.key;
        __determineClientType();
        spawn() __enterGame();
    }

    /*
    A 'grabber' is an InputGrabber, from the Alathon.InputGrabber library.
    Basically, its a queue of questions, which will steal input first, before
    the Parser gets at it.
    */
    getGrabber() {
        return src.grabber;
    }

    /*
    This is the main entry-point for client input. The sole argument to Command() is
    what the user has sent to the MUD. From there, we either use it to answer a question
    or get parsed, for a potential command.
    */
    Command(T) {
        var/InputGrabber/grabber = src.getGrabber();
        if(grabber.isActive()) {
            grabber.receive(T);
        } else {
            var/list/extras = list();
            var/mob/char = src.getCharacter();
            if(istype(char, /Room)) {
                var/Room/R = char;
                extras = R.getRoomCommands();
            }

            var/ParserOutput/out = alaparser.parse(char, T, extras);
            if(!out.getMatchSuccess()) {
                src.out.pprint("Huh?");
            }
        }
    }

    var
        InputGrabber/grabber = new();
        client_type = CLIENT_TELNET;
        Outputter/out;

    proc
        /*
        Here we determine whether this is a linkdead client coming back,
        or whether this is a new connection that needs to be presented with
        login information.

        For now, we don't care about linkdeath, since its not implemented yet.
        */
        __enterGame() {
            new /LoginProcess(src);
        }


        __determineClientType() {
            if(!findtext(src.key, ".")) {
                client_type = CLIENT_DS
                out = new /Outputter/DS(src);
            } else {
                client_type = CLIENT_TELNET;
                out = new /Outputter/Telnet(src);
            }
        }

        getPrompt() {
            return mob.getPrompt();
        }

        getCharacter() {
            return mob;
        }
