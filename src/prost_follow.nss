//::///////////////////////////////////////////////
//:: FileName kela5gp
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: maddman75
//:: Created On: 7/6/2002 11:59:31 PM
//:://////////////////////////////////////////////
void main()
{
    // Remove some gold from the player
    if (GetGold(GetPCSpeaker()) < 50)
    {
        FloatingTextStringOnCreature("Not enough gold", GetPCSpeaker());
        return;
    }
    TakeGoldFromCreature(50, GetPCSpeaker(), FALSE);
    ActionForceFollowObject(GetPCSpeaker(), 1.0);
}
