#include "ats_config"
#include "ats_const_common"
#include "ats_const_recipe"
#include "ats_inc_common"
#include "ats_const_skill"
#include "ats_inc_skill"
void main()
{
    object oDM = GetPCSpeaker();
    object oTarget = GetLocalObject(oDM, "ats_item_target");
    string sSkillName = GetLocalString(oDM, "ats_sw_current_skill");

    int iAdjustAmount = GetLocalInt(oDM, "ats_sw_adjust_value");
    string sLogSkillChange = "<ATS> DM " + GetName(oDM) + " changed " +
                             GetName(oTarget) + "(" + GetPCPlayerName(oTarget) +
                             ")'s " + sSkillName + " skill to " + IntToString(iAdjustAmount) +
                             ".";
    WriteTimestampedLogEntry(sLogSkillChange);
    FloatingTextStringOnCreature("DM " + GetName(oDM) + " has changed your " +
                                 sSkillName + " skill. ", oTarget);
    ATS_SetTradeskill(oTarget, sSkillName, iAdjustAmount);


}
