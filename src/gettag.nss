void main()
{
    object oItem = GetFirstItemInInventory();

    string sTag = GetTag(oItem);
    string sResRef = GetResRef(oItem);

    SpeakString(sTag);
    SpeakString(sResRef);

    int i;

    for(i = 0; i< 20; i++)
    {
        PrintString(IntToString(StringToInt(IntToString(i))));
    }
}


