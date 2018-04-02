//:://////////////////////////////////////////////

//Creates a sundial that gives the in-game time when clicked on.

//Place in the OnUsed slot of the sundial object. Make sure that

//the "useable" check box (in the "Basic" tab under item properties)

//is checked. The sundial will only tell time during the day.

void main()

{

    int nHour = GetTimeHour();

    if (GetIsNight())

        {

        SpeakString("You can't use the sundial at night.");

        }

    else if (nHour == 1)

        {

        SpeakString("The time is 1:00 AM");

        }

    else if (nHour == 2)

        {

        SpeakString("The time is 2:00 AM");

        }

    else if (nHour == 3)

        {

        SpeakString("The time is 3:00 AM");

        }

    else if (nHour == 4)

        {

        SpeakString("The time is 4:00 AM");

        }

    else if (nHour == 5)

        {

        SpeakString("The time is 5:00 AM");

        }

    else if (nHour == 6)

        {

        SpeakString("The time is 12:00 PM");

        }

    else if (nHour == 7)

        {

        SpeakString("The time is 7:00 AM");

        }

    else if (nHour == 8)

        {

        SpeakString("The time is 8:00 AM");

        }

    else if (nHour == 9)

        {

        SpeakString("The time is 9:00 AM");

        }

    else if (nHour == 10)

        {

        SpeakString("The time is 10:00 AM");

        }

    else if (nHour == 11)

        {

        SpeakString("The time is 11:00 AM");

        }

    else if (nHour == 12)

        {

        SpeakString("The time is 12:00 PM");

        }

    else if (nHour == 13)

        {

        SpeakString("The time is 1:00 PM");

        }

    else if (nHour == 14)

        {

        SpeakString("The time is 2:00 PM");

        }

    else if (nHour == 15)

        {

        SpeakString("The time is 3:00 PM");

        }

    else if (nHour == 16)

        {

        SpeakString("The time is 4:00 PM");

        }

    else if (nHour == 17)

        {

        SpeakString("The time is 5:00 PM");

        }

    else if (nHour == 18)

        {

        SpeakString("The time is 6:00 PM");

        }

    else if (nHour == 19)

        {

        SpeakString("The time is 7:00 PM");

        }

    else if (nHour == 20)

        {

        SpeakString("The time is 8:00 PM");

        }

    else if (nHour == 21)

        {

        SpeakString("The time is 9:00 PM");

        }

    else if (nHour == 22)

        {

        SpeakString("The time is 10:00 PM");

        }

    else if (nHour == 23)

        {

        SpeakString("The time is 11:00 PM");

        }

    else if (nHour == 24)

        {

        SpeakString("The time is 12:00 AM");

        }

}
