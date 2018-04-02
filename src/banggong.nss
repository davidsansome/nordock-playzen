void main()
{
    PlaySound("as_cv_gongring3");
    if (GetObjectByTag("Riddler")==OBJECT_INVALID)
        CreateObject(OBJECT_TYPE_CREATURE, "riddler",GetLocation(GetObjectByTag("riddler")) ,TRUE);
}
