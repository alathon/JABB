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

/* Output related constants */
var

    const
        PROMPT_OFF      = 0;    // No prompt ever.
        PROMPT_ON       = 1;    // Standard 1-symbol prompt
        PROMPT_STATUS   = 2;    // Statusbar as prompt, always.

        COLOR_OFF       = 0;    // Color codes stripped
        COLOR_ON        = 1;    // Regular 16 colors
        COLOR_256       = 2;    // Xterm256 colors
        COLOR_CHAR      = "%";

