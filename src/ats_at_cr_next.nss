/****************************************************
  Actions Taken Script : Next Display
  ats_at_cr_next

  Last Updated: July 26, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for advancing the menu
  to the next display.
****************************************************/


void main()
{
    object oPlayer = GetPCSpeaker();
    int iPrevIndex = GetLocalInt(oPlayer, "ats_start_craft_arrayindex");
    SetLocalInt(oPlayer, "ats_prev_craft_arrayindex", iPrevIndex);
}

