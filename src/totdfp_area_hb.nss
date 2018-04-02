void main()
{
    object oChecker = GetObjectByTag("doordeath_checker");
    if(GetLocalInt(oChecker, "sDoorIsDestroyed") >= 1)
    {
        int iCount = GetLocalInt(oChecker, "sDoorIsDestroyed");
        iCount = iCount++;
        SetLocalInt(oChecker, "sDoorIsDestroyed", iCount);

        if(iCount == 4)
        {
            location lDoor = GetLocalLocation(oChecker, "sDoorLocation");
            CreateObject(OBJECT_TYPE_PLACEABLE, "totd_riddledoor", lDoor, TRUE);
            SetLocalInt(oChecker, "sDoorIsDestroyed", 0);
        }
    }

}
