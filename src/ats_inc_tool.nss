//Dependencies: ats_inc_common, ats_config, ats_const_skill, ats_const_mat, ats_const_common,
//              ats_inc_material

#include "ats_inc_common"
#include "ats_config"
#include "ats_const_skill"
#include "ats_const_mat"
#include "ats_const_common"
#include "ats_inc_material"

object ATS_GetToolForCraft(object oPlayer, string sTradeskillName)
{
    if(sTradeskillName == CSTR_SKILLNAME_WEAPONCRAFTING ||
       sTradeskillName == CSTR_SKILLNAME_ARMORCRAFTING ||
       sTradeskillName == CSTR_SKILLNAME_BLACKSMITHING)
    {
        // Gets the tool in the right hand slot of the player
        object oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);
        if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_SMITHTOOL)
            return oToolOnPlayer;
        else
        {
            oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer);
            if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_SMITHTOOL)
                return oToolOnPlayer;
            else
                return OBJECT_INVALID;
        }
    }
    else if(sTradeskillName == CSTR_SKILLNAME_TANNING)
    {
        if(GetLocalInt(oPlayer, "ats_tanning_subskill") ==  ATS_TANNING_SUBSKILL_SEWING)
        {
            return GetLocalObject(oPlayer, "ats_activated_item");
        }
        else
            SetLocalInt(oPlayer, "ats_flag_notool_needed", TRUE);

    }
    else if(sTradeskillName == CSTR_SKILLNAME_GEMCUTTING)
    {
        return GetLocalObject(oPlayer, "ats_activated_item");
    }
    else if(sTradeskillName == CSTR_SKILLNAME_JEWELCRAFTING)
    {
        // Gets the tool in the right hand slot of the player
        object oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);
        if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_JEWELCRAFTINGTOOL)
            return oToolOnPlayer;
        else
        {
            oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer);
            if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_JEWELCRAFTINGTOOL)
                return oToolOnPlayer;
            else
                return OBJECT_INVALID;
        }
    }
    else if(sTradeskillName == CSTR_SKILLNAME_BOWYERING)
    {
        // Gets the tool in the right hand slot of the player
        object oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);
        if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_BOWYERINGTOOL)
            return oToolOnPlayer;
        else
        {
            oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer);
            if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_BOWYERINGTOOL)
                return oToolOnPlayer;
            else
                return OBJECT_INVALID;
        }
    }

//TAILORING TOOL CODE STARTS
    else if(sTradeskillName == CSTR_SKILLNAME_TAILOR)
    {
        // Gets the tool in the right hand slot of the player
        object oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);
        if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_TAILORTOOL)
            return oToolOnPlayer;
        else
        {
            oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer);
            if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_TAILORTOOL)
                return oToolOnPlayer;
            else
                return OBJECT_INVALID;
        }
    }
//TAILORING TOOL CODE STOPS.

//TINKERING TOOL CODE STARTS
    else if(sTradeskillName == CSTR_SKILLNAME_TINKER)
    {
        // Gets the tool in the right hand slot of the player
        object oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);
        if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_TINKERTOOL)
            return oToolOnPlayer;
        else
        {
            oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer);
            if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_TINKERTOOL)
                return oToolOnPlayer;
            else
                return OBJECT_INVALID;
        }
    }

    else if(sTradeskillName == CSTR_SKILLNAME_FLETCHING)
    {
        // Gets the tool in the right hand slot of the player
        object oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);
        if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_FLETCHINGTOOL)
            return oToolOnPlayer;
        else
        {
            oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer);
            if(ATS_GetTagBaseType(oToolOnPlayer) == CSTR_FLETCHINGTOOL)
                return oToolOnPlayer;
            else
                return OBJECT_INVALID;
        }
    }
    return OBJECT_INVALID;
}


void ATS_AdjustCraftToolDurability(object oCraftTool, int iAmount)
{
    int iItemDurability = 0;
    int iMaterialType;
    iItemDurability = ATS_GetItemDurability(oCraftTool);
    if(iItemDurability == 0)
    {
        iMaterialType = ATS_GetMaterialType(oCraftTool);
        iItemDurability = ATS_GetItemMaxDurability(oCraftTool);
        if(iItemDurability == 0)
        {
            if(GetTag(oCraftTool) == "hc_skinning")
                iItemDurability = 10;
            else
                iItemDurability = ATS_GetDefaultMaterialDurability(iMaterialType);
        }
    }

    iItemDurability -= iAmount;
    DEBUG_SpeakString("Durability: " + IntToString(iItemDurability));
    ATS_SetItemDurability(oCraftTool, iItemDurability);

    if(iItemDurability <= 0)
        ATS_BreakItem(oCraftTool, 2.0);

}
