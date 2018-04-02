//::///////////////////////////////////////////////
//:: Filename: questcheck
//:://////////////////////////////////////////////
/*
    Used with the runscript console command
    This script cycles through all players and
    tells the DMs if they have done the wings and
    miracle quest. 1 = Done, 0 = Not done
*/
//:://////////////////////////////////////////////
//:: Created By: Nakey
//:: Created On: 20-02-04
//:://////////////////////////////////////////////

// removed bool requirement - eaglec. jan 2005
// #include "apts_inc_ptok"
#include "rr_persist"

void main()
{
    object oPlayer = GetFirstPC();

    int iSangrolu = GetLocalInt(oPlayer, "sangroluskull");
    int iWings = GPI(oPlayer, "nMainQuest");

    string sHeader = "Quest Checker: Sangrolu, Wings"
                   + "\n-----------------------------------------";
    string sMain;

    while (GetIsObjectValid(oPlayer) == TRUE)
    {
        sMain = sMain + "\n" + GetName(oPlayer) + "[S: " + IntToString(iSangrolu) + " W: " + IntToString(iWings) + "]";
        oPlayer = GetNextPC();
    }
    SendMessageToAllDMs(sHeader + sMain);
}
