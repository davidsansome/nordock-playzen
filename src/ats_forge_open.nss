/****************************************************
  Forge OnOpen Script
  ats_forge_open

  Last Updated: August 20, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script goes on the forge's OnOpen trigger.
  It locks the forge to prevent others from using it
  at the same time.
****************************************************/
#include "ats_inc_common"

void main()
{
    SetLocked(OBJECT_SELF, TRUE);
}
