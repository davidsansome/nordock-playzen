void main()
{
if(GetCommandable(OBJECT_SELF)){
//This sets the NPC as the speaker
{
BeginConversation();
//This starts the conversation script.
}
ClearAllActions();
// Clears the actions so the NPC will not follow you with his/her eyes
int nChair = 1;
object oChair = GetNearestObjectByTag("NPC_Chair", OBJECT_SELF, nChair);
ActionSit(oChair);
//Sits the NPC down
}

}
