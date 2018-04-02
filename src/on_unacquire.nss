void main()
{
    object oItem = GetModuleItemLost();
    object oPC = GetModuleItemLostBy();

    string sTag = GetTag(oItem);
    string sResRef = GetResRef(oItem);

    if(sResRef == "ahousedeed")
    {
        CopyObject(oItem,GetLocation(oPC),oPC,sTag);
        DestroyObject(oItem);
        FloatingTextStringOnCreature("You can not get rid of the house deed.",oPC);
    }

    return;
}
