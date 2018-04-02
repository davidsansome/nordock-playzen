void ActionCreate(string sCreature, location lLoc, object oPC)
{
    object oCreature = CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLoc);
    AssignCommand(oCreature, ActionAttack(oPC));
}

void ActionSpawn(object oPC, object oBones)
{
    effect eMind = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    string sCreature = "elghkhelulsaruk";
    location lLoc = GetLocation(oBones);
    DelayCommand(0.3, ActionCreate(sCreature, lLoc, oPC));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMind, lLoc);
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "RespawnWait") == 1)
        return;
    SetLocalInt(OBJECT_SELF, "RespawnWait", 1);
    DelayCommand(180.f, SetLocalInt(OBJECT_SELF, "RespawnWait", 0));

    object oPC = GetEnteringObject();
    object oBones = GetNearestObjectByTag("NW_PL_SKELETON");

    float fDelay = 0.0f + d4();
    DelayCommand(fDelay, ActionSpawn(oPC, oBones));
}
