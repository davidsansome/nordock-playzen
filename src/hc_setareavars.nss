#include "hc_inc_htf"

//Place holder
void SetAreaOnEnterMessageByStageOfDay(object oArea,int stageofday,string varname, string message)
{
    SetLocalString(oArea, varname + GetStageOfDaySuffix(stageofday), message);
}

void SetAreaOnEnterMessage(object oArea,string varname,string message)
{
    SetAreaOnEnterMessageByStageOfDay(oArea,DAY,varname,message);
    SetAreaOnEnterMessageByStageOfDay(oArea,DAWN,varname,message);
    SetAreaOnEnterMessageByStageOfDay(oArea,DUSK,varname,message);
    SetAreaOnEnterMessageByStageOfDay(oArea,NIGHT,varname,message);
}

void main()
{
    TurnOffAreaConsumeRates(GetObjectByTag("FuguePlane"));


    //Use this script to set all Initial Area variables.
    //This is executed from on module load.

}


