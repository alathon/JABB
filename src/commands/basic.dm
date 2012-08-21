Command
    help
        format = "help; ?any";

        proc
            getHelpfiles() {
                var/list/files = helpfileHandler.getHelpfilesByCategory();
                for(var/a in files) {
                    var/list/helps = files[a];
                    . += "#z[a]#n:\n";
                    var/helpsLen = length(helps);
                    for(var/i = 1 to helpsLen) {
                        var/Helpfile/H = helps[i];
                        . += "[H.trigger][i < helpsLen ? ", ":""]";
                    }
                    . += "\n";
                }
            }

        command(mob/user, text) {
            if(!text) {
                . = "Type help 'helpfile' to get help on a topic.\n";
                . += "The following helpfiles are available:\n\n";
                . += getHelpfiles();
                user.print(text = ., prompt = TRUE);
                return;
            }

            var/Helpfile/H = helpfileHandler.getHelpfile(text);
            if(!H || !H.canRead(user)) {
                user.print(text = "Sorry, no helpfile found for [text]", prompt = TRUE);
                return;
            }

            user.print(H.read(user));
        }

    quit
        format = "quit";

        command(mob/user) {
            user.print(text = "Goodbye! And thanks for testing out [world.name]!", prompt = TRUE);
            del user;
        }

    who
        format = "who";

        command(mob/user) {
            . = kText.padText("#z[world.name]#n", 24, kText.PAD_BOTH, "-");
            . += "\n";
            var/playerCount = 0;
            for(var/client/other) {
                var/mob/M = other.getCharacter();
                . += "[M.getName()]\n";
                playerCount++;
            }
            . += kText.padText("#zPlayers on: #y[playerCount]#n", 26, kText.PAD_BOTH, "-");
            user.print(text = ., prompt = TRUE);
        }

    look
        format = "~look; ?!at; ?~search(mob@loc)";

        command(mob/user, at, mob/M) {
            var/desc;
            if(!M) {
                if(at) {
                    user.print(text = "Look at what?", prompt = TRUE);
                    return;
                }

                if(istype(user.loc, /Room)) {
                    var/Room/R = user.loc;
                    desc = R.describe(user);
                }
            } else {
                desc = M.describe(user, CONTEXT_LONG);
            }
            user.print(text = desc, prompt = TRUE);
        }
