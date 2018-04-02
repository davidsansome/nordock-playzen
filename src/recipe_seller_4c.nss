int StartingConditional()
{
    string sBlueprint = GetLocalString(OBJECT_SELF, "Recipe3");
    if (sBlueprint == "")
        return FALSE;
    return TRUE;
}
