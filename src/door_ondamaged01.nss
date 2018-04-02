//::///////////////////////////////////////////////
//:: Make door call for help when damaged
//:: DOOR_ONDAMAGED01
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the damaging object of the door,
    and if the damager is a valid player in the
    same area, the door will call for help.
*/
//:://////////////////////////////////////////////
//:: Created By: Maglazar@hotmail.com
//:: Created On: August 10, 2002
//:://////////////////////////////////////////////
void main()
{
    // Get the object that damaged the door
    object oPCDamager = GetLastDamager();
    // Make sure the damaging object is a valid object AND is a Player Character
    if(GetIsObjectValid(oPCDamager) && GetIsPC(oPCDamager))
    {
        // Make sure the damaging object is in the same area
        if(GetArea(oPCDamager) == GetArea(OBJECT_SELF))
        {
            //Shout Attack my target
            SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
           //Shout that I was attacked
           SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
            // Adjust the faction
               SetIsTemporaryEnemy(oPCDamager, OBJECT_SELF);
        }   // end 'if' that checks area
    }       // end 'if' that checks validity of the damaging object
}           // end 'main()'

