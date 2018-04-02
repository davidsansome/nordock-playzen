//hchtf_fooddrinkp  (food or drink source placeable on used event)

//Put this script's code into a placeable's OnUsed event to make that item
//a food or drink source for the PC on use. (Ex: a water fountain)
//See htf_inc for details.
#include "hc_inc_htf"

void main()
{
    int iHUNGERSYSTEM = GetLocalInt(GetModule(),"HUNGERSYSTEM");
    if (iHUNGERSYSTEM)
        UseFoodOrDrinkItem(GetLastUsedBy(),OBJECT_INVALID,GetTag(OBJECT_SELF));
}
