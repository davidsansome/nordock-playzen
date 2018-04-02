void SetAssociateRelayPatterns()
{
    SetListenPattern(OBJECT_SELF, "ASSOCIATE_RELAY_COMMAND_ATTACKNEAREST", ASSOCIATE_COMMAND_ATTACKNEAREST+15000);
    SetListenPattern(OBJECT_SELF, "ASSOCIATE_RELAY_COMMAND_FOLLOWMASTER", ASSOCIATE_COMMAND_FOLLOWMASTER+15000);
    SetListenPattern(OBJECT_SELF, "ASSOCIATE_RELAY_COMMAND_GUARDMASTER", ASSOCIATE_COMMAND_GUARDMASTER+15000);
    SetListenPattern(OBJECT_SELF, "ASSOCIATE_RELAY_COMMAND_HEALMASTER", ASSOCIATE_COMMAND_HEALMASTER+15000);
    SetListenPattern(OBJECT_SELF, "ASSOCIATE_RELAY_COMMAND_LEAVEPARTY", ASSOCIATE_COMMAND_LEAVEPARTY+15000);
    SetListenPattern(OBJECT_SELF, "ASSOCIATE_RELAY_COMMAND_MASTERATTACKEDOTHER", ASSOCIATE_COMMAND_MASTERATTACKEDOTHER+15000);
    SetListenPattern(OBJECT_SELF, "ASSOCIATE_RELAY_COMMAND_MASTERFAILEDLOCKPICK", ASSOCIATE_COMMAND_MASTERFAILEDLOCKPICK+15000);
    SetListenPattern(OBJECT_SELF, "ASSOCIATE_RELAY_COMMAND_MASTERGOINGTOBEATTACKED", ASSOCIATE_COMMAND_MASTERGOINGTOBEATTACKED+15000);
    SetListenPattern(OBJECT_SELF, "ASSOCIATE_RELAY_COMMAND_MASTERSAWTRAP", ASSOCIATE_COMMAND_MASTERSAWTRAP+15000);
    SetListenPattern(OBJECT_SELF, "ASSOCIATE_RELAY_COMMAND_MASTERUNDERATTACK", ASSOCIATE_COMMAND_MASTERUNDERATTACK+15000);
    SetListenPattern(OBJECT_SELF, "ASSOCIATE_RELAY_COMMAND_STANDGROUND", ASSOCIATE_COMMAND_STANDGROUND+15000);

    SetListenPattern(OBJECT_SELF, "MRTEST", 3344);

}

void RelayCommand(int originalCommand)
{
    if (!GetIsPC(GetMaster()))
    {
        // only the first henchman should relay
        return;
    }
    int talkVolume = TALKVOLUME_SILENT_SHOUT;
    switch(originalCommand)
    {
        case ASSOCIATE_COMMAND_ATTACKNEAREST:
        {
            SpeakString("ASSOCIATE_RELAY_COMMAND_ATTACKNEAREST", talkVolume);
        }
        break;
        case ASSOCIATE_COMMAND_FOLLOWMASTER:
        {
            SpeakString("ASSOCIATE_RELAY_COMMAND_FOLLOWMASTER", talkVolume);
        }
        break;
        case ASSOCIATE_COMMAND_GUARDMASTER:
        {
            SpeakString("ASSOCIATE_RELAY_COMMAND_GUARDMASTER", talkVolume);
        }
        break;
        case ASSOCIATE_COMMAND_HEALMASTER:
        {
            SpeakString("ASSOCIATE_RELAY_COMMAND_HEALMASTER", talkVolume);
        }
        break;
        case ASSOCIATE_COMMAND_LEAVEPARTY:
        {
            SpeakString("ASSOCIATE_RELAY_COMMAND_LEAVEPARTY", talkVolume);
        }
        break;
        case ASSOCIATE_COMMAND_MASTERATTACKEDOTHER:
        {
            SpeakString("ASSOCIATE_RELAY_COMMAND_MASTERATTACKEDOTHER", talkVolume);
        }
        break;
        case ASSOCIATE_COMMAND_MASTERFAILEDLOCKPICK:
        {
            SpeakString("ASSOCIATE_RELAY_COMMAND_MASTERFAILEDLOCKPICK", talkVolume);
        }
        break;
        case ASSOCIATE_COMMAND_MASTERGOINGTOBEATTACKED:
        {
            SpeakString("ASSOCIATE_RELAY_COMMAND_MASTERGOINGTOBEATTACKED", talkVolume);
        }
        break;
        case ASSOCIATE_COMMAND_MASTERSAWTRAP:
        {
            SpeakString("ASSOCIATE_RELAY_COMMAND_MASTERSAWTRAP", talkVolume);
        }
        break;
        case ASSOCIATE_COMMAND_MASTERUNDERATTACK:
        {
            SpeakString("ASSOCIATE_RELAY_COMMAND_MASTERUNDERATTACK", talkVolume);
        }
        break;
        case ASSOCIATE_COMMAND_STANDGROUND:
        {
            SpeakString("ASSOCIATE_RELAY_COMMAND_STANDGROUND", talkVolume);
        }
        break;

    }
}

int IsInChainOfMasters(object candidateMaster)
{
    object endOfList = OBJECT_SELF;
    if (!GetIsObjectValid(GetMaster()))
    {
        return FALSE;
    }
    while(GetIsObjectValid(GetMaster(endOfList)))
    {
        if (GetMaster(endOfList) == candidateMaster)
        {
            return TRUE;
        }
        endOfList = GetMaster(endOfList);
    }
    return FALSE;
}

