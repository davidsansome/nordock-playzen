int DMW_START_CUSTOM_TOKEN = 8000;

//Retrieve targetting information
object oMySpeaker = GetLastSpeaker();
object oMyTarget = GetLocalObject(oMySpeaker, "dmwandtarget");
location lMyLoc = GetLocalLocation(oMySpeaker, "dmwandloc");
