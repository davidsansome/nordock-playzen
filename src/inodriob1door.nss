//::///////////////////////////////////////////////
//:: Name    inodriob1door
//:: FileName  inodriob1door
//:: Copyright (c) 2005 Eagware Corp.
//:://////////////////////////////////////////////
/*
   For the on-click event of the riddlers door
   Player has the key from the riddler?
   Then when they click on the door it opens, ports them through and closes.
*/
//:://////////////////////////////////////////////
//:: Created By:  Eaglec
//:: Created On:  01/01/2005
//:://////////////////////////////////////////////

#include "0_ntfm_inc"

void main()
{
object oPC=GetClickingObject();
object oKey=GetItemPossessedBy(oPC, "InodrioBasementKey");
string sText;
int nTry;
effect eEffect, eEffectMiss, eDamage;

if (oKey!=OBJECT_INVALID)
    {
    // open the door
    ActionOpenDoor(OBJECT_SELF);
    // take the key
    DestroyObject(oKey);
    // portal the player
    AssignCommand(oPC, JumpToObject(GetObjectByTag("1st_StairDown")) );
    // close the door
    DelayCommand(0.5,ActionCloseDoor(OBJECT_SELF));
    }
else if (oKey==OBJECT_INVALID)
    {
    nTry=GetLocalInt(oPC, "InodrioB1");
    eEffect=EffectBeam(VFX_BEAM_CHAIN, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
    eEffectMiss=EffectBeam(VFX_BEAM_CHAIN, OBJECT_SELF, BODY_NODE_CHEST, TRUE);
    switch(nTry)
        {
        // refuse entry
        case 0:
        // set up
            sText="A powerful magical field stops you from reaching the doorway";
        // send text
            FloatingTextStringOnCreature(sText,oPC);
        // increment try
            SetLocalInt(oPC,"InodrioB1",1);
            break;

        // warning shot
        case 1:
        //set up
            sText="a jolt of electricity flies from the door.  You are lightly singed from the heat.";
        //send message and fire warning shot
            SendMessageToPC(oPC, sText);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffectMiss, oPC, 1.0);
        //increment try number
            SetLocalInt(oPC,"InodrioB1",2);
            break;

        // ok hurt the stupid people
        case 2:
        //set up
            sText="a jolt of electricity flies from the door as you get close...";
            eDamage=EffectDamage(Random(100)+50, DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_PLUS_TWENTY);
        //send message and apply beam effect and damage
            SendMessageToPC(oPC, sText);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC, 1.0);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
        //increment try number
            SetLocalInt(oPC,"InodrioB1",3);
            break;

        // ok if that wasn't enough of a clue this zaps their equipment too
        case 3:
        //set up
            sText="a jolt of electricity flies from the door as you get close...";
            eDamage=EffectDamage(Random(100)+50, DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_PLUS_TWENTY);
        //send message, apply beam effect and destroy random kit
            SendMessageToPC(oPC, sText);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC, 1.0);
            NukeMuppetsEquipment(oPC);
       //apply damage
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
       //increment try number
            SetLocalInt(oPC,"InodrioB1",4);
            break;

        case 4:
        //set up
            sText="My god you are stupid.  Next time, take a hint!";
            SendMessageToPC(oPC, sText);
        //apply beam effect and destroy random kit
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC, 1.0);
            NukeMuppetsEquipment(oPC);
        //apply damage and decrement try  number
            eDamage=EffectDamage(GetCurrentHitPoints(oPC)+20, DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_PLUS_TWENTY);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
            eDamage=EffectDamage(GetCurrentHitPoints(oPC)+20, IP_CONST_DAMAGETYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
            SetLocalInt(oPC,"InodrioB1",3);
            break;

        }


    }
}
