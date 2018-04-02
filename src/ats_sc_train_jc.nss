/****************************************************
  Starting Condition Script : Train Jewelcrafting
  ats_sc_train_jc
  Last Updated: 16 August 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)
    Assisted by Pelemele Malef'carum (Shawn Perreault)

  This script is responsible for checking to see the
  player has enough gold available to train in
  jewelcrafting.
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
