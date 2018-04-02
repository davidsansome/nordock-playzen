/****************************************************
  Actions Taken Script : Next Display
  ats_at_cr_next

  Last Updated: August 15 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for advancing the menu
  to the next display.
****************************************************/


void main()
{
    object oPlayer = GetPCSpeaker();
    int iPrevIndex = GetLocalInt(oPlayer, "ats_start_craftmat_arrayindex");
    SetLocalInt(oPlayer, "ats_prev_craftmat_arrayindex", iPrevIndex);
}

