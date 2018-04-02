void main()
{
    object oStore = GetObjectByTag("tha_furnishop");

    if(oStore == OBJECT_INVALID)
        oStore = CreateObject(OBJECT_TYPE_STORE,"furniturestore",GetLocation(OBJECT_SELF));

    OpenStore(oStore,GetPCSpeaker());
}
