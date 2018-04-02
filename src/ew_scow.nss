void main()
{
object oDM = GetLastSpeaker();

switch (Random(1))
{
case 0: AssignCommand ( oDM, PlaySound("as_an_cow1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_an_cow2"));
    break;
}

}


