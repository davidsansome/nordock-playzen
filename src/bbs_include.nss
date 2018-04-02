#include "aps_include"

string ConvertToDrow(string sLetter)
{
    string sTranslate = GetStringLowerCase(sLetter);
    string sRet = sLetter;
    if (sTranslate == "a") sRet = "r";
    else if (sTranslate == "b") sRet = "m";
    else if (sTranslate == "c") sRet = "o";
    else if (sTranslate == "d") sRet = "h";
    else if (sTranslate == "e") sRet = "a";
    else if (sTranslate == "f") sRet = "z";
    else if (sTranslate == "g") sRet = "y";
    else if (sTranslate == "h") sRet = "u";
    else if (sTranslate == "i") sRet = "i";
    else if (sTranslate == "j") sRet = "j";
    else if (sTranslate == "k") sRet = "p";
    else if (sTranslate == "l") sRet = "'";
    else if (sTranslate == "m") sRet = "d";
    else if (sTranslate == "n") sRet = "e";
    else if (sTranslate == "o") sRet = "n";
    else if (sTranslate == "p") sRet = "b";
    else if (sTranslate == "q") sRet = "x";
    else if (sTranslate == "r") sRet = "t";
    else if (sTranslate == "s") sRet = "s";
    else if (sTranslate == "t") sRet = "l";
    else if (sTranslate == "u") sRet = "k";
    else if (sTranslate == "v") sRet = "c";
    else if (sTranslate == "w") sRet = "g";
    else if (sTranslate == "x") sRet = "f";
    else if (sTranslate == "y") sRet = "v";
    else if (sTranslate == "z") sRet = "w";
    if (sTranslate == sLetter) // If it's a lower case letter
        return sRet;
    return GetStringUpperCase(sRet); // Upper case letter
}

string ProcessToDrow(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertToDrow(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

int BBS_GetIsUnderdark(object oPC)
{
    if (GetIsDM(oPC) || GetIsDM(GetMaster(oPC)))
        return 2;

    string sSubrace = GetStringLowerCase(GetSubRace(oPC));
    if ((sSubrace == "drow") || (sSubrace == "duergar"))
        return 1;
    return 0;
}


void BBS_LoadMessageList(object oPC)
{
    int iPage = GetLocalInt(oPC, "BBS_Page");
    int iUD = BBS_GetIsUnderdark(oPC);

    SQLExecDirect("SELECT `poster`,`title`,`underdark`,`key`" +
                  " FROM `nordock_bbs`" +
                  " WHERE `board` = '" + SQLEncodeSpecialChars(GetTag(OBJECT_SELF)) + "'" +
                  " ORDER BY `date` DESC" +
                  " LIMIT 6 OFFSET " + IntToString(iPage*5));

    int i=0;
    while ((i<5) && (SQLFetch() == SQL_SUCCESS))
    {
        string sPoster = SQLGetData(1);
        string sTitle = SQLGetData(2);
        int iUnderdark = StringToInt(SQLGetData(3));
        int iKey = StringToInt(SQLGetData(4));

        string sToken;
        if (iUnderdark == 2) // DM Post
            sToken = "<cþþ >" + sTitle + "</c><c fþ> by </c><cþþ >" + sPoster + "</c>";
        else
        {
            if ((iUD != 2) && (iUnderdark != iUD)) // Other race post
                sTitle = ProcessToDrow(sTitle);
            sToken = sTitle + "<c fþ> by </c>" + sPoster;
        }

        SetCustomToken(3680 + i, sToken);
        SetLocalInt(oPC, "BBS_Post_" + IntToString(i), iKey);

        ++i;
    }
    while (i<5)
    {
        SetLocalInt(oPC, "BBS_Post_" + IntToString(i), -1);
        ++i;
    }

    SetLocalInt(oPC, "BBS_Enable_Next", (SQLFetch() == SQL_SUCCESS));
    SetLocalInt(oPC, "BBS_Enable_Prev", (iPage > 0));
    SetCustomToken(3670, "Page " + IntToString(iPage+1));
}

void BBS_LoadMessage(object oPC)
{
    int iPost = GetLocalInt(oPC, "BBS_Post");
    int iKey = GetLocalInt(oPC, "BBS_Post_" + IntToString(iPost));

    SQLExecDirect("SELECT `poster`,`account`,`title`,DATE_FORMAT(`date`, '%a %D %b %l:%i %p')," +
                  "       `message`,`underdark`" +
                  " FROM `nordock_bbs`" +
                  " WHERE `key` = " + IntToString(iKey));

    if (SQLFetch() == SQL_ERROR)
    {
        SetCustomToken(3671, "Error: Post not found");
        return;
    }

    string sPoster = SQLGetData(1);
    string sAccount = SQLGetData(2);
    string sTitle = SQLGetData(3);
    string sDate = SQLGetData(4);
    string sMessage = SQLGetData(5);
    int iUnderdark = StringToInt(SQLGetData(6));

    if (iUnderdark == 2) // DM Post
        sPoster = "<cþþ >By: " + sPoster + " (DM)</c>";
    else
    {
        int iUD = BBS_GetIsUnderdark(oPC);
        if ((iUD != 2) && (iUnderdark != iUD)) // Other race post
        {
            sTitle = ProcessToDrow(sTitle);
            sMessage = ProcessToDrow(sMessage);
        }
        sPoster = "<c fþ>By: " + sPoster + " (" + sAccount + ")</c>";
    }

    SetCustomToken(3671, sTitle + "    " + sDate + "\n" +
                        sPoster + "\n\n" + sMessage);
}

void BBS_NewPost(object oPC, object oNotice)
{
    string sTitle = GetLocalString(oNotice, "Title");
    string sMessage = GetLocalString(oNotice, "Message");
    string sPoster = GetName(oPC);
    string sAccount = GetPCPlayerName(oPC);
    int iUnderdark = BBS_GetIsUnderdark(oPC);

    SQLExecDirect("INSERT INTO `nordock_bbs`" +
                  " (`board`,`poster`,`account`,`title`,`message`,`date`,`underdark`)" +
                  " VALUES ('" + GetTag(OBJECT_SELF) + "', '" +
                            SQLEncodeSpecialChars(sPoster) + "', '" +
                            SQLEncodeSpecialChars(sAccount) + "', '" +
                            SQLEncodeSpecialChars(sTitle) + "', '" +
                            SQLEncodeSpecialChars(sMessage) + "', " +
                            "NOW(), " +
                            IntToString(iUnderdark) + ")");

    DestroyObject(oNotice);
    BBS_LoadMessageList(oPC);
}

void BBS_DeletePost(object oPC)
{
    if (BBS_GetIsUnderdark(oPC) != 2)
        return;

    int iPost = GetLocalInt(oPC, "BBS_Post");
    int iKey = GetLocalInt(oPC, "BBS_Post_" + IntToString(iPost));

    SQLExecDirect("DELETE FROM `nordock_bbs` WHERE `key` = " + IntToString(iKey) + " LIMIT 1");

    BBS_LoadMessageList(oPC);
}
