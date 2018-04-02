void main()
{
object oDM = GetLastSpeaker();

switch (Random(2))
{
case 0: AssignCommand ( oDM, PlaySound("as_an_crow1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_an_crow2"));
    break;
}

}

