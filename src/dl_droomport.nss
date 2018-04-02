void main()
{
object oDRoom = GetObjectByTag("WP_DRoom");
AssignCommand(GetPCSpeaker(), JumpToObject(oDRoom));
}
