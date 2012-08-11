Command
    quit
        format = "quit";

        command(mob/user) {
            user << "Goodbye! And thanks for testing out [world.name]!";
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
