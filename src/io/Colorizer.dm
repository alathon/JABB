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
Colorizer exposes the colorize(text, color_mode) procedure, which
will color text. 
*/

var/Colorizer/colorizer = new();

Colorizer
    New() {
        for(var/A in typesof(/sequence/telnet/) - /sequence/telnet)
            var/sequence/S = new A()
            telnet_sequences += S.character
            telnet_sequences[S.character] = S
    }
    var
        telnet_sequences = list();

    proc
        countTelnetColors(t) {
            var
                cur_seq;
                symbol = findtext(t, COLOR_CHAR);
                count = 0;

            while(symbol) {
                var/next = copytext(t, symbol+1, symbol+2);
                var/seq = __findTelnetSequence(next);
                if(seq) {
                    if(cur_seq != seq) {
                        count++;
                        cur_seq = seq;
                    }
                }

                symbol = findtext(t, COLOR_CHAR, symbol+2);
            }

            return count;
        }

        colorize(t, color_mode) {
            switch(color_mode) {
                if(COLOR_ON) {
                    return __telnetColor(t);
                }
                if(COLOR_OFF) {
                    return __telnetColor(t, TRUE);
                }
                if(COLOR_256) {
                    return __telnetColor(t);;
                } else {
                    return t;
                }
            }
        }

        __findTelnetSequence(i)
            if(i in telnet_sequences)
                var/sequence/S = telnet_sequences[i]
                return S.function()
            return null


        __telnetColor(t, strip = FALSE)
            var/tmp
                tlen = length(t)
                color_val = ""
                seq = ""
                start = 1
                next  = findtext(t, COLOR_CHAR)
                cur_color;

            if(!next) return t

            while(next)
                if(!(start == next)) // # at start is baad
                    . += copytext(t, start, next) // Copy up until color character.

                if(next == tlen)
                    break // End of string

                color_val = copytext(t, next+1, next+2)
                seq = __findTelnetSequence(color_val)
                if(!seq) {
                    . += "[COLOR_CHAR][color_val]";
                } else {
                    if(cur_color != seq && !strip) {
                        . += seq;
                        cur_color = seq;
                    }
                }
                start = next + 2
                next = findtext(t, COLOR_CHAR, start)

            if(next != tlen)
                . += copytext(t, start, 0)

sequence
    var/tmp
        name = ""
        character = ""

    proc
        function()
    telnet
        Black
            name = "black"
            character = "d"
            function() return "\[0;30m"
        Dark_Gray
            name = "dark gray"
            character = "z"
            function() return "\[1;30m"
        Gray
            name = "gray"
            character = "Z"
            function() return "\[0;37m"
        White
            name = "white"
            character = "w"
            function() return "\[1;37m"
        Cyan
            name = "cyan"
            character = "c"
            function() return "\[0;36m"
        Bright_Cyan
            name = "bright cyan"
            character = "C"
            function() return "\[1;36m"
        Magenta
            name = "magenta"
            character = "m"
            function() return "\[0;35m"
        Bright_Magenta
            name = "bright magenta"
            character = "M"
            function() return "\[1;35m"
        Red
            name = "red"
            character = "r"
            function() return "\[0;31m"
        Bright_Red
            name = "bright red"
            character = "R"
            function() return "\[1;31m"
        Blue
            name = "blue"
            character = "b"
            function() return "\[0;34m"
        Bright_Blue
            name = "bright blue"
            character = "B"
            function() return "\[1;34m"
        Green
            name = "green"
            character = "g"
            function() return "\[0;32m"
        Bright_Green
            name = "bright green"
            character = "G"
            function() return "\[1;32m"

        Yellow
            name = "yellow"
            character = "y"
            function() return "\[0;33m"
        Bright_Yellow
            name = "bright yellow"
            character = "Y"
            function() return "\[1;33m"
        Reset
            name = "reset"
            character = "n"
            function() return "\[0m"
        Clear
            // This one only works in telnet clients, and a few
            // mud clients.
            name = "clear"
            character = "clear"
            function() return "\[2J"
