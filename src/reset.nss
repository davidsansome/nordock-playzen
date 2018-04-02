//------------------------------------------------------------------------------
//
// reset
//
// Resets the server with 2 min warning (based on reset_add)
//
//------------------------------------------------------------------------------
//
// Created By:    Michael Tuffin [Grug]
// Created On:    11-03-2004
//
// Altered By:    Michael Tuffin [Grug]
// Altered On:    11-03-2004
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
// Version: 001 (11-Mar-2004)
// - Created and up and running
//
//------------------------------------------------------------------------------

// Returns a string comment to float over the player
string ExitingComment();
// Prepares the players for reset
void PreparePlayers();

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
   object oMod = GetModule();
   object oPC = GetFirstPC();
   while (GetIsObjectValid(oPC) == TRUE)
     {
     FloatingTextStringOnCreature("The server shall be reset in two minutes.", oPC);
     DelayCommand(60.0,  FloatingTextStringOnCreature("The server shall be reset in one minute.", oPC));
     oPC = GetNextPC();
     }

    DelayCommand(117.0, PreparePlayers());
    DelayCommand(120.0, StartNewModule(GetTag(oMod)));
}
//------------------------------------------------------------------------------
