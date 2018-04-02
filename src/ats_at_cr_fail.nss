/****************************************************
  Action Taken Script: Crafting failure
  ats_at_cr_fail

  Last Updated: August 25, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

    Revamped by Keith Westrate <helimar@earthlink.net> to take
    advantage of the new ATS_FindComponents function to reduce
    redundancy and TMIS by increasing efficiency

  This script displays the crafting failure message
  and consumes components based on a risk percentage.
****************************************************/
#include "ats_const_common"
#include "ats_const_mat"
#include "ats_inc_common"
#include "ats_inc_menu"
#include "ats_inc_material"
#include "ats_inc_cr_get"
#include "ats_inc_cr_comp"

void main()
{
    object oPlayer = GetPCSpeaker();
    string sCraftTag = ATS_GetCurrentCraftTag(oPlayer);
    int iMaterialType = ATS_GetCurrentCraftMaterial(oPlayer);

    string sMessage;

    int i;

    FloatingTextStringOnCreature("**UNSUCCESSFUL**", oPlayer);

    // use the new FindComponents function to remove components
    // based on consumption risk from recipe
    i = ATS_FindComponents(oPlayer, sCraftTag, iMaterialType, 2);

    // Now give player failure products
    int iFailureProductCount = ATS_GetFailureProductCount(sCraftTag);
    string sFailureProductTag;
    int iFailureProductPercent;  // Chance to get the product out of 100

    for(i = 1; i <= iFailureProductCount; ++i)
    {
        sFailureProductTag = ATS_GetFailureProduct(sCraftTag, i);
        iFailureProductPercent = ATS_GetFailureProductPercent(sCraftTag, i);
        if(d100(1) <= iFailureProductPercent)
        {
             //Create the product
            ATS_CreateItemOnPlayer(sFailureProductTag, oPlayer, 1, TRUE);
            object oCreatedItem = GetLocalObject(oPlayer, "ats_returnvalue_created_item");
            if(GetIsObjectValid(oCreatedItem) == TRUE)
            {
                sMessage = "You have produced " + GetName(oCreatedItem) + " from this failure.";
                DelayCommand(0.5, FloatingTextStringOnCreature(sMessage, oPlayer, FALSE));
            }
        }
    }
}
