void main()
{
    object oItem=GetPCItemLastUnequipped();

    SetLocalInt(oItem, "RecentlyUnEquipped", 1);
    DelayCommand(0.1, DeleteLocalInt(oItem, "RecentlyUnEquipped"));
}
