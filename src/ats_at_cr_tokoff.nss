/****************************************************
  Actions Taken Script : Token Offsets

  ats_at_cr_tokoff

  Last Updated: July 27, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script is responsible for creating the
  token offset to avoid collisions.
****************************************************/

#include "ats_inc_menu"

void main()
{
    object oPlayer = GetPCSpeaker();

    int iTokenOffsetCount = GetLocalInt(GetModule(), "ats_anvil_tokenoffset_count");
    if(++iTokenOffsetCount > 5)
        iTokenOffsetCount = 0;


    SetLocalInt(GetModule(), "ats_anvil_tokenoffset_count", ++iTokenOffsetCount);

    ATS_SetTokenOffset(oPlayer, 100 * iTokenOffsetCount);
    SetLocalInt(oPlayer, "ats_token_offset_count", -100);
}
