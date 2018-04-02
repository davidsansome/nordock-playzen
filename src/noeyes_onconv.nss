///////////////////////////////////////////////
//This script causes a NPC, upon initiating////
//conversation, to NOT follow the PC with its//
//eyes and remain stationary. Put in the///////
//OnConversation Script location.//////////////
///////////////////////////////////////////////
void main()
{
    if(GetCommandable(OBJECT_SELF))
     //This sets the NPC as the speaker
    {
    ClearAllActions();
    // Clears the actions so the NPC will not follow you with his/her eyes
    }
}
