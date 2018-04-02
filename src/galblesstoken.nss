#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "TokenofPossession"))
        return FALSE;

    return TRUE;
}


void main()
{
    if (StartingConditional())
        {
        effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, GetPCSpeaker());
        object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "TokenofPossession");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        CreateItemOnObject("tokenofposses001", GetPCSpeaker(), 1);
        }
}
