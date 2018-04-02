#include "ats_inc_textform"
#include "ats_const_skill"

void main()
{
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_MINING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_MINING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_BLACKSMITHING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_BLACKSMITHING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_ARMORCRAFTING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_ARMORCRAFTING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_WEAPONCRAFTING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_WEAPONCRAFTING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_TANNING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_TANNING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_GEMCUTTING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_GEMCUTTING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_JEWELCRAFTING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_JEWELCRAFTING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_BOWYERING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_BOWYERING));
    SetLocalInt(GetModule(), "ats_skillname_width_" + CSTR_SKILLNAME_FLETCHING,
                ATS_GetStringPeriodWidth(CSTR_SKILLNAME_FLETCHING));

}
