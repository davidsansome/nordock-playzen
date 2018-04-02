//::///////////////////////////////////////////////
//:: FileName sf_chekgold2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/11/2002 1:41:21 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC=GetPCSpeaker();
    int oHD=GetHitDice(oPC);
     int sfcost;
    if (oHD<11)
        sfcost=oHD*oHD*oHD*15;
    else
        sfcost=oHD*oHD*150;
    if (GetGold(oPC)>=sfcost)
        return TRUE;
    else
        return FALSE;
}
