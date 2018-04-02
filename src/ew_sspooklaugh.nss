void main()
{
object oDM = GetLastSpeaker();

switch (Random(3))
{
case 0: AssignCommand ( oDM, PlaySound("as_pl_lafspook1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_pl_lafspook2"));
    break;

case 2: AssignCommand ( oDM, PlaySound("as_pl_lafspook3"));
    break;
}

}
