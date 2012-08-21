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
        __nlBefore = TRUE;
        __promptSent = FALSE;
        client/__source;

    proc

        __sendPrompt() {
            src.__promptSent = TRUE;
        }

        __color(t) {
            if(colorizer) return colorizer.colorize(t, src.__source.client_type);
            else return t;
        }

        __send(t) {
            src.__source << t;
        }

        pprint(text, color = TRUE) {
            src.print(text, TRUE, color);
        }

        print(text, prompt = FALSE, color = TRUE) {
            if(colorizer != null && color) text = __color(text);

            if(src.__promptSent) {
                src.__promptSent = FALSE;
                text = "\n[text]";
            }

            src.__send(text);
            if(prompt) {
                text = "";
                if(src.__nlBefore) {
                    text = "\n";
                }
                text += src.__source.getPrompt();
                src.__send(text);
            }
        }

    DS
        __color(t) {
            if(colorizer) return colorizer.colorize(t, CLIENT_DS);
            else return t;
        }

    Telnet
        __color(t) {
            if(colorizer) return colorizer.colorize(t, CLIENT_TELNET);
            else return t;
        }
