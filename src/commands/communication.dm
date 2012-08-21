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

        command(mob/user, txt) {
            var/Room/R = user.loc;
            txt = Sanitizer.sanitize(txt);
            var/colorlessLen = length(txt) - (colorizer.countTelnetColors(txt) * 2);
            if(colorlessLen > 80) {
                user.print(text ="Thats way too much at once. Try saying less :)", prompt = TRUE);
                return;
            }


            R.print("[user.getName()] says, '[txt]#n'", user);
            user.print(text = "You say, '[txt]#n'", prompt = TRUE);
        }

    tell
        format = "tell; ~search(mob@players); any";

        command(mob/user, mob/target, txt) {
            txt = Sanitizer.sanitize(txt);
            var/colorlessLen = length(txt) - (colorizer.countTelnetColors(txt) * 2);
            if(colorlessLen > 80) {
                user.print(text = "Thats way too much at once. Try saying less :)", prompt = TRUE);
                return;
            }

            if(target == user) {
                user.print(text = "You tell yourself (Weirdo), '[txt]#n'", prompt = TRUE);
                return;
            }

            target.print("[user.getName()] tells you, '[txt]#n'");
            user.print(text = "You tell [target.getName()], '[txt]#n'", prompt = TRUE);
        }
