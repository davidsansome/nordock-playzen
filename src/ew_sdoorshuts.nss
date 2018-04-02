void main()
{
object oDM = GetLastSpeaker();

switch (Random(2))
{
case 0: AssignCommand ( oDM, PlaySound("as_sw_woodplate1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_dr_woodmedcl1"));
    break;
}

}
