//::///////////////////////////////////////////////
//:: NW_O2_SKELETON.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Turns the placeable into a skeleton
   if a player comes near enough.
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   January 17, 2002
//:://////////////////////////////////////////////
void ActionCreate(string sCreature, location lLoc)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLoc);
}
void ActionRespawn(location lLoc)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, "pl_skeleton", lLoc);
}
void main()
{
   object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
   if (GetIsObjectValid(oCreature) == TRUE && GetDistanceToObject(oCreature) < 10.0)
   {
    effect eMind = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    string sCreature = "elghkhelulsaruk";
    location lLoc = GetLocation(OBJECT_SELF);
    DelayCommand(0.3, ActionCreate(sCreature, lLoc));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMind, GetLocation(OBJECT_SELF));
    SetPlotFlag(OBJECT_SELF, FALSE);
    DestroyObject(OBJECT_SELF, 0.5);
    DelayCommand(180.0, ActionRespawn(lLoc));
   }
}
