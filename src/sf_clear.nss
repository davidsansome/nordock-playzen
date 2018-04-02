//::///////////////////////////////////////////////
//:: FileName sf_clear
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/11/2002 1:45:17 PM
//:://////////////////////////////////////////////
#include "hc_inc"

void main()
{
    object oPC=GetPCSpeaker();
    int oHD=GetHitDice(oPC);
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    // Remove some gold from the player
    int sfcost;
    if (oHD<11)
        sfcost=oHD*oHD*oHD*15;
    else
        sfcost=oHD*oHD*150;
    TakeGoldFromCreature(sfcost, oPC, TRUE);

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(oPC, "SoulFrag_NOD");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    SetLocalInt(oPC,"SOULFRAG"+GetName(oPC)+GetPCPublicCDKey(oPC),FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
}
