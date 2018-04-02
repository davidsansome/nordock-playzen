int StartingConditional()
{

if (GetReputation(OBJECT_SELF, GetPCSpeaker()) >= 90) { return TRUE; }
if (!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "PACK_OWNER"))) { return TRUE; }
return FALSE;

}
