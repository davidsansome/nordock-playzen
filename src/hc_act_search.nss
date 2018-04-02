#include "hc_text_activate"
void main()
{
    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");
    int nRogueLevel = GetLevelByClass(CLASS_TYPE_ROGUE, oUser);
    location locPlayer= GetLocation(oUser);
    int nFT=GetLocalInt(oUser,"FINDTRAP");
    float fDis=10.0;
    if(nFT) fDis=100.0;
    object oSearchedItem = GetFirstObjectInShape(SHAPE_SPHERE, FeetToMeters(fDis),
        locPlayer, TRUE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_TRIGGER);
    while (oSearchedItem != OBJECT_INVALID)
    {
        // Check to see if the object has a trap.
        if (GetIsTrapped(oSearchedItem))
        {
            // Yes, so begin detection routine.
            int oTrapDC = GetTrapDetectDC(oSearchedItem) - 100;
            int bCanSpotTrap = FALSE; // Assume that the person cannot spot a trap.
            // Determine spotting capability
            if ((oTrapDC <= 20) || ((oTrapDC > 20) && (nRogueLevel >= 1 || nFT)))
                bCanSpotTrap = TRUE;
                // Only check to see if detected if not previously detected
                // and the PC has the ability to do detect it.
            if (!GetTrapDetectedBy(oSearchedItem, oUser) && bCanSpotTrap)
            {
                int nSearch = GetSkillRank(SKILL_SEARCH, oUser);
                int nDCCheck = d20() + nSearch;
                if (nDCCheck >= oTrapDC) // Trap found
                     SetTrapDetectedBy(oSearchedItem, oUser);
            }
        }
        else
        {
        // Hidden door detection
            if (GetName(oSearchedItem) == "Secret Door Placeholder" && GetLocalInt(oSearchedItem, "bFound") != TRUE)
            {
                string strTag = GetTag(oSearchedItem);
                location locDoor = GetLocation(oSearchedItem);
                int nDC = GetWillSavingThrow(oSearchedItem);
                int nSearch = GetSkillRank(SKILL_SEARCH, oUser);
                int nRoll = d20();
                // Search is not a trained skill, so a search of 0 is valid
                if ((nRoll + nSearch) >= nDC)
                {
                    SendMessageToPC(oUser, FINDSECRET);
                    // yes we found it, now create a trap door for us to use. it.
                    object oidDoor = CreateObject(OBJECT_TYPE_PLACEABLE, "secret_door", locDoor);
                    SetLocalString( oidDoor, "strDestination" , "dst_" + strTag );
                    SetPlotFlag(oidDoor,1);
                    SetLocalInt(oSearchedItem, "bFound", TRUE);
                    SetLocalObject(oSearchedItem, "oDoor", oidDoor);
                    DelayCommand(60.0f, SetLocalInt(oSearchedItem, "bFound", FALSE));
                    DelayCommand(60.0f, SetLocalInt(oSearchedItem, "bReset", TRUE));
                }
            }
        }
        oSearchedItem = GetNextObjectInShape(SHAPE_SPHERE, FeetToMeters(fDis),
            locPlayer, TRUE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_TRIGGER);
    }
}
