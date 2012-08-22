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
        __colorMode = COLOR_ON;
        __promptConfig = PROMPT_OFF;
        __nlBeforePrompt = TRUE;
        __promptSent = FALSE;
        client/__source;

    proc
        __getStatusText() {
            return src.__source.getStatusText();
        }

        __shouldPrompt() {
            return (src.__promptConfig != PROMPT_OFF);
        }

        __sendPrompt() {
            src.__promptSent = TRUE;
            var/promptText = ">";

            if(src.__promptConfig == PROMPT_STATUS) {
                promptText = src.__getStatusText();
            }

            if(src.__nlBeforePrompt) promptText = "\n[promptText]\...";
            src.__send(promptText);
        }

        __sendStatus() {
            var/statusText = src.__getStatusText();

            src.__promptSent = TRUE;
            if(src.__nlBeforePrompt) statusText = "\n[statusText]\...";

            src.__send(statusText);
        }

        __color(t) {
            if(colorizer) return colorizer.colorize(t, src.__colorMode);
            else return t;
        }

        __send(t) {
            src.__source << t;
        }

        __isForcedStatus() {
            return FALSE;
        }

        setPromptConfig(configOpt) {
            src.__promptConfig = configOpt;
        }

        print(text, status = FALSE) {
            text = __color(text);

            if(src.__promptSent) {
                src.__promptSent = FALSE;
                text = "\n[text]";
            }

            src.__send(text);
            if(status || src.__isForcedStatus()) {
                src.__sendStatus();
            } else if(src.__shouldPrompt()) {
                src.__sendPrompt();
            }
        }
