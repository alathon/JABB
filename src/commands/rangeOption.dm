Option/postfix/range
    getListFromKey(mob/M) {
        . = ..(M);
        if(!length(.)) {
            switch(_key) {
                if("players") {
                    for(var/mob/other in world) {
                        if(other.client) . += other;
                    }
                }
            }
        }
    }
