//------------------------------------------------------------------------------
//
// ats_inc_update
//
// Include for ATS
//
//------------------------------------------------------------------------------
//
// Author:          Allen Sun [Mojo]
// Creation Date:   xx-08-2003
//
// Last Altered By: Michael Tuffin [Grug]
// Last Altered:    22-12-2003
//
//------------------------------------------------------------------------------
//
// Known bugs/issues...
// - None
//
//------------------------------------------------------------------------------
//
// Changelog...
// Version: 001 (22-12-2003)
// - Added commenting/code structure
// - Added missing include statement
//
// Version: 000 (Anything previous to 22-12-2003)
// - None
//
//------------------------------------------------------------------------------

#include "ats_inc_common"

//------------------------------------------------------------------------------

void ATS_UpdateOldItems(object oPlayer)
{
    //Updates old malachite from v0.56 and v0.55
    if(GetItemPossessedBy(oPlayer, "ATS_R_GEM1_N_MAL") != OBJECT_INVALID)
    {
        object oCurrentItem = GetFirstItemInInventory(oPlayer);
        while(oCurrentItem != OBJECT_INVALID)
        {
            if(GetTag(oCurrentItem) == "ATS_R_GEM1_N_MAL")
            {
                DelayCommand(0.5, ATS_CreateItemOnPlayer("ats_r_gem1_n_mal", oPlayer,GetNumStackedItems(oCurrentItem)));
                DestroyObject(oCurrentItem);
            }
            oCurrentItem = GetNextItemInInventory(oPlayer);
        }
    }
}

//------------------------------------------------------------------------------
