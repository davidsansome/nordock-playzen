object oPC = GetLastOpenedBy();


void main()
{
    if (GetIsPC(oPC))
    {
        location sLoc=GetLocation(oPC);
        CreateObject(OBJECT_TYPE_CREATURE,"NW_ZOMBIE02",sLoc);
        DestroyObject(OBJECT_SELF, 1.0);
     }
}
