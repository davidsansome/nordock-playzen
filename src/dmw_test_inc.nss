#include "dmw_proto_inc"

int dmwand_isnearbydestroyable()
{
   object oMyTest = GetFirstObjectInShape(SHAPE_CUBE, 0.6, lMyLoc, FALSE, OBJECT_TYPE_ALL);
   int nTargetType = GetObjectType(oMyTest);
   return (GetIsObjectValid(oMyTest) && (! GetIsPC(oMyTest)) && ((nTargetType == OBJECT_TYPE_ITEM) || (nTargetType == OBJECT_TYPE_PLACEABLE) || (nTargetType == OBJECT_TYPE_CREATURE)));
}

int dmwand_istargetcreateable()
{
   if(! GetIsObjectValid(oMyTarget)) { return FALSE; }

   int nTargetType = GetObjectType(oMyTarget);
   return ((nTargetType == OBJECT_TYPE_ITEM) || (nTargetType == OBJECT_TYPE_PLACEABLE) || (nTargetType == OBJECT_TYPE_CREATURE));
}

int dmwand_istargetdestroyable()
{
   if(! GetIsObjectValid(oMyTarget)) { return FALSE; }

   int nTargetType = GetObjectType(oMyTarget);
   if(! GetIsPC(oMyTarget))
   {
      return ((nTargetType == OBJECT_TYPE_ITEM) || (nTargetType == OBJECT_TYPE_PLACEABLE) || (nTargetType == OBJECT_TYPE_CREATURE));
   }
   return FALSE;
}

int dmwand_istargetinvalid()
{
   return !GetIsObjectValid(oMyTarget);
}

int dmwand_istargetinventory()
{
   return (GetIsObjectValid(oMyTarget) && GetHasInventory(oMyTarget));
}

int dmwand_istargetnotme()
{
   return (GetIsObjectValid(oMyTarget) && (oMySpeaker != oMyTarget));
}

int dmwand_istargetnpc()
{
   return (dmwand_istargetpcornpc() && (! GetIsPC(oMyTarget)));
}

int dmwand_istargetpc()
{
   return (GetIsObjectValid(oMyTarget) && GetIsPC(oMyTarget));
}

int dmwand_istargetpcnme()
{
   return (GetIsObjectValid(oMyTarget) && GetIsPC(oMyTarget) && (oMySpeaker != oMyTarget));
}

int dmwand_istargetpcornpc()
{
   return (GetIsObjectValid(oMyTarget) && GetAbilityScore(oMyTarget, ABILITY_CONSTITUTION));
}

int dmwand_istargetpcornpcnme()
{
   return (dmwand_istargetpcornpc() && (oMySpeaker != oMyTarget));
}

int dmwand_istargetplaceable()
{
   if(! GetIsObjectValid(oMyTarget)) { return FALSE; }

   int nTargetType = GetObjectType(oMyTarget);
   return (nTargetType == OBJECT_TYPE_PLACEABLE);
}
