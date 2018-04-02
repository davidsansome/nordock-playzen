#include "hc_inc_helper"

void main()
{
    int nDM;
    int nPly;
    string sReport;
    object oPC;
    oPC=GetFirstPC();
    sReport="** STATUS REPORT **";
    while(GetIsObjectValid(oPC))
    {
        if(GetIsDM(oPC)) nDM++;
        else nPly++;
        oPC=GetNextPC();
    }
    sReport+="\n- There are "+IntToString(nDM)+" DM's and "+IntToString(nPly)+
        " Players online.";
    if(GetPersistentString(oMod,"PLAYERDM")!="")
        sReport +="  The Player DM is Public CDKEY: "+
            GetPersistentString(oMod,"PLAYERDM")+".";
    if(GetLocalInt(oMod,"SINGLECHARACTER"))
        sReport +=" The Server is in Single Character mode.";
    if(GetLocalInt(oMod,"LOCKED"))
        sReport+="\n- The Module is Locked ";
    else
        sReport+="\n- The Module is UnLocked ";
    sReport+="with a DMRESERVE of "+IntToString(GetLocalInt(oMod,"DMRESERVE"))+
        ".  The PKTRACKER system is ";
    if(GetLocalInt(oMod,"PKTRACKER"))
    {
        sReport+="set at "+
            IntToString(GetLocalInt(oMod,"PKTRACKER"))+" kills and TELLONPK is ";
        if(GetLocalInt(oMod,"TELLONPK")) sReport+= "on.";
        else sReport += "off.";
    }
    else sReport += "off.";
    sReport += "\n- The HCREXP system is ";
    if(GetLocalInt(oMod,"HCREXP"))
    {
        sReport+="on with a BASEXP setting of "+
            IntToString(GetLocalInt(oMod,"BASEXP"))+" and a BONUSXP setting of "+
            IntToString(GetLocalInt(oMod,"BONUSXP"))+".";
    }
    else sReport +="off.";
    sReport +="\n- The RESTSYSTEM is ";
    if(GetLocalInt(oMod,"RESTSYSTEM"))
    {
        sReport+="on with a RESTBREAK setting of "+
            IntToString(GetLocalInt(oMod,"RESTBREAK"))+" hours, LIMITEDRESTHEAL ";
        if(GetLocalInt(oMod, "LIMITEDRESTHEAL"))
            sReport+="enabled, RESTARMORPEN ";
        else
            sReport+="off, RESTARMORPEN ";
        if(GetLocalInt(oMod, "RESTARMORPEN"))
            sReport+="enabled, and BEDROLLSYSTEM ";
        else
            sReport+="off, and BEDROLLSYSTEM ";
        if(GetLocalInt(oMod, "BEDROLLSYSTEM"))
            sReport+="enabled.";
        else
            sReport+="off.";
    }
    else
        sReport+="off.";
    sReport+="\n- The LEVELTRAINER is ";
    if(GetLocalInt(oMod,"LEVELTRAINER"))
    {
        sReport+="on with a LEVELCOST of "+IntToString(GetLocalInt(oMod,"LEVELCOST"))+
            "gps/level and players start at a GIVELEVEL of "+
            IntToString(GetLocalInt(oMod,"GIVELEVEL"))+".";
    }
    else
        sReport+="off and players start at a GIVELEVEL of "+
            IntToString(GetLocalInt(oMod,"GIVELEVEL"))+".";
    sReport+="\n- The BLEEDSYSTEM is ";
    if(GetLocalInt(oMod,"BLEEDSYSTEM"))
        sReport+="on, GODSYSTEM is ";
    else
        sReport+="off, GODSYSTEM is ";
    if(GetLocalInt(oMod,"GODSYSTEM"))
    {
        sReport+="on, with a REZCHANCE of "+
            IntToString(GetLocalInt(oMod,"REZCHANCE"))+"% ";
        if(GetLocalInt(oMod,"REZPENALTY"))
            sReport+="and REZPENALTY on. The DEATHSYSTEM is ";
        else
            sReport+="and REZPENALTY off. The DEATHSYSTEM is ";
    }
    else
        sReport+="off.  The DEATHSYSTEM is ";
    if(GetLocalInt(oMod,"DEATHSYSTEM"))
        sReport+="on, LIMBO is ";
    else
        sReport+="off, LIMBO is ";
    if(GetLocalInt(oMod,"LIMBO"))
        sReport+="on, and LOOTSYSTEM is ";
    else
        sReport+="off, and LOOTSYSTEM is ";
    if(GetLocalInt(oMod,"LOOTSYSTEM"))
        sReport+="on.";
    else
        sReport+="off.";
    sReport+="\n- The STORESYSTEM is ";
    if(GetLocalInt(oMod,"STORESYSTEM"))
        sReport+="on, FOODSYSTEM is ";
    else
        sReport+="off, FOODSYSTEM is ";
    if(GetLocalInt(oMod,"FOODSYSTEM"))
        sReport+="on, WANDERSYSTEM is ";
    else
        sReport+="off, WANDERSYSTEM is ";
    if(GetLocalInt(oMod,"WANDERSYSTEM"))
        sReport+="on, HCRTRAPS are ";
    else
        sReport+="off, HCRTRAPS are ";
    if(GetLocalInt(oMod,"HCRTRAPS"))
        sReport+="on, and REALFAMiliar is ";
    else
        sReport+="off, and REALFAMiliar is ";
    if(GetLocalInt(oMod,"REALFAM"))
        sReport+="on, and MATERCOMPs are ";
    else
        sReport+="off, and MATERCOMPs are ";
    if(GetLocalInt(oMod,"MATERCOMP"))
        sReport+="on.";
    else
        sReport+="off.";
    sReport+="\n- BURNTORCH keeps a torch lit "+
        IntToString(GetLocalInt(oMod,"BURNTORCH"))+" hour(s) and Summoned "+
        "Creatures last for "+IntToString(GetLocalInt(oMod,"SUMMONTIME"))+
        " round(s)/level.";
    sReport +="\n- The LOGINMESSAGE is "+GetLocalString(oMod,"LOGINMESSAGE");
    SendMessageToPC(OBJECT_SELF, sReport);
}
