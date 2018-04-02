void main()
{
SetLocalObject(OBJECT_SELF, "PACK_OWNER", GetPCSpeaker());
SetLocalInt(OBJECT_SELF, "PACK_MODE", 1); // Follow
ActionForceFollowObject(GetLocalObject(OBJECT_SELF, "PACK_OWNER"), 3.0);
}
