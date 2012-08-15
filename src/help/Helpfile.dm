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
A helpfile is comprised of a trigger (which is a sentence that will match
the helpfile, in the 'help' Command), and a description. Helpfiles can be
restricted, by overriding the Helpfile.canRead(mob/viewer) procedure.
*/

Helpfile
    var
        // The keyword(s) that will match the helpfile
        trigger = "";
        description = "";
        category;

    proc
        read(mob/viewer) {
            . = "[kText.padText("#y[trigger]#n", 28, kText.PAD_BOTH, "-")]\n";
            . += "[description]\n";
            . += "[kText.padText("",24, kText.PAD_BOTH, "-")]";
        }

        matches(text) {
            text = lowertext(text);
            var/textLen = length(text);
            var/triggerLen = length(trigger);
            if(textLen > triggerLen) return FALSE;

            if(copytext(lowertext(trigger), 1, textLen+1) == text) return TRUE;
            return FALSE;
        }

        canRead(mob/viewer) { return TRUE; }
