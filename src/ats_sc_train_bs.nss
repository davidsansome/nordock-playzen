/****************************************************
  Starting Condition Script : Train Blacksmithing
  ats_sc_train_bs
  Last Updated: July 15, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for checking to see the
  player has enough gold available to train in
  blacksmithing.
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
