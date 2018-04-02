/****************************************************
  Starting Condition Script : Create skill custom
  conversation tokens
  ats_sc_tokens

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for creating the custom
  tokens with a player's tradeskill values.
****************************************************/

#include "ats_const_common"
#include "ats_const_skill"
#include "ats_const_recipe"
#include "ats_inc_common"
#include "ats_config"
#include "ats_inc_skill"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    SetCustomToken(5501, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_ARMORCRAFTING)));
    SetCustomToken(5502, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_BLACKSMITHING)));
    SetCustomToken(5503, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_MINING)));
    SetCustomToken(5504, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_WEAPONCRAFTING)));
    SetCustomToken(5505, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_TANNING)));
    SetCustomToken(5506, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_GEMCUTTING)));
    SetCustomToken(5507, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_JEWELCRAFTING)));
    SetCustomToken(5508, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_BOWYERING)));
    SetCustomToken(5509, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_FLETCHING)));
    SetCustomToken(5510, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_TAILOR)));
    SetCustomToken(5511, IntToString(ATS_GetTradeskill(oPlayer, CSTR_SKILLNAME_TINKER)));

    // Set Max skill values
    SetCustomToken(52101, IntToString(ATS_GetMaxSkill(CSTR_SKILLNAME_ARMORCRAFTING)));
    SetCustomToken(52102, IntToString(ATS_GetMaxSkill(CSTR_SKILLNAME_BLACKSMITHING)));
    SetCustomToken(52103, IntToString(ATS_GetMaxSkill(CSTR_SKILLNAME_MINING)));
    SetCustomToken(52104, IntToString(ATS_GetMaxSkill(CSTR_SKILLNAME_WEAPONCRAFTING)));
    SetCustomToken(52105, IntToString(ATS_GetMaxSkill(CSTR_SKILLNAME_TANNING)));
    SetCustomToken(52106, IntToString(ATS_GetMaxSkill(CSTR_SKILLNAME_GEMCUTTING)));
    SetCustomToken(52107, IntToString(ATS_GetMaxSkill(CSTR_SKILLNAME_JEWELCRAFTING)));
    SetCustomToken(52108, IntToString(ATS_GetMaxSkill(CSTR_SKILLNAME_BOWYERING)));
    SetCustomToken(52109, IntToString(ATS_GetMaxSkill(CSTR_SKILLNAME_FLETCHING)));
    SetCustomToken(52110, IntToString(ATS_GetMaxSkill(CSTR_SKILLNAME_TAILOR)));
    SetCustomToken(52111, IntToString(ATS_GetMaxSkill(CSTR_SKILLNAME_TINKER)));


    return TRUE;
}
