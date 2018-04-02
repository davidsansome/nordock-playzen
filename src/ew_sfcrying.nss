void main()
{
object oDM = GetLastSpeaker();

switch (Random(3))
{
case 0: AssignCommand ( oDM, PlaySound("as_pl_cryingf1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_pl_cryingf2"));
    break;

case 2: AssignCommand ( oDM, PlaySound("as_pl_cryingf3"));
    break;
}

}
