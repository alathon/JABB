LoginProcess
    var
        client/__user;

    proc
        __loadCharacter() {
            __user << "Loading is not supported yet. Sorry!";
            __go();
        }

        __getProperName(text) {
            return uppertext(copytext(text, 1, 2)) + lowertext(copytext(text, 2));

        }

        __newCharacter() {
            var/Question/login/create/charName/charNameQ = new(source = src.__user);
            var/Question/login/create/charGender/charGenderQ = new(source = src.__user);
            
            if(src.__user == null) del src; // Client disconnected in the meantime.
            
            var/charName = charNameQ.getValue();
            var/charGender = charGenderQ.getValue();
            if(charName == null || charGender == null) {
                del src.__user;
                del src;
            }

            var/mob/M = new();
            M.name = src.__getProperName(charName);
            M.gender = charGender;
            var/mob/Old = src.__user.mob;
            M.key = src.__user.key;
            del Old;
            M.Move(locate(/Room/start/login_room), "You enter the game.\n");
        }

        __go() {
            var/Question/login/loadOrCreate/first = new(source = src.__user);

            if(!src.__user) del src; // Client not there.

            if(first.getValue() == "load") {
                return src.__loadCharacter();
            } else if(first.getValue() == "create") {
                return src.__newCharacter();
            } else {
                src.__user.out.print("Come again! [first.getValue()]");
                del src.__user;
                return;
            }
        }

    New(client/user) {
        if(!user || !istype(user)) del src; // Client not there.

        src.__user = user;
        src.__go();
    }

Question/login
    loadOrCreate
        question = "Would you like to (#yL#n)oad a character or (#yC#n)reate a new one?";
        retryQuestion = "Would you like to (#yL#n)oad a character or (#yC#n)reate a new one?";
        tries = 3;

        getValue() {
            var/v = lowertext(__value);
            if(v == "l") return "load";
            else if(v == "c") return "create";
            return v;
        }

        __needRetry(v) {
            var/list/L = list("l","load","c","create");
            v = lowertext(v);
            return !(v in L);
        }

    create
        charName
            question = "What would you like to be called?";
            retryQuestion = "What would you like to be called?";
            tries = 3;

            __needRetry(v) {
                if(length(v) < 3) {
                    src.sendToClient(src.source, "Name must be over 3 characters.");
                    return TRUE;
                }

                for(var/a = 1 to length(v)) {
                    if(!__isAlpha(text2ascii(v, a))) {
                        src.sendToClient(src.source, "Name must only contain letters.");
                        return TRUE;
                    }
                }
                return FALSE;
            }

        charGender
            question = "Would you like to be #z(#yM#z)#nale or #z(#yF#z)#nemale?";
            retryQuestion = "Would you like to be #z(#yM#z)#nale or #z(#yF#z)#nemale?";
            tries = 3;


            getValue() {
                var/v = lowertext(__value);
                if(v == "m") return "male";
                else if(v == "f") return "female";
                return v;
            }

            __needRetry(v) {
                var/list/L = list("m","male","f","female");
                v = lowertext(v);
                return !(v in L);
            }
