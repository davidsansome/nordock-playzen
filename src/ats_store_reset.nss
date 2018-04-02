#include "ats_config"

void main()
{
    object oCurrentItem = GetFirstItemInInventory();
    string sItemTag;
    int iItemCount = 0;
    int iTotalCount = 0;

    while(oCurrentItem != OBJECT_INVALID)
    {
        sItemTag = GetTag(oCurrentItem);
        iItemCount = GetLocalInt(OBJECT_SELF, "count_" + sItemTag);
        if(GetLocalInt(oCurrentItem, "ats_onstore_original") == FALSE)
        {
            if(iItemCount >= CINT_MERCHANT_MAX_PER_ITEM)
                DestroyObject(oCurrentItem);
            else if(iTotalCount >= CINT_MERCHANT_MAXITEMS)
                DestroyObject(oCurrentItem);
            else
            {
                ++iItemCount;
                ++iTotalCount;
                SetLocalInt(OBJECT_SELF, "count_" + sItemTag ,iItemCount );
            }
        }
        oCurrentItem = GetNextItemInInventory();
    }
    oCurrentItem = GetFirstItemInInventory();
    while(oCurrentItem != OBJECT_INVALID)
    {
        SetLocalInt(OBJECT_SELF, "count_" + GetTag(oCurrentItem) , 0);
        oCurrentItem = GetNextItemInInventory();
    }


}
