//------------------------------------------------------------------------------
//
// reset_add
//
// Accepts a vote to reset the server and if enough votes have been submitted,
// actiones the reset
//
//------------------------------------------------------------------------------
//
// Created By:    Nachos
// Created On:    04-12-2003
//
// Altered By:    Michael Tuffin [Grug]
// Altered On:    07-01-2004
//
//------------------------------------------------------------------------------
//
// Known bugs/issues...
// - Due to a change in the 1.61 patch module tag, title and filename must all
//   match for the reset to work
//
//------------------------------------------------------------------------------
//
// Changelog...
// Version: 001 (07-01-2004)
// - Added ExitingComment() function to generate a random comment
// - Added PreparePlayers() function to display the comment and fade to black
//
// Version: 000 (04-12-2003)
// - Created and up and running
//
//------------------------------------------------------------------------------

// Percentage of players that need to vote (ie: 1.0 = all, 0.5 = half)
const float GA_RESET_VOTES_NEEDED = 0.33;

//------------------------------------------------------------------------------

// Returns int with count of players on server
int ServerPlayerCount();
// Returns a string comment to float over the player
string ExitingComment();
// Prepares the players for reset
void PreparePlayers();

//------------------------------------------------------------------------------

int ServerPlayerCount()
{
   int nPCs = 0;
   object oPC = GetFirstPC();
   while (GetIsObjectValid(oPC) == TRUE)
   {
      nPCs = nPCs + 1;
      oPC = GetNextPC();
   }
   return nPCs;
}

//------------------------------------------------------------------------------

string ExitingComment()
{
    switch (d20())
    {
        case 1: return "Thank you come again...";
                break;
        case 2: return "Darkness engulfs the lands that surround you...";
                break;
        case 3: return "You feel dizzy, the world begins to spin...";
                break;
        case 4: return "Spider sense, tingling...";
                break;
        case 5: return "A change in the program...";
                break;
        case 6: return "This feels familiar...";
                break;
     }
     return "It is the time for rebirth...";
}

//------------------------------------------------------------------------------

void PreparePlayers()
{
   string sFloatyTextComment = ExitingComment();
   object oPC = GetFirstPC();
   while (GetIsObjectValid(oPC) == TRUE)
   {
      FloatingTextStringOnCreature(sFloatyTextComment, oPC, FALSE);
      DelayCommand(1.5, FadeToBlack(oPC, FADE_SPEED_SLOWEST));
      oPC = GetNextPC();
   }
}

//------------------------------------------------------------------------------

void main()
{
object oUser = GetPCSpeaker();
object oMod = GetModule();
int iVotes = GetLocalInt(oMod, "Reset");
if ((GetLocalInt(oMod, "ResetTimer")) && (ServerPlayerCount() > 7))
    {
       SetLocalInt(oMod, "Reset"+GetPCPublicCDKey(oUser), TRUE);
        SetLocalInt(oMod, "Reset", iVotes += 1);
        SpeakString("There are now "+IntToString(GetLocalInt(oMod, "Reset"))+ " of " + (FloatToString(((IntToFloat(ServerPlayerCount()) * GA_RESET_VOTES_NEEDED)), 4, 1)) + "reset votes needed on the Crystal of Unmaking.", TALKVOLUME_SHOUT);

        if (IntToFloat(GetLocalInt(oMod, "Reset")) > (IntToFloat(ServerPlayerCount()) * GA_RESET_VOTES_NEEDED)) //Edit this number to require more votes
        {
        SpeakString("The server shall be reset in two minutes.", TALKVOLUME_SHOUT);
        DelayCommand(60.0, SpeakString("The server shall be reset in one minute.", TALKVOLUME_SHOUT));
        DelayCommand(110.0, ExportAllCharacters());
        // DelayCommand(115.0, SpeakString("You see a vision of a crystal and within it an image of the world from far up in the sky. It starts to swirl and shake until the whole world is consumed by flames and darkness. Then suddenly there is a flash of bright light and everything is as it was...", TALKVOLUME_SHOUT));
        DelayCommand(117.0, PreparePlayers());
        DelayCommand(120.0, StartNewModule(GetTag(oMod)));
        }
    }
    else
    {
    FloatingTextStringOnCreature("The universe is too new to begin again", oUser, FALSE);
    }
}

//------------------------------------------------------------------------------
