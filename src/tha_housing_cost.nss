int SMALL_HOUSE_COST = 15000;
int MED_HOUSE_COST = 30000;
int LARGE_HOUSE_COST = 60000;

void DestroyAllKeysOfType(object oPC, string sTag)
{
    int iNum = 0;
    sTag = sTag+"_house_key";

    object oObjectToDestroy = GetObjectByTag(sTag, iNum++);


    while(oObjectToDestroy != OBJECT_INVALID)
    {
        if(GetItemPossessor(oObjectToDestroy) == oPC)
            DestroyObject(oObjectToDestroy);
        oObjectToDestroy = GetObjectByTag(sTag, iNum++);
    }

}
