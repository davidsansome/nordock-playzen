// hc_inc_stageday
//
// Created August 14, 2002 by Edward Beck (0100010). Function to assist
// in managing the stage of day. Used whenever stage of day manipulation
// is needed.

int DAY = 0;
int DAWN = 1;
int DUSK = 2;
int NIGHT = 3;

string GetStageOfDaySuffix(int stageofday)
{
    if (stageofday==DAWN)  return "_DWN";
    if (stageofday==DUSK)  return "_DSK";
    if (stageofday==NIGHT) return "_NGT";
    return "_DAY";
}

int GetStageOfDay()
{
    if (GetIsDawn())  return DAWN;
    if (GetIsDusk())  return DUSK;
    if (GetIsNight()) return NIGHT;
    return DAY;
}
