//hc_inc_htf
//
//Used for the Hunger, Thirst and Fatigue system (HTFSystem)
//
//Created Aug 10th, 2002.  by Edward Beck (0100010)
//
#include "hc_inc_stageday"
#include "hc_inc_fatigue"
#include "hc_text_htf"
#include "hc_inc_htfvars"

void SetAreaConsumeRateByVarName(object oArea, string VarName, float Multiplier, int DefRate)
{
    //Use a multiplier of 0 for default rates, and -1 to turn it off. Positive values
    //multiply the consumption rate by the given value
    if (Multiplier < 0.0)
        SetLocalInt(oArea, VarName, -1);
    else if (Multiplier > 0.0)
        SetLocalInt(oArea, VarName, FloatToInt(DefRate * Multiplier));
}

void SetAreaConsumeRates(object oArea, int stageofday, float fHRMultiplier, float fTRMultiplier, float fFRMultiplier)
{
    string time_suffix = GetStageOfDaySuffix(stageofday);
    SetAreaConsumeRateByVarName(oArea, "HUNGERCONSUMERATE"  + time_suffix, fHRMultiplier, DEFHUNGERCONSUMERATE);
    SetAreaConsumeRateByVarName(oArea, "THIRSTCONSUMERATE"  + time_suffix, fTRMultiplier, DEFTHIRSTCONSUMERATE);
    SetAreaConsumeRateByVarName(oArea, "FATIGUECONSUMERATE" + time_suffix, fFRMultiplier, DEFFATIGUECONSUMERATE);
}

void TurnOffAreaConsumeRates(object oArea)
{
    SetAreaConsumeRates(oArea,DAY,-1.0,-1.0,-1.0);
    SetAreaConsumeRates(oArea,DAWN,-1.0,-1.0,-1.0);
    SetAreaConsumeRates(oArea,DUSK,-1.0,-1.0,-1.0);
    SetAreaConsumeRates(oArea,NIGHT,-1.0,-1.0,-1.0);
}

void ClearAreaConsumeRates(object oArea)
{
    SetAreaConsumeRates(oArea,DAY,0.0,0.0,0.0);
    SetAreaConsumeRates(oArea,DAWN,0.0,0.0,0.0);
    SetAreaConsumeRates(oArea,DUSK,0.0,0.0,0.0);
    SetAreaConsumeRates(oArea,NIGHT,0.0,0.0,0.0);
}

void InitPCHTFLevelVarByType(string VarName,int InitialLevel)
{
   if (GetLocalInt(GetModule(),VarName)<=0)
        SetLocalInt(GetModule(),VarName,InitialLevel);
}

void InitPCHTFLevels(object oPC)
{
    if (!GetIsPC(oPC)) return;
    int iHUNGERSYSTEM = GetLocalInt(GetModule(),"HUNGERSYSTEM");
    int iFATIGUESYSTEM = GetLocalInt(GetModule(),"FATIGUESYSTEM");
    if (iHUNGERSYSTEM) {
        InitPCHTFLevelVarByType("HUNGERLEVEL"  + GetName(oPC) + GetPCPublicCDKey(oPC), INITHUNGERLEVEL);
        InitPCHTFLevelVarByType("THIRSTLEVEL"  + GetName(oPC) + GetPCPublicCDKey(oPC), INITTHIRSTLEVEL);
    }
    if (iFATIGUESYSTEM)
        InitPCHTFLevelVarByType("FATIGUELEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC), INITFATIGUELEVEL);
}

int IsPCHTFLevelByVarNameLow(string VarName, int InitialLevel)
{
    if (IntToFloat(GetLocalInt(GetModule(),VarName)) <= InitialLevel * RESTRESTRICTIONPERCENT)
        return 1;
    return 0;
}

int IsPCVeryHungryOrThirsty(object oPC)
{
    if (!GetIsPC(oPC)) return 0;
    int HungerRating = IsPCHTFLevelByVarNameLow("HUNGERLEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC),INITHUNGERLEVEL);
    int ThirstRating = IsPCHTFLevelByVarNameLow("THIRSTLEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC),INITTHIRSTLEVEL);
    if (HungerRating && !ThirstRating) return 1;
    if (!HungerRating && ThirstRating) return 2;
    if (HungerRating && ThirstRating) return 3;
    return 0;
}

void ResetHTFLevels(object oPC)
{
    if (!GetIsPC(oPC)) return;
    SetLocalInt(GetModule(),"HUNGERLEVEL"  + GetName(oPC) + GetPCPublicCDKey(oPC), INITHUNGERLEVEL);
    SetLocalInt(GetModule(),"THIRSTLEVEL"  + GetName(oPC) + GetPCPublicCDKey(oPC), INITTHIRSTLEVEL);
    SetLocalInt(GetModule(),"FATIGUELEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC), INITFATIGUELEVEL);
}

void ApplyHungerBonus(string sItemTag, object oPC)
{
    if (FindSubString(sItemTag,"FOOD") == -1)
        return;
    int oldlevel = GetLocalInt(GetModule(), "HUNGERLEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC));
    int newlevel = oldlevel + NORM;
    if (FindSubString(sItemTag,"RICH") != -1)
        newlevel = oldlevel + RICH;
    else if (FindSubString(sItemTag,"POOR") != -1)
        newlevel = oldlevel + POOR;

    if (newlevel > FloatToInt(INITHUNGERLEVEL * (1.0 + buffer))) {
        newlevel = FloatToInt(INITHUNGERLEVEL * (1.0 + buffer));
        SendMessageToPC(oPC,STUFFED);
    }
    SetLocalInt(GetModule(),"HUNGERLEVEL"  + GetName(oPC) + GetPCPublicCDKey(oPC), newlevel);
}

void ApplyAlcoholEffectToPC(string sItemTag, object oPC)
{
    int IntLoss;
    if (FindSubString(sItemTag,"ALCOHOL5")!=-1)
        IntLoss = 5;
    else if (FindSubString(sItemTag,"ALCOHOL4")!=-1)
        IntLoss = 4;
    else if (FindSubString(sItemTag,"ALCOHOL3")!=-1)
        IntLoss = 3;
    else if (FindSubString(sItemTag,"ALCOHOL2")!=-1)
        IntLoss = 2;
    else
        IntLoss = 1;
    MakePCDrunk(oPC,IntLoss,BURP);
}

void ApplyThirstBonus(string sItemTag, object oPC)
{
    if (FindSubString(sItemTag,"DRINK") == -1)
        return;
    if (FindSubString(sItemTag,"ALCOHOL") != -1)
        ApplyAlcoholEffectToPC(sItemTag, oPC);
    int oldlevel = GetLocalInt(GetModule(), "THIRSTLEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC));
    int newlevel = oldlevel + MED;
    if (FindSubString(sItemTag,"HIGH") != -1)
        newlevel = oldlevel + HIGH;
    else if (FindSubString(sItemTag,"LOW") != -1)
        newlevel = oldlevel + LOW;
    if (newlevel > FloatToInt(INITTHIRSTLEVEL * (1.0 + buffer))) {
        newlevel = FloatToInt(INITTHIRSTLEVEL * (1.0 + buffer));
        SendMessageToPC(oPC,FULLYHYDRATED);
    }
    SetLocalInt(GetModule(),"THIRSTLEVEL"  + GetName(oPC) + GetPCPublicCDKey(oPC), newlevel);
}

void ApplyEnergyBonus(string sItemTag, object oPC)
{
    int oldlevel = GetLocalInt(GetModule(), "FATIGUELEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC));
    int newlevel = oldlevel;
    if (FindSubString(sItemTag,"ENERGY3") != -1)
        newlevel = oldlevel + ENERGY3;
    else if (FindSubString(sItemTag,"ENERGY2") != -1)
        newlevel = oldlevel + ENERGY2;
    else if (FindSubString(sItemTag,"ENERGY1") != -1)
        newlevel = oldlevel + ENERGY1;
    if (newlevel > INITFATIGUELEVEL)
        newlevel = INITFATIGUELEVEL;
    if (newlevel > oldlevel)
        SetLocalInt(GetModule(),"FATIGUELEVEL"  + GetName(oPC) + GetPCPublicCDKey(oPC), newlevel);
}

void ApplyHPBonus(string sItemTag, object oPC)
{
    int HPBONUS = 0;
    if (FindSubString(sItemTag,"HPBONUS5") != -1)
        HPBONUS = HPBONUS5;
    else if (FindSubString(sItemTag,"HPBONUS4") != -1)
        HPBONUS = HPBONUS4;
    else if (FindSubString(sItemTag,"HPBONUS3") != -1)
        HPBONUS = HPBONUS3;
    else if (FindSubString(sItemTag,"HPBONUS2") != -1)
        HPBONUS = HPBONUS2;
    else if (FindSubString(sItemTag,"HPBONUS1") != -1)
        HPBONUS = HPBONUS1;
    if (HPBONUS > 0) {
        effect eVis = EffectVisualEffect(VFX_IMP_HEALING_S);
        effect eHeal = EffectHeal(HPBONUS);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
    }
}

void ApplyPoisonEffectToPC(object oPC, string sItemTag)
{
    int poisontype;
    if (FindSubString(sItemTag,"POISON5")!=-1)
        poisontype = POISONTYPE5;
    else if (FindSubString(sItemTag,"POISON4")!=-1)
        poisontype = POISONTYPE4;
    else if (FindSubString(sItemTag,"POISON3")!=-1)
        poisontype = POISONTYPE3;
    else if (FindSubString(sItemTag,"POISON2")!=-1)
        poisontype = POISONTYPE2;
    else
        poisontype = POISONTYPE1;

    effect ePoison = EffectPoison(poisontype);
    effect eVis = EffectVisualEffect(VFX_IMP_POISON_S);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoison, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
}

void ApplyDiseaseEffectToPC(object oPC, string sItemTag)
{
    int diseasetype;
    if (FindSubString(sItemTag,"DISEASE5")!=-1)
        diseasetype = DISEASETYPE5;
    else if (FindSubString(sItemTag,"DISEASE4")!=-1)
        diseasetype = DISEASETYPE4;
    else if (FindSubString(sItemTag,"DISEASE3")!=-1)
        diseasetype = DISEASETYPE3;
    else if (FindSubString(sItemTag,"DISEASE2")!=-1)
        diseasetype = DISEASETYPE2;
    else
        diseasetype = DISEASETYPE1;
    effect eDisease = EffectDisease(diseasetype);
    effect eVis = EffectVisualEffect(VFX_IMP_DISEASE_S);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDisease, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
}

int UseFoodOrDrinkItem(object oPC, object oItem, string sItemTag = "")
{
    if (oItem != OBJECT_INVALID)
        sItemTag = GetTag(oItem);
    sItemTag = GetStringUpperCase(sItemTag);
    int iPOISON = (FindSubString(sItemTag,"POISON") != -1);
    int iDISEASE = (FindSubString(sItemTag,"DISEASE") != -1);
    int isFood = (FindSubString(sItemTag,"FOOD") != -1);
    int isDrink = (FindSubString(sItemTag,"DRINK") != -1);

    if (!iPOISON && !iDISEASE) {
        int hlevel = GetLocalInt(GetModule(), "HUNGERLEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC));
        int tlevel = GetLocalInt(GetModule(), "THIRSTLEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC));
        if (isDrink && isFood) {
            if ((hlevel == FloatToInt(INITHUNGERLEVEL * (1.0 + buffer))) &&
                (tlevel == FloatToInt(INITTHIRSTLEVEL * (1.0 + buffer)))) {
                SendMessageToPC(oPC,NOTHUNGRY);
                return 0;
            }
        }
        else if (isFood) {
            if (hlevel == FloatToInt(INITHUNGERLEVEL * (1.0 + buffer))) {
                SendMessageToPC(oPC,NOTHUNGRY);
                return 0;
            }
        }
        else if (isDrink) {
            if (tlevel == FloatToInt(INITTHIRSTLEVEL * (1.0 + buffer))) {
                SendMessageToPC(oPC,NOTTHIRSTY);
                return 0;
            }
        }
        else
            return 0;
        ApplyHungerBonus(sItemTag, oPC);
        ApplyThirstBonus(sItemTag, oPC);
        ApplyEnergyBonus(sItemTag, oPC);
        ApplyHPBonus(sItemTag, oPC);
        if (oItem != OBJECT_INVALID)
            DestroyObject(oItem);
        else {
            if (FindSubString(sItemTag,"Food") != -1) SendMessageToPC(oPC,TAKEABITE);
            else if (FindSubString(sItemTag,"Drink") != -1) SendMessageToPC(oPC,TAKEADRINK);
        }
    }
    else if (isFood || isDrink) {
        if (!iDISEASE)
            ApplyPoisonEffectToPC(oPC, sItemTag);
        else
            ApplyDiseaseEffectToPC(oPC, sItemTag);
        if (oItem != OBJECT_INVALID)
            DestroyObject(oItem);
        return -1;
    }
    else
        return 0;

    return 1;
}

void UseCanteenCharge(object oPC, object oCanteen)
{
    string srctag = GetLocalString(oCanteen,"SRCTAG");
    int charges = GetLocalInt(oCanteen,"CHARGES");
    int usecharge = UseFoodOrDrinkItem(oPC,OBJECT_INVALID,srctag);
    if (usecharge == 1) {
        SetLocalInt(oCanteen,"CHARGES",charges - 1);
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        DelayCommand(1.5,FloatingTextStringOnCreature(GULP, oPC));
    }
    else if (usecharge == -1) {
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        SendMessageToPC(oPC,FOULWATER);
        SetLocalInt(oCanteen,"CHARGES",0);
        SetLocalString(oCanteen,"SRCTAG","");
    }
    else if (FindSubString(GetStringUpperCase(srctag),"DRINK")==-1)
    {
        SendMessageToPC(oPC, "Invalid water source tag '" + srctag + "' assigned to canteen, inform DM");
        SendMessageToPC(oPC, "Resetting Canteen.");
        SetLocalInt(oCanteen,"CHARGES",0);
        SetLocalString(oCanteen,"SRCTAG","");
    }
}

void ReFillCanteen(object oPC, object oCanteen, object oTarget, string sItemTag = "")
{
    int charges = GetLocalInt(oCanteen,"CHARGES");
    if (charges == MAXCANTEENCHARGES) {
        SendMessageToPC(oPC,CANTEENFULL);
        return;
    }
    if (oTarget != OBJECT_INVALID) {
        sItemTag = GetTag(oTarget);
        if (GetDistanceBetween(oPC,oTarget) > 3.0) {
            SendMessageToPC(oPC,MOVECLOSERTOOBJ);
            return;
        }
    }
    else
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,3.0));

    SetLocalInt(oCanteen,"CHARGES",MAXCANTEENCHARGES);
    SetLocalString(oCanteen,"SRCTAG",sItemTag);
    SendMessageToPC(oPC,FILLCANTEEN);
}

void UseWaterCanteen(object oPC,object oCanteen, object oTarget, location loc)
{
    int Charges = GetLocalInt(oCanteen,"CHARGES");
    string srctag = GetLocalString(oCanteen,"SRCTAG");

    if (oTarget==OBJECT_INVALID) {
        if (GetDistanceBetweenLocations(loc,GetLocation(oPC)) > 3.0)
            SendMessageToPC(oPC,MOVECLOSERTOOBJ);
        else {
            string watersrc = GetLocalString(oPC,"WATERSRC");
            if (FindSubString(GetStringUpperCase(watersrc),"DRINK")==-1)
                SendMessageToPC(oPC,NOWATERHERE);
            else
                ReFillCanteen(oPC,oCanteen,OBJECT_INVALID,watersrc);
        }
    }
    else {
        if (GetObjectType(oTarget)==OBJECT_TYPE_CREATURE) {
            if (oTarget==oPC) {
                if (Charges)
                    UseCanteenCharge(oPC,oCanteen);
                else
                    SendMessageToPC(oPC,EMPTYCANTEEN);
            }
            else
                SendMessageToPC(oPC,CANTEENBADTARGET);
        }
        if (GetObjectType(oTarget)==OBJECT_TYPE_PLACEABLE) {
            if (FindSubString(GetStringUpperCase(GetTag(oTarget)),"DRINK")!=-1)
                ReFillCanteen(oPC,oCanteen,oTarget);
            else
                SendMessageToPC(oPC,INVALIDWATERSRC);
        }
    }
}

void DoAutoEatDrink(object oPC, string itemtype)
{
    object oEquip = GetFirstItemInInventory(oPC);
    itemtype = GetStringUpperCase(itemtype);
    if (itemtype == "FOOD")
        SendMessageToPC(oPC,SEARCHFOOD);
    if (itemtype == "DRINK")
        SendMessageToPC(oPC,SEARCHDRINK);
    while(GetIsObjectValid(oEquip)) {
        if ((FindSubString(GetStringUpperCase(GetTag(oEquip)), itemtype)!= -1) ||
          (itemtype == "DRINK" && GetTag(oEquip) == "WaterCanteen"))
            break;
        oEquip = GetNextItemInInventory(oPC);
    }
    int founditem = 0;
    if (GetIsObjectValid(oEquip)) {
        if (GetTag(oEquip)!="WaterCanteen")
            founditem = UseFoodOrDrinkItem(oPC, oEquip);
        else {
            if (GetLocalInt(oEquip,"CHARGES") > 0) {
                UseCanteenCharge(oPC, oEquip);
                founditem = TRUE;
            }
        }
    }
    if (!founditem)
        SendMessageToPC(oPC,FAILEDTOFINDCONSUMABLE);
}

void DoDeathByStarvation(object oPC)
{
    int iHP = GetCurrentHitPoints(oPC);
    effect eKillPC = EffectDamage(iHP + 11);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eKillPC,oPC);
    DeleteLocalInt(GetModule(),"STARVATIONSAVES" + GetName(oPC) + GetPCPublicCDKey(oPC));
    ResetHTFLevels(oPC);
    SendMessageToPC(oPC, DEATHBYSTARVATION);
}

void DoHungerChkOnPC(object oPC)
{
    if (!GetIsPC(oPC)) return;
    int consumerate = GetLocalInt(GetArea(oPC),"HUNGERCONSUMERATE" + GetStageOfDaySuffix(GetStageOfDay()));
    if (consumerate==0) consumerate = DEFHUNGERCONSUMERATE;
    if (consumerate < 0) return;

    int oldlevel = GetLocalInt(GetModule(),"HUNGERLEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC));
    int newlevel = oldlevel - consumerate;
    if (newlevel < 1) newlevel = 1;

    SetLocalInt(GetModule(),"HUNGERLEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC), newlevel);
    if ((IntToFloat(newlevel) <= (INITHUNGERLEVEL*0.8)) && (IntToFloat(newlevel) > INITHUNGERLEVEL*0.6)) {
        SendMessageToPC(oPC, TOOHUNGRY0);
        if (AUTOEATDRINK && (AUTOEATDRINKRATE == 1))
            DoAutoEatDrink(oPC,"Food");
    }
    if ((IntToFloat(newlevel) <= (INITHUNGERLEVEL*0.6)) && (IntToFloat(newlevel) > INITHUNGERLEVEL*0.4)) {
        FloatingTextStringOnCreature (HUNGRYGROWL, oPC);
        SendMessageToPC(oPC, TOOHUNGRY1);
        if (AUTOEATDRINK && (AUTOEATDRINKRATE <= 2))
            DoAutoEatDrink(oPC,"Food");
    }
    if ((IntToFloat(newlevel) <= (INITHUNGERLEVEL*0.4)) && (IntToFloat(newlevel) > INITHUNGERLEVEL*0.2)) {
        FloatingTextStringOnCreature (HUNGRYGROWL, oPC);
        SendMessageToPC(oPC, TOOHUNGRY2);
        if (AUTOEATDRINK && (AUTOEATDRINKRATE <= 3))
            DoAutoEatDrink(oPC,"Food");
    }
    if ((IntToFloat(newlevel) <= (INITHUNGERLEVEL*0.2)) && (newlevel > 1)) {
        FloatingTextStringOnCreature (HUNGRYGROWL, oPC);
        SendMessageToPC(oPC, TOOHUNGRY3);
        MakePlayerFatigued(oPC, LACKOFFOOD1);
        if (AUTOEATDRINK)
            DoAutoEatDrink(oPC,"Food");
    }
    if (newlevel == 1) {
        FloatingTextStringOnCreature (HUNGRYGROWL, oPC);
        SendMessageToPC(oPC, TOOHUNGRY4);
        int iStarvationSaves = GetLocalInt(GetModule(),"STARVATIONSAVES" + GetName(oPC) + GetPCPublicCDKey(oPC));
        int iFortSave = FortitudeSave(oPC,iStarvationSaves);
        MakePlayerExhausted(oPC,LACKOFFOOD2);
        if (iFortSave) {
            SendMessageToPC(oPC, FORTSAVEVSSTARVATION);
            SetLocalInt(GetModule(),"STARVATIONSAVES" + GetName(oPC) + GetPCPublicCDKey(oPC), iStarvationSaves + 5);
            if (AUTOEATDRINK)
                DoAutoEatDrink(oPC,"Food");
        }
        else
           DoDeathByStarvation(oPC);
    }
}

void DoDeathByDehydration(object oPC)
{
    int iHP = GetCurrentHitPoints(oPC);
    effect eKillPC = EffectDamage(iHP + 11);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eKillPC,oPC);
    DeleteLocalInt(GetModule(),"DEHYDRATIONSAVES" + GetName(oPC) + GetPCPublicCDKey(oPC));
    ResetHTFLevels(oPC);
    SendMessageToPC(oPC, DEATHBYDEHYDRATION);
}

void DoThirstChkOnPC(object oPC)
{
    if (!GetIsPC(oPC)) return;
    int consumerate = GetLocalInt(GetArea(oPC),"THIRSTCONSUMERATE" + GetStageOfDaySuffix(GetStageOfDay()));
    if (consumerate==0) consumerate = DEFTHIRSTCONSUMERATE;
    if (consumerate < 0) return;

    int oldlevel = GetLocalInt(GetModule(),"THIRSTLEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC));
    int newlevel = oldlevel - consumerate;
    if (newlevel < 1) newlevel = 1;

    SetLocalInt(GetModule(),"THIRSTLEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC), newlevel);
    if ((IntToFloat(newlevel) <= (INITTHIRSTLEVEL*0.8)) && (IntToFloat(newlevel) > INITTHIRSTLEVEL*0.6)) {
        SendMessageToPC(oPC, TOOTHIRSTY0);
        if (AUTOEATDRINK && (AUTOEATDRINKRATE == 1))
            DoAutoEatDrink(oPC,"Drink");
    }
    if ((IntToFloat(newlevel) <= (INITTHIRSTLEVEL*0.6)) && (IntToFloat(newlevel) > INITTHIRSTLEVEL*0.4)) {
        SendMessageToPC(oPC, TOOTHIRSTY1);
        if (AUTOEATDRINK && (AUTOEATDRINKRATE <= 2))
            DoAutoEatDrink(oPC,"Drink");
    }
    if ((IntToFloat(newlevel) <= (INITTHIRSTLEVEL*0.4)) && (IntToFloat(newlevel) > INITTHIRSTLEVEL*0.2)) {
        FloatingTextStringOnCreature (THIRSTYMSG, oPC);
        SendMessageToPC(oPC, TOOTHIRSTY2);
        if (AUTOEATDRINK && (AUTOEATDRINKRATE <= 3))
            DoAutoEatDrink(oPC,"Drink");
    }
    if ((IntToFloat(newlevel) <= (INITTHIRSTLEVEL*0.2)) && (newlevel > 1)) {
        FloatingTextStringOnCreature (THIRSTYMSG, oPC);
        SendMessageToPC(oPC, TOOTHIRSTY3);
        MakePlayerFatigued(oPC, LACKOFWATER1);
        if (AUTOEATDRINK)
            DoAutoEatDrink(oPC,"Drink");
    }
    if (newlevel == 1) {
        FloatingTextStringOnCreature (THIRSTYMSG, oPC);
        SendMessageToPC(oPC, TOOTHIRSTY4);
        int iDehydrationSaves = GetLocalInt(GetModule(),"DEHYDRATIONSAVES" + GetName(oPC) + GetPCPublicCDKey(oPC));
        int iFortSave = FortitudeSave(oPC,iDehydrationSaves);
        MakePlayerExhausted(oPC,LACKOFWATER2);
        if (iFortSave) {
            SendMessageToPC(oPC, FORTSAVEVSDEHYDRATION);
            SetLocalInt(GetModule(),"DEHYDRATIONSAVES" + GetName(oPC) + GetPCPublicCDKey(oPC), iDehydrationSaves + 5);
            if (AUTOEATDRINK)
                DoAutoEatDrink(oPC,"Drink");
        }
        else
           DoDeathByDehydration(oPC);
    }
}

void DoFatigueChkOnPC(object oPC)
{
    if (!GetIsPC(oPC)) return;
    int consumerate = GetLocalInt(GetArea(oPC),"FATIGUECONSUMERATE" + GetStageOfDaySuffix(GetStageOfDay()));
    if (consumerate==0) consumerate = DEFFATIGUECONSUMERATE;
    if (consumerate < 0) return;

    object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    if (GetItemACValue(oArmor) >= FATIGUEARMORPEN)
        consumerate  = FloatToInt(consumerate * FATIGUEARMORPENMULTIPLIER);


    int oldlevel = GetLocalInt(GetModule(),"FATIGUELEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC));
    int newlevel = oldlevel - consumerate;
    if (newlevel < 1) newlevel = 1;

    SetLocalInt(GetModule(),"FATIGUELEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC), newlevel);
    if ((IntToFloat(newlevel) <= (INITFATIGUELEVEL*0.8)) && (IntToFloat(newlevel) > INITFATIGUELEVEL*0.6))
        SendMessageToPC(oPC, TOOTIRED0);
    if ((IntToFloat(newlevel) <= (INITFATIGUELEVEL*0.6)) && (IntToFloat(newlevel) > INITFATIGUELEVEL*0.4)) {
        FloatingTextStringOnCreature (YAWN, oPC);
        SendMessageToPC(oPC, TOOTIRED1);
        AssignCommand (oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED));
    }
    if ((IntToFloat(newlevel) <= (INITFATIGUELEVEL*0.4)) && (IntToFloat(newlevel) > INITFATIGUELEVEL*0.2)) {
        FloatingTextStringOnCreature (YAWN, oPC);
        SendMessageToPC(oPC, TOOTIRED2);
        AssignCommand (oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED));
    }
    if ((IntToFloat(newlevel) <= (INITFATIGUELEVEL*0.2)) && (newlevel > 1)) {
        SendMessageToPC(oPC, TOOTIRED3);
        AssignCommand (oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED));
        AssignCommand (oPC,PlayVoiceChat(VOICE_CHAT_REST,oPC));
        MakePlayerFatigued(oPC, NOTENOUGHREST1);
    }
    if (newlevel == 1) {
        SendMessageToPC(oPC, TOOTIRED4);
        int iCollapseSaves = GetLocalInt(GetModule(),"FATIGUECOLLAPSESAVES" + GetName(oPC) + GetPCPublicCDKey(oPC));
        int iFortSave = FortitudeSave(oPC,iCollapseSaves);
        MakePlayerExhausted(oPC,NOTENOUGHREST2);
        if (iFortSave) {
           SendMessageToPC(oPC, FORTSAVEVSCOLLAPSE);
           SetLocalInt(GetModule(),"FATIGUECOLLAPSESAVES" + GetName(oPC) + GetPCPublicCDKey(oPC), iCollapseSaves + 5);
           AssignCommand (oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED));
           AssignCommand (oPC,PlayVoiceChat(VOICE_CHAT_REST,oPC));
        }
        else {
           MakePlayerCollapse(oPC,COLLAPSEFROMEXHAUSTION);
           SetLocalInt(GetModule(),"FATIGUELEVEL" + GetName(oPC) + GetPCPublicCDKey(oPC), FloatToInt(INITFATIGUELEVEL*0.25));
        }
    }
}

void LoopHTFSystemChk()
{
    int iHUNGERSYSTEM = GetLocalInt(GetModule(),"HUNGERSYSTEM");
    int iFATIGUESYSTEM = GetLocalInt(GetModule(),"FATIGUESYSTEM");
    if (!iHUNGERSYSTEM && !iFATIGUESYSTEM) return;

    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID) {
        if (!GetIsDM(oPC)) {
            if (iHUNGERSYSTEM) {
                DoHungerChkOnPC(oPC);
                DoThirstChkOnPC(oPC);
            }
            if (iFATIGUESYSTEM)
                DoFatigueChkOnPC(oPC);
        }
        oPC = GetNextPC();
    }
}

void ApplyHTFOverTime(int MinutesAdvanced, int applyfatigue = FALSE)
{
    int iterations = MinutesAdvanced / HTFCHKTIMER;
    int counter;
    object oPC;
    for (counter = 0; counter < iterations; counter++) {
        oPC = GetFirstPC();
        while (oPC != OBJECT_INVALID) {
            if (!GetIsDM(oPC)) {
                DoHungerChkOnPC(oPC);
                DoThirstChkOnPC(oPC);
                if (applyfatigue)
                    DoFatigueChkOnPC(oPC);
            }
            oPC = GetNextPC();
        }
    }
}
