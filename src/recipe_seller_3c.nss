int StartingConditional()
{
    string sBlueprint = GetLocalString(OBJECT_SELF, "Recipe2");
    if (sBlueprint == "")
        return FALSE;
    return TRUE;
}
