/*

Copyright (C) 2012 Martin Gielsgaard Gr�nbaum

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

Outputter
	New(__source) {
		src.__source = __source;
	}

	var
		client/__source;
		Colorizer/__colorizer = new();

	proc
		__sendPrompt() {
		}

		__color(t) {
			return __colorizer.colorize(t, src.__source.client_type);
		}

		__send(t) {
			src.__source << t;
		}

		print(text, prompt = TRUE, color = TRUE) {
			if(__colorizer != null && color) text = __color(text);
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
			return __colorizer.colorize(t, CLIENT_DS);
		}

	Telnet
		__color(t) {
			return __colorizer.colorize(t, CLIENT_TELNET);
		}

		__sendPrompt() {
			if(src.__source.getPrompt()) {
				src.__send("\n[src.__source.getPrompt()]\...");
			}
		}