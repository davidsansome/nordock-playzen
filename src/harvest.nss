//------------------------------------------------------------------------------
//
// harvest
//
// Harvests player details (Account name, Player name, IP, ability stats & gold)
// and then outputs them to all DMs. To be run from the DM console by entering
// 'runscript harvest'
//
//------------------------------------------------------------------------------
//
// Created By:    Michael Tuffin
// Created On:    22-Jun-2004
//
// Altered By:    Michael Tuffin
// Altered On:    22-Jun-2004
//
//------------------------------------------------------------------------------
//
// Known bugs/issues...
// - None
//
//------------------------------------------------------------------------------
//
// Changelog...
// Version: 000 (22-Jun-2004)
// - Created
//
//------------------------------------------------------------------------------

void main()
{

   object oPC = GetFirstPC();
   int iCount = 1;
   string sInit = "\nPlayer Details" +
                  "\n-------------------------------------------";
   string sMain;
   string sEnd = "\n-------------------------------------------";
   while (GetIsObjectValid(oPC) == TRUE)
   {
       string sSTR = IntToString(GetAbilityScore(oPC,ABILITY_STRENGTH));
       string sINT = IntToString(GetAbilityScore(oPC,ABILITY_INTELLIGENCE));
       string sDEX = IntToString(GetAbilityScore(oPC,ABILITY_DEXTERITY));
       string sWIS = IntToString(GetAbilityScore(oPC,ABILITY_WISDOM));
       string sCON = IntToString(GetAbilityScore(oPC,ABILITY_CONSTITUTION));
       string sCHA = IntToString(GetAbilityScore(oPC,ABILITY_CHARISMA));
       sMain = sMain +  "\n" + IntToString(iCount) + ") " + GetPCPlayerName(oPC) +
                        " || " + GetName(oPC) +
                        " || " + GetPCPublicCDKey(oPC) +
                        " || " + GetPCIPAddress(oPC) +
                        "\n" + sSTR +
                        " " + sDEX +
                        " " + sCON +
                        " " + sINT +
                        " " + sWIS +
                        " " + sCHA +
                        " || " + IntToString(GetGold(oPC)) +
                        "";
      iCount = iCount + 1;
      oPC = GetNextPC();
   }
   SendMessageToAllDMs(sInit + sMain + sEnd);
}

//------------------------------------------------------------------------------
