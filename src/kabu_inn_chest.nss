#include "rr_persist"

void main()
{
    if (GPI(GetLastOpenedBy(), "KabuInnStage") == 3)
    {
        object oItem = GetFirstItemInInventory();
        while (GetIsObjectValid(oItem))
        {
            if (GetResRef(oItem) == "kabu_ring")
                break;
            oItem = GetNextItemInInventory();
        }

        if (!GetIsObjectValid(oItem))
            CreateItemOnObject("kabu_ring");
    }
}
