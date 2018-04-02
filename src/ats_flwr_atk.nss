void main()
{
    // Get the Tag of Flower Plant
    string sFlowerPlantTag = GetTag(OBJECT_SELF);

    // Get length of that Tag
    int iTagLength = GetStringLength(sFlowerPlantTag);

    // Find the color of that Flower Plant

    string sFlowerTag = "ATS_FLOWER_" + GetStringRight(sFlowerPlantTag, iTagLength - 13);

    // prepare to create Flower on Player
    object oPlayer = GetLastUsedBy();

//    SendMessageToPC(oPlayer, sFlowerTag);          // Debug message


    // Give the Player the Flower
    CreateItemOnObject(sFlowerTag, oPlayer);
}
