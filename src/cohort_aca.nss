//script cohort_aca
//
//
//Cohort on reseted event
void main()
{
    SpeakString("Now Resting");
    SendMessageToPC(GetFirstPC(),"Pre-rest HP: " + IntToString(GetCurrentHitPoints()));
    return;

}
