// Barmaid NWScript based on David Gaider of BioWare's script
void main()
{
        int nUser = GetUserDefinedEventNumber();
        int nRandom = Random(4);      //This number should be approx number of NPC patrons
        object oCustomer = GetLocalObject(OBJECT_SELF, "CUSTOMER");
        object oBar = GetWaypointByTag("WP_Bar");     //This waypoint is where she gets drinks from
        object oBar2 = GetWaypointByTag("WP_Bar2");   //This waypoint she returns to rest after delivering drinks
        if (nUser == 1001) // This is a heartbeat event, every 6 sec
        {
                //SendMessageToAllDMs("Barmaid Heartbeat");   <-- I use this for debugging sometimes
                if (!GetIsObjectValid(oCustomer) && (GetLocalInt(OBJECT_SELF, "BARMAID_STATE") < 1))
                    {
                        // Randomly seek out up to the nRandom-nearest non-PC
                        oCustomer = GetNearestCreature (CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, nRandom);
                        //Make sure she's not going to ask the Barkeeper if he wants a drink
                        if (oCustomer != GetObjectByTag("Barkeeper") && oCustomer != OBJECT_SELF && GetIsObjectValid(oCustomer) )
                        {
                               // Move to Customer and ask what he/she wants
                                SetLocalInt (OBJECT_SELF, "BARMAID_STATE", 1);
                                SetLocalObject (OBJECT_SELF, "CUSTOMER", oCustomer);
                                ActionMoveToObject(oCustomer);
                                switch(Random(4))
                                {
                                    case 0:
                                        ActionSpeakString ("Can I get you something?");
                                        break;
                                    case 1:
                                        ActionSpeakString ("What'll it be?");
                                        break;
                                    case 2:
                                        ActionSpeakString ("Some refreshment for you and your friends?");
                                        break;
                                    case 3:
                                        ActionSpeakString ("Another round?");
                                        break;
                                 }
                                ActionWait(5.0); //Wait 5 secs.
                                // Move to the Bar to get the Drinks
                                ActionDoCommand (SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 2));
                                ActionMoveToObject(oBar);
                                switch(Random(4))
                                {
                                    case 0:
                                        ActionSpeakString ("I need two Dragon Breath Ales and a Ilipur Bitter.");
                                        break;
                                    case 1:
                                        ActionSpeakString ("A Mindflayer with a twist and two bottles of Prespur Rum.");
                                        break;
                                    case 2:
                                        ActionSpeakString ("They want a basket of Crispy Dwarf Ears");
                                        break;
                                    case 3:
                                        ActionSpeakString ("Three ales and a pony keg for the mistress there.");
                                        break;
                                 }
                                ActionWait(8.0);//Wait 8 secs.

                                // Move back to the customer and give him/her the drinks
                                ActionDoCommand (SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 3));
                                ActionMoveToObject (oCustomer);
                                switch(Random(4))
                                {
                                    case 0:
                                        ActionSpeakString ("Enjoy.");
                                        break;
                                    case 1:
                                        ActionSpeakString ("That'll be 5 platinum. I'm just kidding. 15 copper, please.");
                                        break;
                                    case 2:
                                        ActionSpeakString ("You look like you could use this.");
                                        break;
                                    case 3:
                                        ActionSpeakString ("Ice brewed in Icewind Dale, friend. Enjoy.");
                                        break;
                                 }
                                ActionWait(3.0);//Wait 3 secs.
                                ActionDoCommand (SetLocalObject(OBJECT_SELF, "CUSTOMER", OBJECT_INVALID));
                               // Move back to the other side of the bar to take a needed break
                               ActionMoveToObject(oBar2);
                               ActionWait(5.0);//Wait 5 secs.
                               switch(Random(4))
                                {
                                    case 0:
                                        ActionSpeakString ("Slow night tonight, eh?");
                                        break;
                                    case 1:
                                        ActionSpeakString ("My feet are killing me.");
                                        break;
                                    case 2:
                                        ActionSpeakString ("I can't live on these tips. Two copper?");
                                        break;
                                    case 3:
                                        ActionSpeakString ("He's kind of cute.");
                                        break;
                                 }
                               ActionWait(5.0);//Wait 5 secs.
                               ActionDoCommand (SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 0));
                       }
                }
        }
        if (nUser == 1004) // this is the OnDialogue event
        {
                // This is just in here so you can interrupt her if you want to talk to her
                SetLocalObject (OBJECT_SELF, "CUSTOMER", OBJECT_INVALID);
                SetLocalInt (OBJECT_SELF, "BARMAID_STATE", 0);
        }
}
