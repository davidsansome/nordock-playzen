//::///////////////////////////////////////////////
//:: Secret Door invis object
//:: V 1.6
//:: Copyright (c) 2001 Bioware Corp. //:://////////////////////////////////////////////
/*
    This Invisable object will do a check and see
    if any elf comes within a radius of this object.

    It will create a trap door that will have its
    Destination set to a waypoint that has
    a tag of DST_<tag of this object>

    The radius is determined by the reflex saving
    throw of the invisible object

    The DC of the search stored by the willpower
    saving throw.

*/
//:://////////////////////////////////////////////
//:: Created By  : Robert Babiak
//:: Created On  : June 25, 2002
//::---------------------------------------------
//:: Modifyed By : Robert Babiak
//:: Modifyed On : July 24, 2002
//:: Modification: Changed the name of the blueprint
//:: used to create a wall door instead, and also
//:: incorporated a optimization to reduce CPU usage.
//::---------------------------------------------
//:: Modifyed By : Robert Babiak
//:: Modifyed On : July 25, 2002
//:: fixed problem with the aborting of the search
//:: for PC that where in the search radius.
//:: it was aborting when it got found a PC that
//:: outside the search distance, but this also
//:: canceled the search check.
//::
//:: This will teach me to trust code mailed in
//:: from users...:)
//::---------------------------------------------
//:: Modified By: Tromador
//:: Modified On: August 4, 2002
//:: The hakpak causes save/load issues.
//:: Modified to use a standard "portal" type
//:: placeable, instead of the custom hakpak models.
//::----------------------------------------------
//:: Modified By: Whyteshadow
//:: Modified On: August 4, 2002
//:: Only elves can search passively.
//:: Also, every elf in range will search,
//:: not just the one with the best skill.
//:: Also, the elf must be able to SEE the
//:: location of the door.
//::----------------------------------------------
//:://////////////////////////////////////////////

#include "hc_text_traps"

void main()
{
    float fRehideTime = 60.0;

    if (GetLocalInt(OBJECT_SELF, "bFound") == TRUE)
        return;

    if (GetLocalInt(OBJECT_SELF, "bReset") == TRUE)
    {
        object oDoor = GetLocalObject(OBJECT_SELF, "oDoor");
        SetPlotFlag(oDoor, FALSE);
        if (oDoor != OBJECT_INVALID)
            DestroyObject(oDoor);
        DeleteLocalObject(OBJECT_SELF, "oDoor");
        DeleteLocalInt(OBJECT_SELF, "bReset");
    }

    // get the radius and DC of the secret door.
    float fSearchDist = FeetToMeters(5.0f);  // PHB states that elves may only passively
                                             // find secret doors within 5 feet.
    int nDiffaculty   = GetWillSavingThrow   ( OBJECT_SELF );

    location locDoor = GetLocation(OBJECT_SELF);

    // what is the tag of this object used in setting the destination
    string sTag = GetTag(OBJECT_SELF);


    // Find the best searcher within the search radius.
    object oidNearestCreature = GetFirstObjectInShape(SHAPE_SPHERE, fSearchDist, locDoor, TRUE, OBJECT_TYPE_CREATURE);

    while ( oidNearestCreature != OBJECT_INVALID )
    {
        int iRace = GetRacialType(oidNearestCreature);
        if (iRace == RACIAL_TYPE_ELF)
        {
            int nMod = d20();
            int nSearchSkill = GetSkillRank(SKILL_SEARCH, oidNearestCreature);

            if ((nSearchSkill + nMod > nDiffaculty))
            {
                object oidDoor;

                SendMessageToPC(oidNearestCreature, DOORFOUND);
                // yes we found it, now create a trap door for us to use. it.
                oidDoor = CreateObject(OBJECT_TYPE_PLACEABLE, "secret_door", locDoor);
                SetLocalString( oidDoor, "strDestination" , "dst_"+sTag );
                SetPlotFlag(oidDoor,1);
                SetLocalObject(OBJECT_SELF, "oDoor", oidDoor);
                object oSelf = OBJECT_SELF;
                SetLocalInt(oSelf, "bFound", TRUE);
                DelayCommand(fRehideTime, SetLocalInt(oSelf, "bFound", FALSE));
                DelayCommand(fRehideTime, SetLocalInt(oSelf, "bReset", TRUE));
                return;
            } // if skill search found
        }


        oidNearestCreature = GetNextObjectInShape(SHAPE_SPHERE, fSearchDist, locDoor, TRUE, OBJECT_TYPE_CREATURE);
    }


}
