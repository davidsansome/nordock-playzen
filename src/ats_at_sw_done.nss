void main()
{
    object oListener = GetLocalObject(GetPCSpeaker(), "ats_listener");
    if(GetIsObjectValid(oListener) == TRUE)
        DestroyObject(oListener);
}
