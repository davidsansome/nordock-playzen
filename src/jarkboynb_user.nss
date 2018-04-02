//::///////////////////////////////////////////////
//:: Default: On User Defined
//:: NW_C2_DEFAULTD
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    on a user defined event.
*/
//:://////////////////////////////////////////////
//:: Created By: Don Moar
//:: Created On: April 28, 2002
//:://////////////////////////////////////////////
void main()
{
    // enter desired behaviour here

   int nUser = GetUserDefinedEventNumber();

if(nUser == 1002)

{

if (GetLocalInt(OBJECT_SELF, "spoken") != 2)

{

SpeakString("Beware of the legendary animals here!!");

SetLocalInt(OBJECT_SELF,"spoken",2);

}

}

}
