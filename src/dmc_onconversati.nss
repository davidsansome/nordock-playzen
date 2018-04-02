//::///////////////////////////////////////////////
//:: DM Console - OnConversation
//:: dmc_onconversati
//:: Copyright (c) 2003 Kelby Pethybridge.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Kelby Pethybridge
//:: Created On: 06 November 2003
//:://////////////////////////////////////////////

#include "dmc_main"

void main()
{
    object oPC = GetLastSpeaker();

    if(GetListenPatternNumber() == 2001 && GetTag(OBJECT_SELF) == GetPCPlayerName(oPC))
    {
        string sData = GetMatchedSubstring(0);
        string sCommand = getCommand(sData);
        string sPara = getPara(sData);

        if(sCommand == "GETIP" && GetIsDM(oPC))
            GetIP(sPara);
        else if(sCommand == "GETCD" && GetIsDM(oPC))
            GetCD(sPara);

        else if(sCommand == "BAN" && GetIsDM(oPC))
            Ban(sPara);
        else if(sCommand == "UNBAN" && GetIsDM(oPC))
            Unban(sPara);
        else if(sCommand == "BANLIST" && GetIsDM(oPC))
            BanList();
        else if(sCommand == "CLEARALLBANS" && GetIsDM(oPC))
            BanClear();

        else if(sCommand == "BOOT")
            Boot(sPara);
        else if(sCommand == "BOOTALL" && GetIsDM(oPC))
            BootAll();

        else if(sCommand == "FOLLOW")
            Follow();
        else if(sCommand == "STOPFOLLOW")
            StopFollow();

        else if(sCommand == "HELP")
            Help(sPara);

        else if(sCommand == "EXIT" || sCommand == "QUIT")
            Exit();
    }
}
