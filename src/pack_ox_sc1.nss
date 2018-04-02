int StartingConditional()
{

if (GetPCSpeaker() == GetLocalObject(OBJECT_SELF, "PACK_OWNER")) { return TRUE; }

return FALSE;


}
