//::///////////////////////////////////////////////
//:: FileName sf_donateamount
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/11/2002 1:36:16 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    int oHD = GetHitDice(GetPCSpeaker());
    object oPC = GetPCSpeaker();
    int sfcost;
    if (oHD<11)
        sfcost=oHD*oHD*oHD*15;
    else
        sfcost=oHD*oHD*150;
    SetCustomToken(6000,IntToString(sfcost));
    return TRUE;
}
