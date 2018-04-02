/****************************************************
  Action Taken Script : Material Selection 9
  ats_at_mat_sel_9

  Last Updated: July 15, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script responds to the selection of a material
  type and stores that material type for later use.
****************************************************/
#include "ats_inc_menu"
#include "ats_inc_menu_mat"

void main()
{
    object oPlayer = GetPCSpeaker();

    int iCraftMaterial = ATS_GetMaterialFromDisplayList(oPlayer, 9);

    ATS_SetCurrentCraftMaterial(oPlayer, iCraftMaterial);
}

