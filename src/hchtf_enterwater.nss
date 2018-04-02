//hchtf_enterwater  (on enter event for trigger painted around body of water)

void main()
{
    SetLocalString(GetEnteringObject(),"WATERSRC",GetTag(OBJECT_SELF));
}
