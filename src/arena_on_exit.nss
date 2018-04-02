void main()
{
    SetLocalInt(GetExitingObject(),"arena", FALSE);
        SendMessageToPC(GetExitingObject(),"You are no longer in ARENA mode. Regular death rules back in effect.");
}
