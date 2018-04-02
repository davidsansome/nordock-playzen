object oPC = GetLastOpenedBy();


void main()
{
    if (GetIsPC(oPC))
    {
        location sLoc=GetLocation(oPC);
        CreateObject(OBJECT_TYPE_CREATURE,"Negan",sLoc);
        DestroyObject(OBJECT_SELF, 1.0);
     }
}
