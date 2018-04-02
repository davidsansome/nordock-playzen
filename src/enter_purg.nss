void main()
{
      object oMod=GetModule();
      object oPC=GetEnteringObject();
      string sCDK=GetPCPublicCDKey(oPC);
      SetLocalInt(oMod,"purgatory"+sCDK+GetName(oPC), TRUE);
}
