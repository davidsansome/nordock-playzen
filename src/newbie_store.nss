void main()
{
    object oStore = GetObjectByTag("NewbieMerchant");
    object oPC = GetPCSpeaker();

    if (!GetIsObjectValid(oStore) || !GetIsObjectValid(oPC))
        return;

    OpenStore(oStore, GetPCSpeaker());
}
