void main()
{
PlaySound( "as_cv_gongring3" );
location lLocation1 = GetLocation(GetObjectByTag("spawn1"));
location lLocation2 = GetLocation(GetObjectByTag("spawn2"));
location lLocation3 = GetLocation(GetObjectByTag("spawn3"));
location lLocation4 = GetLocation(GetObjectByTag("spawn4"));
object oFilreetrin = GetObjectByTag("filree");
object oFilreetrin001 = GetObjectByTag("shynt");
object oFilreetrin002 = GetObjectByTag("sorn");
object oFilreetrin003 = GetObjectByTag("tluth");
object oGong = GetObjectByTag("Gong");

if (GetLocalInt (oGong, "GongStatus") == 0)
    {
        CreateObject(OBJECT_TYPE_CREATURE, "filreetrin001", lLocation1, FALSE);
        CreateObject(OBJECT_TYPE_CREATURE, "filreetrin002", lLocation2, FALSE);
        CreateObject(OBJECT_TYPE_CREATURE, "filreetrin003", lLocation3, FALSE);
        CreateObject(OBJECT_TYPE_CREATURE, "filreetrin", lLocation4, FALSE);
        SetLocalInt (oGong, "GongStatus", 1);
    }
    else
    {
        DestroyObject(oFilreetrin);
        DestroyObject(oFilreetrin001);
        DestroyObject(oFilreetrin002);
        DestroyObject(oFilreetrin003);
        SetLocalInt (oGong, "GongStatus", 0);
    }


}
