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
Every client needs an Outputter attached to them. Its basically a simple
datum responsible for sending output to its client source; it will take
care of sending it past a Colorizer first, and has an option to show or not
show a prompt to the player after the text.
*/

Outputter
    New(__source) {
        src.__source = __source;
    }

    var
        client/__source;

    proc

        __sendPrompt() {
        }

        __color(t) {
            if(colorizer) return colorizer.colorize(t, src.__source.client_type);
            else return t;
        }

        __send(t) {
            src.__source << t;
        }

        pprint(text, color = TRUE) {
            src.print(text, prompt = TRUE, color);
        }

        print(text, prompt = FALSE, color = TRUE) {
            if(colorizer != null && color) text = __color(text);
            src.__send(text);
            if(prompt) src.__sendPrompt();
        }

    DS
        __sendPrompt() {
            if(src.__source.getPrompt()) {
                src.__send("\n[src.__source.getPrompt()]");
            }
        }
        __color(t) {
            if(colorizer) return colorizer.colorize(t, CLIENT_DS);
            else return t;
        }

    Telnet
        var
            __nlAfter = TRUE;

        New(__source) {
            ..(__source);
        }

        __color(t) {
            if(colorizer) return colorizer.colorize(t, CLIENT_TELNET);
            else return t;
        }

        __sendPrompt() {
            if(src.__source.getPrompt()) {
                var/nl = src.__nlAfter ? "\n":"";
                src.__send("[src.__source.getPrompt()][nl]\...");
            }
        }
