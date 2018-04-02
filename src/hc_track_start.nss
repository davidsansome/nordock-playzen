// hc_track_start
// Starts tracking of creatures
// Archaegeo 17 Aug, 2002

#include "hc_inc_track"
#include "hc_text_track"

void main()
{
    int nDC;
    object oTracker=OBJECT_SELF;
    object oTrackPlc=GetNearestObjectByTag("Tracker");
    if(GetIsObjectValid(oTrackPlc))
        nDC=GetWillSavingThrow(oTrackPlc);
    if(!nDC || !GetIsObjectValid(oTrackPlc))
    {
        SendMessageToPC(oTracker,NOTPOSSIBLE);
        return;
    }
    object oCritter;
    object oArea=GetArea(oTracker);
    int nLevel=GetLevelByClass(CLASS_TYPE_RANGER, oTracker);
    int nCnt=1;
    float fDistance;
    int nDCAdj;
    vector vCritter;
    oCritter=GetNearestObject(OBJECT_TYPE_CREATURE, oTracker, nCnt);
    while(GetIsObjectValid(oCritter) &&
          GetArea(oCritter)==oArea)
    {
        fDistance=GetDistanceBetween(oCritter, oTracker);
        nDCAdj=FloatToInt(fDistance/10.0);
        if((d20()+nLevel) > (nDC+nDCAdj) &&
            (!GetLocalInt(oCritter,"NOTRACK") &&
             !GetHasFeat(FEAT_TRACKLESS_STEP, oCritter)))
        {
            vCritter=GetPosition(oCritter);
            AssignCommand(oTracker,SetFacingPoint (vCritter));
            AssignCommand(oTracker,GetDirection(GetFacing(oTracker),oTracker,
                oCritter));
        }
        nCnt++;
        oCritter=GetNearestObject(OBJECT_TYPE_CREATURE, oTracker, nCnt);
    }
    return;
}
