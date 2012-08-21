Command
    prompt
        format = "prompt; !on|!off|!status";

        command(mob/user, mode) {
            switch(mode) {
                if("on") {
                    user.client.out.__promptConfig = user.client.out.PROMPT_ON;
                }
                if("off") {
                    user.client.out.__promptConfig = user.client.out.PROMPT_OFF;
                }
                if("status") {
                    user.client.out.__promptConfig = user.client.out.PROMPT_STATUS;
                }
            }

            user.print("You set your prompt-mode to: " + mode);
        }

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
                user.print(.);
                return;
            }

            var/Helpfile/H = helpfileHandler.getHelpfile(text);
            if(!H || !H.canRead(user)) {
                user.print("Sorry, no helpfile found for [text]");
                return;
            }

            user.print(H.read(user));
        }

    quit
        format = "quit";

        command(mob/user) {
            user.print("Goodbye! And thanks for testing out [world.name]!");
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
            user.print(.);
        }

    look
        format = "~look; ?!at; ?~search(mob@loc)";

        command(mob/user, at, mob/M) {
            var/desc;
            if(!M) {
                if(at) {
                    user.print("Look at what?");
                    return;
                }

                if(istype(user.loc, /Room)) {
                    var/Room/R = user.loc;
                    desc = R.describe(user);
                }
            } else {
                desc = M.describe(user, CONTEXT_LONG);
            }
            user.print(desc);
        }
