// Level Trainer system. Folks must speak with a level trainer to gain a level
// if LEVELTRAINER is set to 1.
//

//#include "hc_inc"
//#include "hc_inc_on_level"
//#include "hc_text_lvl"
//#include "subraces"

#include "journal_include"

void main()
    {
    object oPC=GetPCLevellingUp();
    int nHD=GetHitDice(oPC);
    int nNewXP = ((nHD * (nHD-1)) / 2 * 1000);
    int nCurrXP = GetXP(oPC);
    int nOverflow = nCurrXP-nNewXP;
    if (!(GetTag(GetArea(oPC)) == "TESTINGAREA"))
    {
        if (nOverflow > 100)
            nOverflow = 100;
    }
    SetXP(oPC,nNewXP+nOverflow);

   if (nHD == 40)
        dhAddJournalQuestEntry("bren", 1, oPC, FALSE);
}




//    if(!preEvent()) return;
//    if(!GetLocalInt(oMod,"LEVELTRAINER"))
//    {
//        Subraces_LevelUpSubrace( GetPCLevellingUp() );
//        postEvent();
//        return;
//    }
//    object oPC=GetPCLevellingUp();
//    int nHD=GetHitDice(oPC);
//    int nClass2=GetClassByPosition(2, oPC);
//    int nClass3=GetClassByPosition(3, oPC);
//    if (
//            (nClass2 != CLASS_TYPE_INVALID && GetLevelByPosition(2, oPC)==1) ||
//            (nClass3 != CLASS_TYPE_INVALID && GetLevelByPosition(3, oPC)==1) ||
//            ((nClass2 != CLASS_TYPE_INVALID || nClass3 != CLASS_TYPE_INVALID)&&
//              GetLevelByPosition(1, oPC)==1))
//    {
//        SetLocalInt(oMod,"LEVELCOSTPEN"+GetName(oPC)+GetPCPublicCDKey(oPC),1);
//        SendMessageToPC(oPC, IntToString(GetLocalInt(oMod,"LEVELCOST"))+OWEDMONEY);
//        postEvent();
//        return;
//    }
//    int nGiveLev=GetLocalInt(oMod,"GIVELEVEL");
//    if(!GetPersistentInt(oPC, "ALLOWLEVEL") && (nGiveLev && nHD >
//        nGiveLev))
//    {
//        SendMessageToPC(oPC,GAINLEVEL);

//        int nNewXP = ((nHD * (nHD-1)) / 2 * 1000)-1;
//        SetXP(oPC, nNewXP);
//        if(GetLocalInt(GetModule(),"PWEXP"))
//        {
//            SetUpExp(oPC, 0);
//        }
//    }
//    DeletePersistentInt(oPC, "ALLOWLEVEL");
//    Subraces_LevelUpSubrace( GetPCLevellingUp() );
//    postEvent();
//}

