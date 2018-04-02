//:://////////////////////////////////////////////
/*
    When placed on a sun dial's ONUSED event, this
    script will provide the actual game time to a
    resolution of 15 minute increments.  15 minutes
    is about as accurate as a sun dial would be
    anyway.
*/
//:://////////////////////////////////////////////
//:: Created By: Brett Lathrope
//:: Created On: July 3, 2002
//:://////////////////////////////////////////////
void main()
{
  int nHour = GetTimeHour();
  int nMinute = GetTimeMinute();
  int nSeconds = GetTimeSecond();
  int nFM;                          //False Minute we'll build.
  string sFM;                       // String storage of our false minute.
  nFM = GetTimeMinute() * 30;
  if (nSeconds >= 30) nFM = nFM + 15;
  sFM = IntToString(nFM);
  if (GetStringLength(sFM) == 1) sFM = "0" + sFM;
  string sDesignate = " AM";
  if (nHour > 12){
    nHour = nHour - 12;
    sDesignate = " PM";
  }
  string sTmp = IntToString(nHour) + ":" + sFM + sDesignate;
  SpeakString("It is about " + sTmp,TALKVOLUME_TALK);
}

