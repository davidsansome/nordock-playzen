//::///////////////////////////////////////////////
//:: FileName hauntgivedark
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/1/2002 9:22:17 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("darktoothscimita", GetPCSpeaker(), 1);
    SetLocalInt(GetPCSpeaker(), "gotdarktoothnow",1);

}
