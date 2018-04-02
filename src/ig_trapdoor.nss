//::///////////////////////////////////////////////

//:: Trapdoor that functions as transition

//:: trapdoor_use

//:: Copyright (c) 2001 Bioware Corp.

//:://////////////////////////////////////////////

/*trapdoor_use script by Rich Dersheimer.

  This is a modification of the script by

  Kerico 7/5/02. Use it in the trapdoor's OnUsed

  script. It opens the trapdoor, then if the

  trapdoor is clicked again while it is open,

  it jumps the player to the destination waypoint.

*/

void main()

{

    //Get PC

    object oPC = GetLastUsedBy();

    //Get Trapdoor tag and open/closed state

    object oDoor = GetObjectByTag("tdttolowersewerF");

    int nDoorState = GetLocalInt(oDoor, "Opened");

    //get the target waypoint destination

    object oDrop = GetWaypointByTag("lowersewerF");

    if (nDoorState == FALSE) //the door is closed, so open it

        {

        //have the PC kneel down and act as if opening the trapdoor

        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 0.7f));

        //swing the door to open after a slight delay to allow for the PC's animation

        DelayCommand(1.0f, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));

        //change status of door to open

        SetLocalInt(oDoor, "Opened", 1);

        }

        else  //the door is open, so jump the player

        {

        //jump the PC to the destination

        AssignCommand (oPC,JumpToObject(oDrop));

        //closing the door would be optional, you could

        //just leave it open for the next player

        //close the trapdoor

        PlayAnimation (ANIMATION_PLACEABLE_CLOSE);

        //change status of door to closed

        SetLocalInt(oDoor, "Opened", 0);

        }

}

