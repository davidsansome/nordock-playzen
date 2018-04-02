// hc_inc_track
// Tracking variables

/*
  Author: Big E
  Date:   July 20, 2002
  Given the facing value (0-360), set the compass direction.
  Modified by Archaegeo for Ranger Tracking
*/
void GetDirection(float fFacing, object oTracker, object oCritter)
    {
    //Correct the bug in GetFacing (Thanks Iskander)
    if (fFacing >= 360.0)
        fFacing  =  720.0 - fFacing;
    if (fFacing <    0.0)
        fFacing += (360.0);
    int iFacing = FloatToInt(fFacing);
    /*
      359 -  2  = E
        3 - 45  = ENE
       46 - 87  = NNE
       88 - 92  = N
       93 - 135 = NNW
      136 - 177 = WNW
      178 - 182 = W
      183 - 225 = WSW
      226 - 267 = SSW
      268 - 272 = S
      273 - 315 = SSE
      316 - 358 = ESE
    */
    string sDirection = "";
    if((iFacing >= 359) && (iFacing <=   2))
        sDirection = "E";
    if((iFacing >=   3) && (iFacing <=  45))
        sDirection = "ENE";
    if((iFacing >=  46) && (iFacing <=  87))
        sDirection = "NNE";
    if((iFacing >=  88) && (iFacing <=  92))
        sDirection = "N";
    if((iFacing >=  93) && (iFacing <= 135))
        sDirection = "NNW";
    if((iFacing >= 136) && (iFacing <= 177))
        sDirection = "WNW";
    if((iFacing >= 178) && (iFacing <= 182))
        sDirection = "W";
    if((iFacing >= 183) && (iFacing <= 225))
        sDirection = "WSW";
    if((iFacing >= 226) && (iFacing <= 267))
        sDirection = "SSW";
    if((iFacing >= 268) && (iFacing <= 272))
        sDirection = "S";
    if((iFacing >= 273) && (iFacing <= 315))
        sDirection = "SSE";
    if((iFacing >= 316) && (iFacing <= 358))
        sDirection = "ESE";
    SendMessageToPC(oTracker,GetName(oCritter)+" is to the "+sDirection);
    return ;
    }

