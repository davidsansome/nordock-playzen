//::///////////////////////////////////////////////
//:: Summon Animal Companion
//:: NW_S2_AnimalComp
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spell summons a Druid's animal companion
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 27, 2001
//:://////////////////////////////////////////////

#include "wm_include"


void check_strength()
{
    if(GetLocalInt(GetModule(),"REALFAM"))
    {
        object oMaster=OBJECT_SELF;
        object oAC=GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oMaster);
        int nMHD=GetHitDice(oMaster);
        int nAHD=GetHitDice(oAC);
        if(nAHD>(nMHD+1))
        {
            effect eDisap=EffectDisappear();
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDisap, oAC);
            SendMessageToPC(oMaster,"The animal wanders off, it is too "+
                "powerful for you to keep its loyalty, select a Hawk, Spider,"+
                " Wolf, or Badger.");
        }
    }
}

void main()
{
    //Yep thats it
    SummonAnimalCompanion();
    DelayCommand(1.0,check_strength());
}
