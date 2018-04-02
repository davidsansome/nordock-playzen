/****************************************************
  TranslateLocation
    - Created by Mojo
      July 17, 2002

  This function gets a new location near an object
  based on X, Y, and Z changes relative to the object.

****************************************************/

float ATS_CorrectDirection( float fFacing )
{
  if (fFacing >= 360.0) fFacing  =  720.0 - fFacing;
  if (fFacing <    0.0) fFacing += (360.0);
  return fFacing;
}

vector ATS_Transform2DVector(vector vRelativeVector, float fFacing)
{
    float fAngleBetween = fFacing - 90;
    vector vResultVector;

    vResultVector.x = (vRelativeVector.x * cos(fAngleBetween)) -
                      (vRelativeVector.y * sin(fAngleBetween));

    vResultVector.y = (vRelativeVector.x * sin(fAngleBetween)) +
                      (vRelativeVector.y * cos(fAngleBetween));

    vResultVector.z = vRelativeVector.z;

    return vResultVector;
}

location ATS_TranslateLocation
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
    float fDirection = ATS_CorrectDirection(GetFacing(oObject));;
    vector vObjectPos = GetPositionFromLocation(lObjectLoc);

    vObjectPos.z += fRelativeZ;

    vector vRelativeVector = Vector(fRelativeX, fRelativeY, 0.0);
    vTransVector = ATS_Transform2DVector(vRelativeVector, fDirection);

    vObjectPos -= vTransVector;

    lTransLoc = Location( GetAreaFromLocation(lObjectLoc), vObjectPos,
                              GetFacingFromLocation(lObjectLoc) );

    return lTransLoc;
}
