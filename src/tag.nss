//A simple tag game script
/* by hahnsoo
To use this script you need the following:
1) An invisible object with the tag "TAG_START". Place this script in the OnHeartbeat event of the object.
2) Multiple children, all with the tag "TAG_CHILD". Place this script in the OnHeartbeat event of each child.
3) A waypoint with the tag "TAG_HOME"... this needs to be close to the center of the "playground"

The children will run amok within a 2 tile diameter area
(they will move outside on occasion, but will always return
 to the "TAG_HOME" location if they go too far).

The invisible object will start the Tag Game if the children are present.

Uncomment Line 36 if you want your children to disappear at night. If you have a spawn program, this option works well.
*/
void main()
{
    object oTagChild = GetNearestObjectByTag("TAG_CHILD");
    if (GetTag(OBJECT_SELF) == "TAG_START")
    {
     if (GetIsObjectValid(oTagChild) && GetLocalInt(OBJECT_SELF, "TagStart") == 0)
     {
     SetLocalInt(oTagChild, "IAMIT", 1);
     SetLocalInt(OBJECT_SELF, "TagStart", 1);
     return;
     }
     else if ((GetIsObjectValid(oTagChild) == FALSE) && GetLocalInt(OBJECT_SELF, "TagStart") > 0)
     {
     DeleteLocalInt(OBJECT_SELF, "TagStart");
     return;
     }
    }
    object oTagHome = GetNearestObjectByTag("TAG_HOME");

// Uncomment this next line if you want your children to disappear at night... only use this if you have a respawner script
//    if (GetIsNight()) DestroyObject(OBJECT_SELF);

    if (GetLocalInt(OBJECT_SELF, "IAMIT") == 1)
    {
        if (GetDistanceToObject(oTagChild) < 1.5f)
        {
            ClearAllActions();
            ActionSpeakString("Tag! You're it!");
            PlayVoiceChat(VOICE_CHAT_LAUGH);
            ActionMoveAwayFromObject(oTagChild, TRUE);
            DelayCommand(2.0f, SetLocalInt(oTagChild, "IAMIT", 1));
            DeleteLocalInt(OBJECT_SELF, "IAMIT");
        }
        else
        {
            ClearAllActions();
            ActionMoveToObject(oTagChild, TRUE, 0.0f);
        }
    }
    else
    {
        if (GetDistanceToObject(oTagHome) > 10.0f)
        {
            ClearAllActions();
            PlayVoiceChat(VOICE_CHAT_LAUGH);
            ActionMoveToObject(oTagHome, TRUE);
        }
        else if (GetLocalInt(oTagChild, "IAMIT") == 1)
        {
            PlayVoiceChat(VOICE_CHAT_LAUGH);
            ActionMoveAwayFromObject(oTagChild, TRUE);
        }
        else
        {
            ActionRandomWalk();
        }
    }
}
