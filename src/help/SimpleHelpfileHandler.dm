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

// A simple, flatfile solution to loading helpfiles.

/*
Format of helpfiles in flatfile DB:

TRIGGER
CATEGORY
Helpfile
contents
here
*/

SimpleHelpfileHandler
    parent_type = /HelpfileHandler

    readHelpfile(name) {
        return createHelpfile("[getHelpfileDir()]/[name].help");
    }

    readAllHelpfiles() {
        var/list/out = list();
        for(var/a in typesof(/Helpfile) - /Helpfile) {
            var/Helpfile/H = new a();
            out.Add(H);
        }

        var/path = getHelpfileDir() + "/";
        var/list/files = flist(path);
        for(var/f in files) {
            if(findtext(f, "/")) continue;
            var/Helpfile/H = createHelpfile(path + f);
            if(H) out.Add(H);
        }
        return out;
    }

    proc
        getHelpfileDir() { return "./helpfiles"; }

        createHelpfile(uri) {
            var/text = file2text(uri);
            var/Helpfile/H = src.parseText(text);
            return H;
        }

        parseText(text) {
            var/Helpfile/H = new();
            var/list/tokens = __textToList(text, "\n");
            H.trigger = tokens[1];
            H.category = tokens[2];
            H.description = __listToText(tokens.Copy(3), "\n");
            return H;
        }
