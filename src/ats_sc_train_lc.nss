/****************************************************
  Starting Condition Script : Train Tanning
  ats_sc_train_lc
  Last Updated: July 31, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for checking to see the
  player has enough gold available to train in
  tanning.
****************************************************/

int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    if(GetGold(oPlayer) >= 50)
    {
        TakeGoldFromCreature(50, oPlayer);
        return TRUE;
    }
    else
        return FALSE;
}
