//::///////////////////////////////////////////////
//:: Default: Trudar the Rat Catcher On User Defined
//:: trudaratcat_ud
//:: Copyright (c) 2004 Eagware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    on a user defined event.
*/
//:://////////////////////////////////////////////
void MakeANewRatCatcher()
{
 object oWP = GetObjectByTag("POST_TrudaltheRatCatcher");
 location lLocation = GetLocation(oWP);
 CreateObject(OBJECT_TYPE_CREATURE, "trudaltheratcatc", lLocation, FALSE,"TrudaltheRatCatcher");
}

void main()
{
    // enter desired behaviour here
    int iEvent = GetUserDefinedEventNumber();
    switch(iEvent){
    // on death
       case 1007:
       DelayCommand(600.0, MakeANewRatCatcher());
       break;
    }

    return;

}
