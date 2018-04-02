//cohort_text
//Contains text string used by the Cohort system.
//
//Created September 5, 2002 by Edward Beck (0100010).
/*
    v1.0.6  - Added some strings for PW Cohort support. Not correctly used yet
              primarily due to laziness :(
*/

    //Battle Cries
    string DEFAULTDEITYNAME = "God"; //used when the cohort does not have a deity.

    string DEITYCRY1A = "By the name of "; // + cohort deity + DEITYCRYB
    string DEITYCRY1B = ", you shall perish!";
    string DEITYCRY2  = /*GetDeity() + */ ", look kindly upon your servant!";
    string DEITYCRY3  = /*GetDeity() + */ "comes to take you!";
    string DEITYCRY4A = "By ";
    string DEITYCRY4B = /*GetDeity() + */ ", you will not pass unchecked.";
    string DEITYCRY5  = /*GetDeity() + */ " willing, you'll soon be undone!";

    //Fighter class battle cries
    string FIGHTERCRY1 = "Take this, fool!";
    string FIGHTERCRY2 = "Say hello to my little friend!";
    string FIGHTERCRY3 = "Come here. Come here I say!";
    string FIGHTERCRY4 = "Meet cold steel!";
    string FIGHTERCRY5 = "To Arms!";
    string FIGHTERCRY6 = "Outstanding!";
    string FIGHTERCRY7 = "You CAN do better than this, can you not?";
    string FIGHTERCRY8 = "Embrace Death, and long for it!";
    string FIGHTERCRY9 = "Press forward and give no quarter!";

    //Rogue class battle cries
    string ROGUECRY1 = "I got a little present for you here!";
    string ROGUECRY2 = "Gothca!";
    string ROGUECRY3 = "Think twice before messing with me!";
    string ROGUECRY4 = "Silent and Deadly!";
    string ROGUECRY5 = "Your momma raised ya to become THIS?";
    string ROGUECRY6 = "How about a little knife in the back victim";
    string ROGUECRY7 = "You're an ugly little beastie, ain't ya?";
    string ROGUECRY8 = "Hey! Where's your manners!";
    string ROGUECRY9 = "Didn't see that one coming did you?";

    //Paladin class battle cries
    string PALADINCRY1 = "Fight on! For our victory is at hand!";
    string PALADINCRY2 = "Prepare yourself! Your time is near!";
    string PALADINCRY3 = "The light of justice shall overcome you!";
    string PALADINCRY4 = "Evil shall perish from the land!";
    string PALADINCRY5 = "Make peace with your god!";
    string PALADINCRY6 = "By the name of all that is holy, you shall perish!";
    string PALADINCRY7 = "The smell of evil permeates your presence!";
    string PALADINCRY8 = "Press forward and give no quarter!";


    //Cleric class battle cries
    string CLERICCRY1 = "This is not the time for healing!";
    string CLERICCRY2 = "You have chosen pain!";
    string CLERICCRY3 = "You attack us, only to die!";
    string CLERICCRY4 = "Must you chase destruction? Very well!";
    string CLERICCRY5 = "It does not please me to crush you like this.";
    string CLERICCRY6 = "Do not provoke me!";
    string CLERICCRY7 = "I am at my wit's end with you all!";
    string CLERICCRY8 = "Do you even know what you face?";
    string CLERICCRY9 = "Prepare yourself! Your time is near!";

    //Druid class battle cries
    string DRUIDCRY1 = "Nature will have vengeance upon you now!";
    string DRUIDCRY2 = "What is your grievance? Begone!";
    string DRUIDCRY3 = "I won't allow you to harm anyone else!";
    string DRUIDCRY4 = "Retreat or feel my wrath!";
    string DRUIDCRY5 = "I am nature's weapon.";
    string DRUIDCRY6 = "Destroyer of all that is green, you shall die!";

    //Wizard & Sorceror class battle cries
    string SPELLCASTERCRY1 = "You face a mage of considerable power!";
    string SPELLCASTERCRY2 = "I find your resistance illogical.";
    string SPELLCASTERCRY3 = "I bind the powers of the very Planes!";
    string SPELLCASTERCRY4 = "Fighting for now, and research for later.";
    string SPELLCASTERCRY5 = "Sad to destroy a fine specimen such as yourself.";
    string SPELLCASTERCRY6 = "Your chances of success are dwindling.";
    string SPELLCASTERCRY7 = "These fools deserve no less.";
    string SPELLCASTERCRY8 = "Now you are making me lose my patience.";
    string SPELLCASTERCRY9 = "Do or Do Not, there is no try.";
    string SPELLCASTERCRY10 = "Strike me down now and I shall become more powerful than you could ever imagine!";

    //Do not Attack mode, question player:
    string COHORTASKATTACK = "Should I attack?";
    string FAMILIARASKATTACK = "Be careful! Let me know if I should attack!";
    string COMPANIONASKATTACK = /*GetName() + */ " is waiting for you to give the command to attack.";
    string CONTROLLEDASKATTACK = /*GetName() + */ " patiently awaits your command to attack.";

    //Encounter
    string ENCOUNTER1 = "Don't make me laugh!";
    string ENCOUNTER2 = "We'll best them yet!";
    string ENCOUNTER3 = "Watch out for this one!";
    string ENCOUNTER4 = "Gods help us!";

    string SWITCHTOMELEE = "I'm switching to my melee weapon for now!";
    string SWITCHTORANGE = "I'm switching back to my missile weapon!";

    //Familiar runs
    string FAMRUNAWAY1 = "Time for me to get out of here!";
    string FAMRUNAWAY2 = "Eeeeek!";
    string FAMRUNAWAY3 = "Make way, make way!";
    string FAMRUNAWAY4 = "I'll be back!";

    string TRAPPED = "It's trapped!";
    string BASHLOCK = "I can't pick it, so I'll bash it!";

    //Entered follow mode
    string COHORTFOLLOW = "I will follow but not attack our enemies until you tell me otherwise.";
    string FAMILIARFOLLOW = "I will be happy to follow you, avoiding combat until you tell me otherwise!";
    string COMPANIONFOLLOW = /*GetName() + */ " understands that it should follow, waiting for your command to attack.";
    string CONTROLLEDFOLLOW = /*GetName() + */ " will now follow you, and be peaceful until told otherwise.";

    //Equipping strings
    string NOWEQUIPPING = "Now attempting to equip: ";
    string NOCLOTHES = "I have no clothes to wear!";
    string ARMORSTR = "piece of armor";
    string BOOTSSTR = "pair of boots";
    string CLOAKSTR = "cloak";
    string BRACERSTR = "handwear";
    string HELMETSTR = "helmet";
    string BELTSTR = "belt";
    string RINGSTR = "ring";
    string TORCHSTR = "torch";
    string TOOMANYRINGS = "You've given me more than two rings to wear.";

    //Rez Feedback
    string SPELLSTR = "spell";
    string SCROLLSTR = "scroll";
    string REZSTR = "Resurrection";
    string RAISESTR = "Raise Dead";
    string PCCSTR = "PC Cleric";
    string NPCCSTR = "NPC Cleric";

    string REZFEEDBACK1 = "I will attempt to bring this poor soul back.";
    string REZFEEDBACK2 = "I am attempting to cast " + REZSTR + " (" + SCROLLSTR + ") upon your Death Corpse";
    string REZFEEDBACK3 = "I am attempting to cast " + RAISESTR + " (" + SCROLLSTR + ") upon your Death Corpse";
    string REZFEEDBACK4 = "I am attempting to cast " + REZSTR + " (" + SPELLSTR + ") upon your Death Corpse";
    string REZFEEDBACK5 = "I am attempting to cast " + RAISESTR + " (" + SPELLSTR + ") upon your Death Corpse";
    string REZFEEDBACK6 = "I see a " + SCROLLSTR + " on the floor!";
    string REZFEEDBACK7 = "I found a " + REZSTR + " " + SCROLLSTR + " on the floor.";
    string REZFEEDBACK8 = "I found a " + RAISESTR + " " + SCROLLSTR + " on the floor.";
    string REZFEEDBACK9 = "Ah-hah! I have found a " + SCROLLSTR + "!";
    string REZFEEDBACK10 = "I have found a " + REZSTR + " " + SCROLLSTR + " on your body.";
    string REZFEEDBACK11 = "I have found a " + RAISESTR + " " + SCROLLSTR + " on your body.";
    string REZFEEDBACK12 = "There's nothing for it. I'm going to have to lug this corpse back to town.";
    string REZFEEDBACK13 = "I have managed to pick up your corpse, I'm now going to find help.";
    string REZFEEDBACK14 = "I cannot lift your carcass.";
    string REZFEEDBACK15 = "Help me please!!! My master is dead! Can you help me???";
    string REZFEEDBACK16 = "I have found a " + PCCSTR + " who may be able to help.";
    string REZFEEDBACK17 = "I have found a " + NPCCSTR + " who may be able to help.";
    string REZFEEDBACK18 = "I'm stuck!";
    string REZFEEDBACK19 = "I'm at ";
    string REZFEEDBACK19a = ", and I'm travelling too ";
    string REZFEEDBACK20 = "I've been waiting six*";
    string REZFEEDBACK21 = " seconds.";
    string REZFEEDBACK22 = " is wasting my time.";

    string REZFEEDBACKNPCONLY = "You must cast this " + SPELLSTR + " on the corpse, the token may be activated on a " + NPCCSTR + " only.";
    string REZFEEDBACKNOTPOWERFUL = " is not powerful enough to help you.";
    string REZFEEDBACKNOTALIGN = " is not the same alignment as you.";
    string REZFEEDBACKNOTENOUGH = " informs me that I do not have enough money. The minimum cost is ";
    string REZFEEDBACKCLERICACCEPT = " has accepted my donation of ";

    string REZFEEDBACK23 = "I am unable to help this poor soul.";
    string REZFEEDBACK24 = "Please can you spare some coin, my master is dead!";
    string REZFEEDBACK25 = "I have spied someone who appears to have enough coin to help you.";

    //Persistent Cohort Strings
    string PWC_INITDEAD1 = "Your cohort ";
    string PWC_INITDEAD2 = " is residing in the Fugue Plane.";

    string PWC_INITALIVE1 = "Your cohort ";
    string PWC_INITALIVE2 = " has rejoined your cause.";
