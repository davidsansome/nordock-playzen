//::///////////////////////////////////////////////
//:: DM Console - Main
//:: dmc_main
//:: Copyright (c) 2003 Kelby Pethybridge.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Kelby Pethybridge
//:: Created On: 07 November 2003
//:://////////////////////////////////////////////

/* TODO:
//   Boot player when CD-Key is baned [BanCD()].
//   Port to player, port player to me, port player and there party to me [PortToPlayer(), PortToMe(), PortPartyToMe()].
*/

#include "aps_include"


// Spawn the DM Console.
void spawn(object oPC);

// Get the Command typed to the DM Console.
string getCommand(string sData);
// Get the Parameters typed to the DM Console.
string getPara(string sData);

// Get an accounts IP.
void GetIP(string sPara);
// Get an accounts CD-Key
void GetCD(string sPara);

// Ban an account and CD-Key.
void Ban(string sPara);
// Unban an account and CD-Key.
void Unban(string sPara);
// List all bans to all DM's.
void BanList();
// Clear the ban list.
// WARNING: This will remove all bans tied to this server.
void BanClear();

// Boot an account from the server.
void Boot(string sPara);
// Boots all non DM players from the server.
void BootAll();

// Returns the name of the character with the account sPara.
void GetPlayerName(string sPara);

// Resets the currant running module with a delay of sPara seconds.
void Reset(string sPara);
// Saves all characters on the curant module.
void Save();

// Polymorph a player
void Poly(string sPara);
// Unolymorph a player
void Unpoly(string sPara);

// DM Consloe will follow its owner.
void Follow();
// DM Consloe will stop following its owner.
void StopFollow();

// Send help information to all DM's
void Help(string sPara);

// Exit the DM Console.
void Exit();



void spawn(object oPC)
{
    DestroyObject(GetNearestObjectByTag(GetTag(oPC)));

    object oCreature = CreateObject(OBJECT_TYPE_CREATURE, "DMConsole", GetLocation(oPC), FALSE, GetPCPlayerName(oPC));

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectInvisibility(INVISIBILITY_TYPE_IMPROVED), oCreature);

    AssignCommand(oCreature, ActionForceFollowObject(oPC, 3.0));
}


string getCommand(string sData)
{
    return GetStringUpperCase(GetSubString(sData, 0, FindSubString(sData, " ")));
}


string getPara(string sData)
{
    return GetSubString(sData, FindSubString(sData, " ") + 1, GetStringLength(sData) - FindSubString(sData, " "));
}


void GetIP(string sPara)
{
    string sParaL = GetStringLowerCase(sPara);

    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        string sName = GetStringLowerCase(GetName(oPC));
        string sAccount = GetStringLowerCase(GetPCPlayerName(oPC));
        if ((FindSubString(sName, sParaL) != -1) || (FindSubString(sAccount, sParaL) != -1))
            SendMessageToAllDMs("PC '" + sName + "' IP: " + GetPCIPAddress(oPC));
        oPC = GetNextPC();
    }
}


void GetCD(string sPara)
{
    string sParaL = GetStringLowerCase(sPara);

    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        string sName = GetStringLowerCase(GetName(oPC));
        string sAccount = GetStringLowerCase(GetPCPlayerName(oPC));
        if ((FindSubString(sName, sParaL) != -1) || (FindSubString(sAccount, sParaL) != -1))
            SendMessageToAllDMs("PC '" + sName + "' CD-Key: " + GetPCPublicCDKey(oPC));
        oPC = GetNextPC();
    }
}


void Ban(string sPara)
{
    string sParaL = GetStringLowerCase(sPara);

    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        string sName = GetStringLowerCase(GetName(oPC));
        string sAccount = GetStringLowerCase(GetPCPlayerName(oPC));

        if ((FindSubString(sName, sParaL) != -1) || (FindSubString(sAccount, sParaL) != -1))
        {
            SQLExecDirect("INSERT INTO `nordock_banlist` (`cdkey`,`accountname`)" +
                          " VALUES ('" + SQLEncodeSpecialChars(GetPCPublicCDKey(oPC)) + "'," +
                          "'" + SQLEncodeSpecialChars(GetPCPlayerName(oPC)) + "')");
            SendMessageToAllDMs("Added to ban list '" + GetName(oPC) + "' CD-Key: " + GetPCPublicCDKey(oPC));
            BootPC(oPC);
        }
        oPC = GetNextPC();
    }
}

void Unban(string sPara)
{
    SQLExecDirect("SELECT `cdkey`,`accountname` FROM `nordock_banlist` WHERE LOCATE('" + SQLEncodeSpecialChars(sPara) + "',`accountname`) LIMIT 1");
    if (SQLFetch() == SQL_ERROR)
        SendMessageToAllDMs(sPara + " not found in ban list");
    else
    {
        string sCdKey = SQLGetData(1);
        string sName = SQLGetData(2);

        SQLExecDirect("DELETE FROM `nordock_banlist` WHERE `cdkey` = '" + SQLEncodeSpecialChars(sCdKey) + "' LIMIT 1");
        SendMessageToAllDMs(sCdKey + " (" + sName + ") removed from ban list");
    }
}


void BanList()
{
    SQLExecDirect("SELECT `cdkey`,`accountname` FROM `nordock_banlist`");

    while (SQLFetch() != SQL_ERROR)
    {
        string sCdKey = SQLGetData(1);
        string sName = SQLGetData(2);

        SendMessageToAllDMs(sCdKey + " (" + sName + ")");
    }
}


void BanClear()
{
    SQLExecDirect("DELETE FROM `nordock_banlist`");
    SendMessageToAllDMs("All bans removed");
}


void Boot(string sPara)
{
    string sParaL = GetStringLowerCase(sPara);

    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        string sName = GetStringLowerCase(GetName(oPC));
        string sAccount = GetStringLowerCase(GetPCPlayerName(oPC));

        if ((FindSubString(sName, sParaL) != -1) || (FindSubString(sAccount, sParaL) != -1))
            BootPC(oPC);

        oPC = GetNextPC();
    }
}


void BootAll()
{
    object oPC = GetFirstPC();

    while(GetIsObjectValid(oPC))
    {
        if(!GetIsDM(oPC))
            BootPC(oPC);

        oPC = GetNextPC();
    }
}
void Follow()
{
    ActionForceFollowObject(GetLastSpeaker(), 3.0);

    SendMessageToAllDMs(GetName(OBJECT_SELF) + "is now following " + GetName(GetLastSpeaker()) + ".");
}


void StopFollow()
{
    ClearAllActions();

    SendMessageToAllDMs(GetName(OBJECT_SELF) + " stoped following " + GetName(GetLastSpeaker()) + ".");
}


void Help(string sPara)
{
    SendMessageToAllDMs("Ban commands: banlist, ban <name>, unban <name>, clearallbans");
    SendMessageToAllDMs("Boot commands: boot <name>, bootall");
    SendMessageToAllDMs("Info commands: getip <name>, getcd <name>");
    SendMessageToAllDMs("DM console commands: follow, stopfollow, quit");
}


void Exit()
{
    DestroyObject(OBJECT_SELF);
}

// void main() {}
