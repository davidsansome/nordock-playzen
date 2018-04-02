//::///////////////////////////////////////////////
//:: FileName swt_start_store
//:: by Streamweaver
//:: Date: 7/5/2002
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
/* When starting a store, automatically looks for a merchant with the same tag
as the calling object.   Then adjust selling prices based on the Persuade total
of the NPC and the PC, the buy prices are adjusted based on the Persuade skill
of the two parties alone.  Also, if the calling player is a Half Orc it adjusts
prices up a further 10 percent, and buy price down a further 5 percent.*/
//:://////////////////////////////////////////////
void main()
{

    // Either open the store with that tag or let the user know that no store exists.

    object oNPC = OBJECT_SELF;//Gets the NPC calling text.
    string sTag = GetTag(oNPC);//Gets NPCs tag and uses to find store tag.
    object oPC = GetPCSpeaker();//Gets PC speaking.
    object oStore = GetObjectByTag(sTag);//Gets store with same tag as NPC.
    //Next few variables get NPC/PC skill and modifiers for persuade.
    int nNPCSkill = GetSkillRank(SKILL_PERSUADE, oNPC);
    int nNPCStat = GetAbilityModifier(ABILITY_CHARISMA, oNPC);
    int nPCSkill =  GetSkillRank(SKILL_PERSUADE, oPC);
    int nPCStat = GetAbilityModifier(ABILITY_CHARISMA, oPC);
    //Creates the math to modify prices, change as you see fit.
    int nNPCcheck = (FloatToInt(nNPCSkill * 1.5) + nNPCStat);
    int nPCcheck = (FloatToInt(nPCSkill * 1.5) + nPCStat);
    int nMarkUp = nNPCcheck - nPCcheck;
    int nMarkDown = nPCSkill - nNPCSkill;
        //I commented out the price changes for race becuase I was not sure if you might want them.
    //If player is a halforc charge extra.  Modify for your needs as appropriate.
    /*if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC)
    {
        nMarkUp = nMarkUp + 10;
        nMarkDown = nMarkDown - 5;
    }

    //If player is a dwarf charge less.  Modify for your needs as appropriate.
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF)
    {
        nMarkUp = nMarkUp - 10;
        nMarkDown = nMarkDown + 15;
    }*/

    //Opens the Store with the prices adjusted as above.
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        OpenStore(oStore, GetPCSpeaker(), nMarkUp, nMarkDown);
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
