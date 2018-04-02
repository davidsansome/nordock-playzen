//::///////////////////////////////////////////////
//:: FileName tuck_pay_ch
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/13/2002 10:10:40 PM
//:://////////////////////////////////////////////


void main()
{
    int oHD = GetHitDice(GetPCSpeaker());

    object oPC = GetPCSpeaker();

    // Remove some gold from the player
    TakeGoldFromCreature(oHD*200, oPC, TRUE);

}
