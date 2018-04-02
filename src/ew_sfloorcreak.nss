void main()
{
object oDM = GetLastSpeaker();

switch (Random(2))
{
case 0: AssignCommand ( oDM, PlaySound("as_cv_woodcreak2"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_cv_florcreak2"));
    break;
}

}

