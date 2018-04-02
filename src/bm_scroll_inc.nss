//bm_wt_scroll_inc
//Include file for scroll creation system
//Created By: Brandon Mathis
//Created On: July 10, 2002
//This system will allow players to create scrolls.  To create a scroll the player must
//either activate a scroll creation item, or speak with an NPC that has the bm_wizardstable
//converstion assigned to it.  The player can then choose from a list of spells which one
//to create, and will be charged the appropriate amount of xp and gold.

#include "bm_scr_opt_inc"

//oCreator = Person creating the scroll
//sScroll = Tag of the scroll to be created
//nSpellLvl = Spell Level of the spell that is on the scroll (not the level it is cast at)
//nAdditionalCost = Any additional cost on top of the spell level * 50 * caster level
int CreateScroll(object oCreator, string sScroll, int nSpellLvl, int nAdditionalCost = 0)
{

    int nCasterLevel = GetLevelByClass(CLASS_TYPE_WIZARD, oCreator);
    if (GetLevelByClass(CLASS_TYPE_SORCERER, oCreator) > nCasterLevel) //GetCasterLevel returning 0 so fudging it here
        nCasterLevel = GetLevelByClass(CLASS_TYPE_SORCERER, oCreator);


    int nHD = GetHitDice ( oCreator );
    int nMinXP = ((( nHD * ( nHD - 1) ) / 2 ) * 1000) + 1; //Minimum amount of XP needed to keep level

    int nCost;
    if (nSpellLvl > 0)
        nCost = (20*nSpellLvl*nCasterLevel) + nAdditionalCost;
    else
        nCost = FloatToInt(12.5f * IntToFloat(nCasterLevel)) + nAdditionalCost;
    int nXPCost = nCost / 25;
    int nXP = GetXP(oCreator);
    int nTime = 1;


    nCost = nCost / 2; //Change cost to reflect creation cost
    //see if user has enough gold
    if (GetGold(oCreator) >= nCost)
    {
        //see if user has enough xp
        if (nXP >= nXPCost && (nXP-nXPCost) >= nMinXP)
        {



            //Add scroll to oUser
            /*if (CreateItemOnObject(sScroll, oCreator) != OBJECT_INVALID)
            {
                SendMessageToPC(oCreator, "Scroll Created");
                //Deduct XP for scroll
                SetXP(oCreator, nXP-nXPCost);
                //Deduct Gold for scroll
                TakeGoldFromCreature(nCost, oCreator, TRUE);
                return 1;
            }*/
            object oScroll;
            oScroll = CreateObject(OBJECT_TYPE_ITEM, sScroll, GetLocation(GetObjectByTag("BM_SCROLLCREATION")));
            if (oScroll != OBJECT_INVALID)  //Check to make sure it's a valid scroll
            {
                //Deduct Gold for scroll
                TakeGoldFromCreature(nCost, oCreator, TRUE);
                //Deduct XP for scroll
                SetXP(oCreator, nXP-nXPCost);
                if(SCROLLWAITTIME)
                {
                    object oMod = GetModule();
                    string sPCName = GetName(oCreator);
                    string sCDK = GetPCPublicCDKey(oCreator);
                    SetLocalInt(oMod, "ScrollCreated"+sPCName+sCDK, 1);
                    SetLocalInt(oMod, "nScrollCreatedHour"+sPCName+sCDK, GetTimeHour());
                    SetLocalInt(oMod, "nScrolLCreatedDay"+sPCName+sCDK, GetCalendarDay());
                    SetLocalInt(oMod, "nScrollCreatedMonth"+sPCName+sCDK, GetCalendarMonth());
                    SetLocalInt(oMod, "nScrolLCreatedYear"+sPCName+sCDK, GetCalendarYear());
                    SetLocalInt(oMod, "nScrollCreationTime"+sPCName+sCDK, nTime);
                    //SetLocalLocation(oMod, "lScrollCreationLoc"+sPCName+sCDK, GetLocation(oCreator));
                    SetLocalString(oMod, "sCreatedScroll"+sPCName+sCDK, sScroll);
                    DestroyObject(oScroll); //Get rid of scroll in temp place
                    return 3;

                }
                else
                {
                    CreateItemOnObject(sScroll, oCreator);
                    DestroyObject(oScroll); //Get rid of scroll in temp place
                    return 1;
                }
            }
            else
            {
                SendMessageToPC(oCreator, "Problem Creating Scroll -- Debug Output follows");
                SendMessageToPC(oCreator, "nCost = " + IntToString(nCost));
                SendMessageToPC(oCreator, "nXPCost = " + IntToString(nXPCost));
                SendMessageToPC(oCreator, "nXP = " + IntToString(nXP));
                SendMessageToPC(oCreator, "sScroll = " + sScroll);
                SendMessageToPC(oCreator, "caster level = " + IntToString(nCasterLevel));
                return 0;
            }
        }
        else
            SendMessageToPC(oCreator, "Not enough XP. You need " + IntToString(nXPCost+nMinXP) + "XP to create this scroll.");


    }

    else
        SendMessageToPC(oCreator, "Not enough gold. You need " + IntToString(nCost) + "gp to create this scroll.");
    return 0;
}

int CheckCasterLevel(object oCreator, int iSpellLvl, int Spell_Type = 1)
{
    int nCasterLevel;
    if (Spell_Type == 1) // Wizard/Sorceror
    {
        nCasterLevel = GetLevelByClass(CLASS_TYPE_WIZARD, oCreator);
        if (GetLevelByClass(CLASS_TYPE_SORCERER, oCreator) > nCasterLevel) //GetCasterLevel returning 0 so fudging it here
            nCasterLevel = GetLevelByClass(CLASS_TYPE_SORCERER, oCreator);
    }
    else if (Spell_Type == 2) //Cleric
    {
        nCasterLevel = GetLevelByClass(CLASS_TYPE_CLERIC, oCreator);
    }
    switch (iSpellLvl)
    {
        case 0:
            if (nCasterLevel >= 1) return TRUE;
            break;
        case 1:
            if (nCasterLevel >= 1) return TRUE;
            break;
        case 2:
            if (nCasterLevel >= 3) return TRUE;
            break;
        case 3:
            if (nCasterLevel >= 5) return TRUE;
            break;
        case 4:
            if (nCasterLevel >= 7) return TRUE;
            break;
        case 5:
            if (nCasterLevel >= 9) return TRUE;
            break;
        case 6:
            if (nCasterLevel >= 11) return TRUE;
            break;
        case 7:
            if (nCasterLevel >= 13) return TRUE;
            break;
        case 8:
            if (nCasterLevel >= 15) return TRUE;
            break;
        case 9:
            if (nCasterLevel >= 17) return TRUE;
            break;
        default:
            return FALSE;
    }
    return FALSE;

}

/*
int Create0LevelScroll(object oCreator, string sScroll)
{
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_WIZARD, oCreator);
    if (GetLevelByClass(CLASS_TYPE_SORCERER, oCreator) > nCasterLevel) //GetCasterLevel returning 0 so fudging it here
        nCasterLevel = GetLevelByClass(CLASS_TYPE_SORCERER, oCreator);

    int nCost = (25*nCasterLevel)/2;
    int nXPCost = nCost / 25;
    int nXP = GetXP(oCreator);

    nCost = nCost / 2; //Change cost to reflect creation cost
    //see if user has enough gold
    if (GetGold(oCreator) >= nCost)
    {
        //see if user has enough xp
        if (nXP >= nXPCost)
        {

            //Deduct XP for scroll
            SetXP(oCreator, nXP-nXPCost);
            //Deduct Gold for scroll
            TakeGoldFromCreature(nCost, oCreator, TRUE);
            //Add scroll to oUser
            if (CreateItemOnObject(sScroll, oCreator) != OBJECT_INVALID)
                SendMessageToPC(oCreator, "Scroll Created");
            else
            {
                SendMessageToPC(oCreator, "Problem Creating Scroll -- Debug Output follows");
                SendMessageToPC(oCreator, "nCost = " + IntToString(nCost));
                SendMessageToPC(oCreator, "nXPCost = " + IntToString(nXPCost));
                SendMessageToPC(oCreator, "nXP = " + IntToString(nXP));
                SendMessageToPC(oCreator, "sScroll = " + sScroll);
                SendMessageToPC(oCreator, "caster level = " + IntToString(nCasterLevel));
            }
        }
        else
            SendMessageToPC(oCreator, "Not enough XP. You need " + IntToString(nXPCost) + "XP to create this scroll.");

    }

    else
        SendMessageToPC(oCreator, "Not enough gold. You need " + IntToString(nCost) + "gp to create this scroll.");
}
 */



//void main(){}

