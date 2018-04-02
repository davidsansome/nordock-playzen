////////////////////////////////////////////////////////////////////////////////
//                                                  //                        //
// _kb_corpse_sound                                 //      VERSION 1.0       //
//                                                  //                        //
//  by Keron Blackfeld on 07/17/2002                ////////////////////////////
//                                                                            //
//  email Questions and Comments to: keron@broadswordgaming.com or catch me   //
//  in Bioware's NWN Community - Builder's NWN Scripting Forum                //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//  This script is a simple, albeit weak, attempt to mask the default DOOR    //
//  sounds tied to the invisible lootable object. Please this in both the     //
//  onOpened and onClosed Events of the "invis_corpse_obj" described in my    //
//  _kb_lootable_corpse script.                                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// begin changes by Q'el
#include "rr_treasure"
// end changes by Q'el
////////////////////////////////////////////////////////////////////////////////

void main()
{
// Commented out by Grug
// Following lines removed to stop that annoying sound
//    effect eQuiet = EffectSilence();
//    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eQuiet, OBJECT_SELF, 120.0f);
//    PlaySound("it_armorleather");
//    DelayCommand(0.2f, PlaySound("it_materialsoft"));
//    DelayCommand(0.3f, PlaySound("it_armorleather"));
//    DelayCommand(0.4f, PlaySound("it_materialsoft"));
//    DelayCommand(0.5f, PlaySound("it_armorleather"));
////////////////////////////////////////////////////////////////////////////////
// begin changes by Q'el
// bring loot generation here for "noloot" NPCs
    object oDeadNPC = GetLocalObject(OBJECT_SELF, "oHostBody");
    if (GetIsObjectValid(oDeadNPC))
    {
        if (GetLocalInt(oDeadNPC, "noloot"))  // chk it is a noloot NPC
        {
            if (!((GetClassByPosition(1, oDeadNPC)==CLASS_TYPE_ANIMAL)||(GetClassByPosition(1, oDeadNPC)==CLASS_TYPE_VERMIN)))
            {
                CT_rr_master_lewt(oDeadNPC, OBJECT_SELF);     //* Use this to create a small amount of treasure on the creature
                int iLootTableID = GetLocalInt(GetArea(oDeadNPC), "LootTableID");
                if (iLootTableID != 0)
                    GenerateTreasure(iLootTableID, oDeadNPC, OBJECT_SELF);
            }
            SetLocalInt(oDeadNPC, "noloot", FALSE);  // its not noloot anymore
        }
    }
// end changes by Q'el
////////////////////////////////////////////////////////////////////////////////

}
