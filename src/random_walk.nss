//*******************************************************\\

//  Random walk with tether to limit distance travelled  \\

//                                                       \\

//  Created by Perturbatio 16th July 2002                \\

//                                                       \\

//  Remember to uncomment the line                       \\

//  SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);        \\

//  in the OnSpawn script of the creature you want to    \\

//  affect.                                              \\

//*******************************************************\\

void main()

{

    //get the event number

    int nUserEvent = GetUserDefinedEventNumber();

    // get the object of the calling creature

    object oSelf = OBJECT_SELF;

    if(nUserEvent == 1001) //HEARTBEAT EVENT

    {

        // the following will move the creature a random distance

        // away from the location lTether

        // lTether should be a location with the tag set to TETHER_<CREATURETAG>

        // where <CREATURETAG> is the tag of the creature you want this script to affect

        // i.e. TETHER_NW_GUARD01

        // if there is no tether then it will use the starting location of the creature

        // must set the a local int on the creature object named iDoTether with a value of 1

        // used so that you can prevent them doing a random walk if need be

        // if you want the creature to do it from the start, put

        // SetLocalInt(OBJECT_SELF, "iDoTether", 1);

        // in the creatures OnSpawn event (copy the script first).

        if (GetLocalInt(oSelf,"iDoTether")){

            int iMaxDistance = 9;

            location lTether;

            string sTether = "TETHER_" + GetTag(oSelf);

            object oTetherWaypoint = GetWaypointByTag( sTether );

            if (!(GetLocalInt(oSelf, "iHasTether"))){

                if (GetIsObjectValid( oTetherWaypoint ))

                {

                    lTether = GetLocation( oTetherWaypoint );

                } else {

                    lTether = GetLocation( oSelf );

                }

                // Set the tether location on the creature object

                SetLocalLocation(oSelf, "lTether", lTether);

                // The object now has a tether

                SetLocalInt(oSelf, "iHasTether", 1);

            }

            lTether = GetLocalLocation(oSelf, "lTether");

            vector vLocationVector = GetPositionFromLocation(lTether);

            vLocationVector.x += (Random(iMaxDistance) - Random(iMaxDistance)) ;

            vLocationVector.y += (Random(iMaxDistance) - Random(iMaxDistance)) ;

            location lWalkTo = Location(GetArea(oSelf), vLocationVector, Random(361) * 1.0);

            SetLocalLocation(oSelf, "WalkTo", lWalkTo);

            ActionMoveToLocation(lWalkTo);

        }

    }

    return;

 }
