void main()
{
    // Gets a random number and based on result pronounces you a winner or loser
    // On winning the sounds of clapping can be heard :)
    int nCurrent_gold = GetGold(GetPCSpeaker());
    if (nCurrent_gold < 5) {
        ActionSpeakString("Sorry, you don't have enough gold to play. Come back later", TALKVOLUME_TALK);
    }
    else {
        switch(Random(4))
        {
            case 0:
                ActionSpeakString ("Sorry, you lose", TALKVOLUME_TALK);
                TakeGoldFromCreature(5, GetPCSpeaker(), TRUE);
                break;
            case 1:
                ActionSpeakString("You are a winner!", TALKVOLUME_TALK);
                GiveGoldToCreature(GetPCSpeaker(), 15);
                PlaySound("as_pl_tavclap1");
                break;
            case 2:
                ActionSpeakString("Sorry, you lose", TALKVOLUME_TALK);
                TakeGoldFromCreature(5, GetPCSpeaker(), TRUE);
                break;
            case 3:
                ActionSpeakString("Sorry, you lose", TALKVOLUME_TALK);
                TakeGoldFromCreature(5, GetPCSpeaker(), TRUE);
                break;
        }
     }
}


