/****************************************************
  Starting Condition Script : Check Smithing Hammer
  ats_sc_hammer

  Last Updated: July 15, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is checks to see if the player has the
  blacksmithing tool equipped.
****************************************************/

#include "ats_inc_constant"
#include "ats_inc_common"
#include "ats_config"
#include "ats_inc_material"
#include "ats_inc_tool"

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    return (ATS_GetToolForCraft(oPlayer, CSTR_SKILLNAME_BLACKSMITHING) == OBJECT_INVALID);
}
