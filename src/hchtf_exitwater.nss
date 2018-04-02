//hchtf_exitwater (on exit event for trigger painted around body of water)

void main()
{
DeleteLocalString(GetExitingObject(),"WATERSRC");
}

