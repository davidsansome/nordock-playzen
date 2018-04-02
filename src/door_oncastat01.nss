//::///////////////////////////////////////////////
//:: Door calls for help if a spell is cast on it
//:: DOOR_ONCASTAT01
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines whether or not the caster of the
    last spell on the door is a valid player in the
    same area, and whether or not the spell was
    harmful. If the player is valid, and in the same
    area as the door, and the spell was harmful,
    the door will call for help.
*/
//:://////////////////////////////////////////////
//:: Created By: Maglazar@hotmail.com
//:: Created On: August 10, 2002
//:://////////////////////////////////////////////
void main()
{
    // Get the last object that cast a spell on the door
    object oCaster = GetLastSpellCaster();
    // Make sure the last spell cast was harmful
    if(GetLastSpellHarmful())
    {
        // Make sure the caster is a valid object AND a valid Player Character
        if(GetIsObjectValid(oCaster) && GetIsPC(oCaster))
        {
            // Make sure the caster is in the same area
            if(GetArea(oCaster) == GetArea(OBJECT_SELF))
            {
                //Shout Attack my target
                SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
                //Shout that I was attacked
                SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
                // Adjust faction
               SetIsTemporaryEnemy(oCaster, OBJECT_SELF);
            }   // end 'if' area check
        }       // end 'if' valid PC object
    }           // end 'if' last spell was harmful
}               // end 'main()'

