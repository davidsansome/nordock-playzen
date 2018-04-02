#include "hc_inc"
#include "hc_inc_htf"
#include "hc_text_activate"
#include "hc_text_rest"
#include "rr_drunk_inc"

int isMeat(string oMeat)
{
    if (oMeat=="hc_meat")
        return TRUE;
    else
    if (oMeat=="ATS_R_BADG_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_BEAR_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_COUG_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_DEER_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_BBAT_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_BLAB_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_POLB_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_BCAT_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_CCAT_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_WSTA_N_MEAT")
        return TRUE;
    else
    if (oMeat=="ATS_R_WWOL_N_MEAT")
        return TRUE;
    else
    if (FindSubString(GetStringUpperCase(oMeat),"RAW"))
        return TRUE;
    else
        return FALSE;
}

void main()
{
    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");
    string sItemTag=GetLocalString(oUser,"TAG");
    DeleteLocalString(oUser,"TAG");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");

if (sItemTag=="BTokenofPossession")
{
    SendMessageToPC(oUser,"Token Passed");

    if (GetTag(oOther)=="summonpillar")

        {
            SendMessageToPC(oUser,"Pillar passed");
            location lTarget = GetLocation(GetObjectByTag("pillar"));
            DestroyObject(GetObjectByTag("summonshaft"));
            AssignCommand(oUser, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), lTarget));
            AssignCommand(oUser, DelayCommand(3.0,ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE), lTarget)));
            DestroyObject(GetObjectByTag("summonpillar"));
            DestroyObject(GetObjectByTag("GaldorCity"));
            CreateObject(OBJECT_TYPE_PLACEABLE,"galdorport",lTarget,TRUE);
        }
    return;
}
// Portal Pendant

    if (sItemTag=="PendantWing")
    {
        string sPCLoc=GetTag(GetArea(oUser));
        if (!(sPCLoc=="FuguePlane"))
        {
            SetLocalInt(GetEnteringObject(),"arena", FALSE);
            AssignCommand(oUser, ActionStartConversation(oUser,"goldportal", TRUE));
        }
        return;
    }

// Drow stone of return


    if (sItemTag=="StoneofReturn")
    {
        string sPCLoc=GetTag(GetArea(oUser));
        if (!(sPCLoc=="FuguePlane"))
        {
            SetLocalInt(GetEnteringObject(),"arena", FALSE);
            AssignCommand(oUser, JumpToLocation(GetLocation(GetObjectByTag ("port_loknar"))));
        }
        return;
    }

// Duergar stone of return


    if (sItemTag=="laduguerstone")
    {
        string sPCLoc=GetTag(GetArea(oUser));
        if (!(sPCLoc=="FuguePlane"))
        {
            SetLocalInt(GetEnteringObject(),"arena", FALSE);
            AssignCommand(oUser, JumpToLocation(GetLocation(GetObjectByTag ("duergarspawn"))));
        }
        return;
    }

// Booze!

    if (IsBooze(oItem))
    {
        AssignCommand(oUser, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        IncreaseBAC(oUser);
        return;
    }

// Ox
    if (sItemTag=="OxWhistle")
    {
        CreateObject(OBJECT_TYPE_CREATURE,"packox",GetLocation(oUser),TRUE);
        return;
    }


    //Used uncooked foods
    if (isMeat(sItemTag))
    {
        if(oOther==OBJECT_INVALID)
        {
            SendMessageToPC(oUser,COOKME);
            return;
        }
        if (FindSubString(GetStringUpperCase(GetTag(oOther)),"FIRE") == -1)
        {
            SendMessageToPC(oUser, CANTCOOK);
            return;
        }
        FloatingTextStringOnCreature(COOKFLOAT,oUser);
        DestroyObject(oItem);
        CreateItemOnObject("cookedfood",oUser);
        return;
    }

    //Used Food item
    int iHUNGERSYSTEM = GetLocalInt(oMod,"HUNGERSYSTEM");
    if (FindSubString(GetStringUpperCase(sItemTag),"FOOD") != -1) {
        if (iHUNGERSYSTEM)
            UseFoodOrDrinkItem(oUser,oItem);
        else {
            SendMessageToPC(oUser,EATFOOD + " [" + GetName(oItem) + "]");
            DestroyObject(oItem);
        }
        return;
    }

    //Used Drink Item
    if (FindSubString(GetStringUpperCase(sItemTag),"DRINK") != -1) {
        if (iHUNGERSYSTEM)
            UseFoodOrDrinkItem(oUser,oItem);
        else {
            SendMessageToPC(oUser,GULPDRINK + " [" + GetName(oItem) + "]");
            if (FindSubString(GetStringUpperCase(sItemTag),"ALCOHOL") != -1)
                MakePCDrunk(oUser,1,BURP);
            DestroyObject(oItem);
        }
        return;
    }

    //Used Water Canteen
    if (sItemTag == "WaterCanteen") {
        if (iHUNGERSYSTEM) {
            location loc;
            if(oOther==OBJECT_INVALID)
                loc = GetItemActivatedTargetLocation();
            UseWaterCanteen(oUser,oItem,oOther,loc);
        }
        else {
            //The water canteen really has no purpose unless HUNGERSYSTEM is on,
            //but if it isn't give it some cool effects anyway.
            AssignCommand(oUser,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            DelayCommand(1.5,FloatingTextStringOnCreature(GULP, oUser));
        }
        return;
    }
}
