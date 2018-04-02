int StartingConditional()
{
    string sBlueprint = GetLocalString(OBJECT_SELF, "Recipe0");
    if (sBlueprint == "")
        return FALSE;
    return TRUE;
}
