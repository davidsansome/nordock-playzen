int StartingConditional()
{
    string sBlueprint = GetLocalString(OBJECT_SELF, "Recipe1");
    if (sBlueprint == "")
        return FALSE;
    return TRUE;
}
