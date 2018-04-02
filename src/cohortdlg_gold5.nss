void main()
{
    GiveGoldToCreature(GetPCSpeaker(), 100);
    TakeGoldFromCreature(100, OBJECT_SELF, TRUE);
}
