//::///////////////////////////////////////////////
//:: One Way Door
//:: v2.0
//:: Copyright (c) 2001-2002 Bioware Corp. and Warren Carlsrud
//:: This script may be freely used.
//:: Please provide credit if this script is used.
//:://////////////////////////////////////////////
/*
The door only allows the user to open it from the front.
(The side with the blue arrow.)
*/
//:://////////////////////////////////////////////
//:: Created By: Warren Carlsrud
//:: Created On: July 2002
//:://////////////////////////////////////////////

/****************************************************
  TranslateLocation
    - Created by Mojo
      July 17, 2002
  This function gets a new location near an object
  based on X, Y, and Z changes relative to the object.
****************************************************/
vector Transform2DVector(vector vRelativeVector, float fFacing)
{
    float fAngleBetween = fFacing - 90;
    vector vResultVector;
    vResultVector.x = (vRelativeVector.x * cos(fAngleBetween)) - (vRelativeVector.y * sin(fAngleBetween));
    vResultVector.y = (vRelativeVector.x * sin(fAngleBetween)) + (vRelativeVector.y * cos(fAngleBetween));
    vResultVector.z = vRelativeVector.z;
    return vResultVector;
}
location TranslateLocation
(
object oObject,         // object to get location near
float fRelativeX,       // X position change relative to the object
float fRelativeY,       // Y position change relative to the object
float fRelativeZ = 0.0  // Z position change
)
{
    location lTransLoc;
    vector vTransVector;
    location lObjectLoc = GetLocation(oObject);
    float fFacing = GetFacingFromLocation(lObjectLoc);
    fFacing += 180.0;
    if (fFacing >= 360.0)
        fFacing -= 360.0;
    float fDirection = GetFacing(oObject);
    vector vObjectPos = GetPositionFromLocation(lObjectLoc);
    vObjectPos.z += fRelativeZ;
    vector vRelativeVector = Vector(fRelativeX, fRelativeY, 0.0);
    vTransVector = Transform2DVector(vRelativeVector, fDirection);
    vObjectPos -= vTransVector;
    lTransLoc = Location( GetAreaFromLocation(lObjectLoc), vObjectPos, fFacing );
    return lTransLoc;
}
//end code from Mojo
//***************************************

void main()
{
    // get the user
    object oPC = GetLastUsedBy();
    location lPC = GetLocation(oPC);
    location lDoor = GetLocation(OBJECT_SELF);

    DelayCommand(5.0, ActionCloseDoor(OBJECT_SELF));

    // get the facings of the user and the door
    float fPCFacing = GetFacing(oPC);
    if (fPCFacing < 0.0)
    {
        fPCFacing = fPCFacing + 180.0;
    }
    float fDoorFacing = GetFacing(OBJECT_SELF);
    if (fDoorFacing < 0.0)
    {
        fDoorFacing = fDoorFacing + 180.0;
    }
    // allow the user to have 180 degrees of facing variance from the door
    float fPCTemp, fDoorTemp1, fDoorTemp2;
    fPCTemp = fPCFacing + 180.0;
    if (fPCTemp >= 360.1)
    {
        fPCTemp = fPCTemp - 360.0;
    }
    fDoorTemp1 = fDoorFacing -90.0;
    fDoorTemp2 = fDoorFacing + 90.0;

    // determine if the user is facing the front of the door
    if (((fPCTemp >= fDoorTemp1) && (fPCTemp <= fDoorTemp2)) || ((fPCTemp >= (fDoorTemp1 + 360.0)) && (fPCTemp <= (fDoorTemp2 + 360.0))))
    {
        // the user is facing the back of the door.
        // keep the door from opening, play a locked door sound
        ActionCloseDoor(OBJECT_SELF);
        PlaySound("as_dr_locked1");

        // clear PC actions to stop character from running
        // past the door animations
        AssignCommand(oPC,ClearAllActions());
        AssignCommand(oPC,ActionWait(1.0));

        // move the PC back from the door 1 meter if they are
        // within 1 meter to prevent them from getting knocked
        // to the other side of the door when/if the door
        // animations occurs.
        float fDistance = GetDistanceBetween(OBJECT_SELF,oPC);
        if (fDistance < 1.0)
        {
            location lMove = TranslateLocation(OBJECT_SELF,0.0,-1.4,0.0);
            AssignCommand(oPC,ActionJumpToLocation(lMove));
        }
        // display a floaty text message above the door.
        FloatingTextStringOnCreature("The door cannot be opened from this side!",oPC);
    }
}
