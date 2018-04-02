//::///////////////////////////////////////////////
//:: Make door call for help when attacked
//:: DOOR_ONATTACKD01
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the attacking object of the door,
    and if the attacker is a valid player in the
    same area, the door will call for help.
*/
//:://////////////////////////////////////////////
//:: Created By: Maglazar@hotmail.com
//:: Created On: August 10, 2002
//:://////////////////////////////////////////////
void main()
{
    // Get the object that attacked the door
    object oPCAttacker = GetLastAttacker();
    // Make sure the attacking object is a valid object AND is a Player Character
    if(GetIsObjectValid(oPCAttacker) && GetIsPC(oPCAttacker))
    {
        // Make sure the attacking object is in the same area
        if(GetArea(oPCAttacker) == GetArea(OBJECT_SELF))
        {
            //Shout Attack my target
            SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
           //Shout that I was attacked
           SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
           // Adjust Faction
          SetIsTemporaryEnemy(oPCAttacker, OBJECT_SELF);
        }   // end 'if' that checks area
    }       // end 'if' that checks validity of the attacking object
}           // end 'main()'

