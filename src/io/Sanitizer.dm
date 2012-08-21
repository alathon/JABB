var/Sanitizer/Sanitizer = new();

Sanitizer
    var
        list/__sanitizeReplace = list("<" = "&lt;", ">" = "&gt;");
    proc
        sanitize(txt) {
            var/out = "";
            for(var/i = 1; i <= length(txt); i++) {
                var/char = copytext(txt, i, i+1);
                if(!(char in src.__sanitizeReplace)) {
                    out += char;
                } else {
                    out += src.__sanitizeReplace[char];
                }
            }
            return out;
        }
