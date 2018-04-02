//::///////////////////////////////////////////////
//:: FileName pro15gp
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: maddman75
//:: Created On: 7/6/2002 11:59:31 PM
//:://////////////////////////////////////////////
void main()
{
    // Remove some gold from the player
    if (GetGold(GetPCSpeaker()) < 100)
    {
        FloatingTextStringOnCreature("Not enough gold", GetPCSpeaker());
        return;
    }
    TakeGoldFromCreature(100, GetPCSpeaker(), TRUE);

    // perform the favor
    PlaySound("al_na_sludglake1");
    PlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 8.0);
}
