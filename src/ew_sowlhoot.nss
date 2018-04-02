void main()
{
object oDM = GetLastSpeaker();

switch (Random(2))
{
case 0: AssignCommand ( oDM, PlaySound("as_an_owlhoot1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_an_owlhoot2"));
    break;
}

}
