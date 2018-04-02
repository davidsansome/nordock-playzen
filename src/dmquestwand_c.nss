#include "rr_persist"
#include "apts_inc_ptok"

int StartingConditional()
{
    object oTarget = GetLocalObject(GetPCSpeaker(), "DMQuestWandTarget");

    string sName = GetName(oTarget);
    int iMain = GPI(oTarget, "nMainQuest");
    int iTylnW = GPI(oTarget, "TylnWineCompleted");
    int iTylnS = GPI(oTarget, "TylnSilverwareCompleted");
    int iKabuL = GPI(oTarget, "KabuBringusCompleted");
    int iWeary = GetTokenBool(oTarget, "weary_bag");
    int iKoboldS = GetTokenBool(oTarget, "kobold_staff");
    int iTucker = GetTokenBool(oTarget, "tucker_ring");
    int iLich = GetTokenBool(oTarget, "LichQuestComplete");
    int iOrnal = GetTokenBool(oTarget, "farmer_beetle");
    int iDrowB = GetTokenBool(oTarget, "denzecht_vendersh");
    int iTron1 = GetTokenBool(oTarget, "dorn_quest_2");
    int iTron2 = GetTokenBool(oTarget, "trgob_quest_2");
    int iPally = GetTokenBool(oTarget, "PaladinQuestComplete");
    int iDrowM = GetTokenBool(oTarget, "denzecht_vendersh");
    int iTromm = GetTokenBool(oTarget, "duke_unger");
    int iLFarm = GetTokenBool(oTarget, "legendfarm");
    int iGurn1 = GetTokenBool(oTarget, "gurnal_quest_1");
    int iGurn2 = GetTokenBool(oTarget, "gurnal_quest_2");
    int iDrago = GPI(oTarget, "kat_gatekeeper_reward");
    int iDruid = GPI(oTarget, "TrevorCompleted");
    int iPengu = GPI(oTarget, "LegendaryPenguins");
    int iBNote = GPI(oTarget, "OrcShamanHeadCompleted");
    int iGRune = GetTokenBool(oTarget, "gal_rune_done");
    int iCoBre = GPI(oTarget, "InmateBennerFinished");
    int iTaxCo = GPI(oTarget, "TaxCollectorCompleted");

    string sComp = "   <c þ >(completed)<cþþþ>"; // Green
    string sInco = "   <cþ  >(not completed)<cþþþ>";  // Red

    SetCustomToken(1000, sName);
    SetCustomToken(1001, iMain ? sComp : sInco);
    SetCustomToken(1002, iTylnW ? sComp : sInco);
    SetCustomToken(1003, iTylnS ? sComp : sInco);
    SetCustomToken(1004, iKabuL ? sComp : sInco);
    SetCustomToken(1005, iWeary ? sComp : sInco);
    SetCustomToken(1006, iKoboldS ? sComp : sInco);
    SetCustomToken(1007, iTucker ? sComp : sInco);
    SetCustomToken(1008, iLich ? sComp : sInco);
    SetCustomToken(1009, iOrnal ? sComp : sInco);
    SetCustomToken(1010, iDrowB ? sComp : sInco);
    SetCustomToken(1011, iTron1 ? sComp : sInco);
    SetCustomToken(1012, iTron2 ? sComp : sInco);
    SetCustomToken(1013, iDrowM ? sComp : sInco);
    SetCustomToken(1014, iTromm ? sComp : sInco);
    SetCustomToken(1015, iLFarm ? sComp : sInco);
    SetCustomToken(1016, iGurn1 ? sComp : sInco);
    SetCustomToken(1017, iGurn2 ? sComp : sInco);
    SetCustomToken(1018, iPally ? sComp : sInco);
    SetCustomToken(1019, iDrago ? sComp : sInco);
    SetCustomToken(1020, iDruid ? sComp : sInco);
    SetCustomToken(1021, iPengu ? sComp : sInco);
    SetCustomToken(1022, iBNote ? sComp : sInco);
    SetCustomToken(1023, iGRune ? sComp : sInco);
    SetCustomToken(1024, iCoBre ? sComp : sInco);
    SetCustomToken(1025, iTaxCo ? sComp : sInco);
    return TRUE;
}
