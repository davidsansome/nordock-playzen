void main()
{
object oDM = GetLastSpeaker();

switch (Random(2))
{
case 0: AssignCommand ( oDM, PlaySound("c_wraith_bat1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_pl_zombiem3"));
    break;

}

}

