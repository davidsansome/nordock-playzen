//::///////////////////////////////////////////////
//:: Default On Attacked
//:: NW_C2_DEFAULT5
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If already fighting then ignore, else determine
    combat round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

void main()
{
//This script stops PCs from swapping melee weapons in middle of combat to gain additional attacks that they should not be getting.
//This script needs to be incorporated into creatures/npc's OnPhysicalAttacked script.
//What this script does is tag the main melee weapon used by the PC for 6 seconds. If the PC attacks or continues to attack any other creature and //is not using the same melee weapon, this script will clear the PCs action queue, unequip the weapon and make the PC drop it on the ground.
//Therefore if a PC wishes to change weapons in middle of combat they need to break off an attack for a round (6seconds) before swapping weapons.
// Commented out by Grug because of weird bugs with a few scitmars and rapiers..
// Bugs seem unrelated to specific weapons but mostly rapiers and scitmars.
/*
object oPC = GetLastAttacker(OBJECT_SELF);
object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
if (GetIsObjectValid(oWeapon))
 {
    int nWeapType = GetBaseItemType(oWeapon);
    int nUsedOther;
    if ((GetLocalInt(oWeapon,"USING") != 1) &&
        (nWeapType != BASE_ITEM_LIGHTCROSSBOW ) &&
        (nWeapType != BASE_ITEM_HEAVYCROSSBOW ) &&
        (nWeapType != BASE_ITEM_LONGBOW ) &&
        (nWeapType != BASE_ITEM_SHORTBOW ) &&
        (nWeapType != BASE_ITEM_SLING ))
      {
      object oItem = GetFirstItemInInventory(oPC);
       while (GetIsObjectValid(oItem))
         {
          if (GetLocalInt(oItem,"USING") == 1)
           {
           nUsedOther = 1;
           break;
           }
          oItem = GetNextItemInInventory(oPC);
         }
      if (nUsedOther == 1)
       {
       FloatingTextStringOnCreature("You fumble as you try to change weapons and attack in the same round !",oPC,FALSE);
       SendMessageToPC(oPC,"You fumble as you try to change weapons and attack in the same round !");
       AssignCommand(oPC,ClearAllActions(TRUE));
       AssignCommand(oPC,ActionUnequipItem(oWeapon));
       //AssignCommand(oPC,ActionPutDownItem(oWeapon));
       }
      else
       {
       SetLocalInt(oWeapon,"USING",1);
       DelayCommand(6.0,DeleteLocalInt(oWeapon,"USING"));
       }
      }
 }*/
// End of Anti Weapon Swap script.

    if(!GetFleeToExit())
    {
        if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
        {
            if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
            {
                if(GetIsObjectValid(GetLastAttacker()))
                {
                    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
                    {
                        //AdjustReputation(GetLastAttacker(), OBJECT_SELF, -100);
                        SetSummonHelpIfAttacked();
                        DetermineSpecialBehavior(GetLastAttacker());
                    }
                    else
                    {
                        if(GetArea(GetLastAttacker()) == GetArea(OBJECT_SELF))
                        {
                            SetSummonHelpIfAttacked();
                            DetermineCombatRound();
                        }
                    }
                    //Shout Attack my target, only works with the On Spawn In setup
                    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
                    //Shout that I was attacked
                    SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
                }
            }
        }
        else
        {
            //Put a check in to see if this attacker was the last attacker
            //Possibly change the GetNPCWarning function to make the check
            SetSpawnInCondition(NW_FLAG_SET_WARNINGS, FALSE);
        }
    }
    else
    {
        ActivateFleeToExit();
    }
    if(GetSpawnInCondition(NW_FLAG_ATTACK_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1005));
    }
}
