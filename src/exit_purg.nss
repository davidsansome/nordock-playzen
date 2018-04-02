void main()
{
      object oMod=GetModule();
      object oPC=GetExitingObject();
      string sCDK=GetPCPublicCDKey(oPC);
      SetLocalInt(oMod,"purgatory"+sCDK+GetName(oPC), FALSE);
}
