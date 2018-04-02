/****************************************************
  Invisible Corpse OnUsed Script
  ats_i_corpse_use

  Last Updated: July 30, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script goes on the invisible corpse's OnUsed
  event.  This is responsible for checking to see
  if the player has the correct tool and also creates
  the pelts and meat.
****************************************************/
#include "ats_inc_common"
#include "ats_const_mat"
#include "ats_const_skill"
#include "ats_const_common"
#include "ats_config"
#include "ats_inc_material"
#include "ats_inc_tool"

void ATS_SkinAnimal()
{
    object oPlayer = GetLastUsedBy();
    object oLootCorpse = OBJECT_SELF;
    location lCorpseLoc = GetLocation(oLootCorpse);
    // Gets the original dead animal
    object oDeadAnimal = GetLocalObject(oLootCorpse, "ats_oHostBody");
    object oCreatedPelt;
    object oCreatedMeat;

    string sPeltType = GetLocalString(oLootCorpse, "ats_sPeltType");
    int iPeltAmount = Random(GetLocalInt(oLootCorpse, "ats_iPeltAmount")) + 1;
    int iMeatAmount = Random(GetLocalInt(oLootCorpse, "ats_iMeatAmount")) + 1;
    string sPeltResRef = ATS_GetResRefFromTag("ATS_R_" + sPeltType + "_N_PEL");
    string sMeatResRef = ATS_GetResRefFromTag("ATS_R_" + sPeltType + "_N_MEA");
    string sDisplayMessage;
    int i;

    for(i = 0; i < iPeltAmount; ++i)
    {
        // Create pelts and meat
        oCreatedPelt = CreateItemOnObject(sPeltResRef, oPlayer);

        if(GetIsObjectValid(oCreatedPelt) == FALSE)
        {
            // Create pelt on ground
            oCreatedPelt = CreateObject(OBJECT_TYPE_ITEM, sPeltResRef, GetLocation(oPlayer));
        }
        if(GetIsObjectValid(oCreatedPelt) == FALSE)
            {
                --i;
                break;
            }
    }
    if(i > 0)
    {
        sDisplayMessage = "You have skinned " + IntToString(iPeltAmount) + " " +
                                    GetName(oCreatedPelt);
        if(iPeltAmount > 1)
            sDisplayMessage += "s";
        sDisplayMessage += " from this corpse.";
        FloatingTextStringOnCreature(sDisplayMessage, oPlayer, FALSE);
    }

    for(i = 0; i < iMeatAmount; ++i)
    {
        oCreatedMeat = CreateItemOnObject(sMeatResRef, oPlayer);

        if(GetIsObjectValid(oCreatedMeat) == FALSE)
        {
            // Create meat on ground
            oCreatedMeat = CreateObject(OBJECT_TYPE_ITEM, sMeatResRef, GetLocation(oPlayer));
            if(GetIsObjectValid(oCreatedMeat) == FALSE)
            {
                --i;
                break;
            }
        }
    }
    if(i > 0)
    {
        sDisplayMessage = "You have carved " + IntToString(iMeatAmount) +
                          " piece";
        if(i > 1)
            sDisplayMessage += "s";
        sDisplayMessage += " of " + GetName(oCreatedMeat) +
                          " from this corpse.";
        AssignCommand(oPlayer, DelayCommand(0.7f, FloatingTextStringOnCreature(sDisplayMessage, oPlayer, FALSE)));
    }

    object oCorpseBlood = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_bloodstain", lCorpseLoc, FALSE);


    // Stop the destroy object commands
    AssignCommand(oDeadAnimal, ClearAllActions());
    SetLocalInt(oDeadAnimal, "ats_self_destruct", FALSE);

    // Fade the corpse out
    DestroyObject(oLootCorpse);
    AssignCommand(GetModule(), DelayCommand(20.1f, DestroyObject(oCorpseBlood)));
    AssignCommand(GetModule(), DelayCommand(21.3f, AssignCommand(oDeadAnimal,SetIsDestroyable(TRUE))));
    AssignCommand(GetModule(), DelayCommand(21.5f, DestroyObject(oDeadAnimal)));
}

void main()
{
    object oPlayer = GetLastUsedBy();

    object oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer);
    if((ATS_GetTagBaseType(oToolOnPlayer) != CSTR_SKINNINGTOOL) &&
       (GetTag(oToolOnPlayer) != "hc_skinning")) // For compatibility with the HCR
    {
        oToolOnPlayer = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer);
        if(ATS_GetTagBaseType(oToolOnPlayer) != CSTR_SKINNINGTOOL &&
           GetTag(oToolOnPlayer) != "hc_skinning") // For compatibility with the HCR
        {
            oToolOnPlayer = OBJECT_INVALID;
        }
    }
    if(GetIsObjectValid(oToolOnPlayer) == FALSE)
    {
        FloatingTextStringOnCreature(CSTR_ERROR1_SKINNING, oPlayer, FALSE);
        return;
    }

    DelayCommand(1.0f,AssignCommand(oPlayer,ActionPlayAnimation(
                 ANIMATION_LOOPING_GET_LOW, 1.0f, 2.5f)));

    DelayCommand(4.5f, ATS_SkinAnimal());
    DelayCommand(4.5f, ATS_AdjustCraftToolDurability(oToolOnPlayer, 1));

}
