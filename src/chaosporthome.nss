// Portal back to Haunted Caves...if character has a planar gem.


#include "nw_i0_tool"


void main()
{
    object oPC=GetLastUsedBy();
    if (HasItem(oPC,"PlanarGem"))
    {
        object oItemToTake = GetItemPossessedBy(oPC, "PlanarGem");
        if(GetIsObjectValid(oItemToTake) != 0)
            DestroyObject(oItemToTake);
        AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag ("chaos_home"))));
    }
    else
        SendMessageToPC(oPC,"The portal buzzes but does not activate.");
}
