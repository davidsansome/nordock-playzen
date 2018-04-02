//==//////////////////////////////////////////////////////////
// saveall_sub
// Created by: Iznoghoud
// Created on: 26th December 2003
// Last Modified: 19th January 3004
/*
 This script works in conjunction with my Greater Wildshape
 script to preserve the item bonuses while the shifter is in
 polymorphed shape, after an ExportAllCharacters() or
 ExportSingleCharacter() is done.
*/
//==//////////////////////////////////////////////////////////

#include "ws_inc_shifter"

void main()
{
    object oPC = OBJECT_SELF;
    int nPolyed;
    effect ePoly;
    int    nPoly;
    int nSpell;

    object oWeaponOld;
    object oArmorOld;
    object oRing1Old ;
    object oRing2Old;
    object oAmuletOld;
    object oCloakOld ;
    object oBootsOld  ;
    object oBeltOld   ;
    object oHelmetOld;
    object oShield ;
    object oBracerOld;
    object oHideOld;

    object oWeaponNew;
    object oArmorNew;
    object oClawLeft;
    object oClawRight;
    object oBite;

    int bWeapon;
    int bArmor;
    int bItems;
    int bCopyGlovesToClaws;

        nPoly = GetLocalInt(oPC, "GW_PolyID");

        if ( nPoly == 0 ) // Player's PolyID is not set (assuming the polymorph "werewolf" is not available to shifters)
        {
            oPC = GetNextPC();
            return;
        }
        //Assume the normal shape doesn't have a creature skin object.
        //If using a subracesystem or something else that places a skin on the normal shape
        //another condition is needed to decide whether or not to the PC is polymorphed.
        //One way could be to scan all effects to see whether one is a polymorph effect.
        nPolyed = GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC));
        if ( nPolyed )
        {
            nSpell = ScanForPolymorphEffect(oPC);

            // Here we see if the polymorph is not one of the non-shifter or non-druid polymorph abilities
            // Note: Druid wildshapes will get converted to a PERMANENT duration!
            // There is no way to get the duration left on an effect.
            // Change the number 396 to 405 to not allow druid wildshapes' properties to be reapplied.
            if ( ( nSpell >= 387 && nSpell <= 396 ) ||       // Shapechange, Polymorph Self
                   nSpell == SPELL_TENSERS_TRANSFORMATION || // Tensers Transformation
                   nSpell == -2 )                            // Not polymorphed. This could happen if there is a subracesystem using creature hides in place.
            {
                oPC = GetNextPC();
                return;
            }
            // If we get past this check, the polymorph must have been a shifter polymorph, or
            // no spell id applied this polymorph effect. We'll assume this means that it was a
            // shifter polymorph effect that was re-applied by this script (which cannot
            // attach a spell id to the re-applied effect) before this save.

            //--------------------------------------------------------------------------
            // Determine which items get their item properties merged onto the shifters
            // new form.
            //--------------------------------------------------------------------------
            bWeapon = GetLocalInt(oPC, "GW_bWeapon");
            bArmor = GetLocalInt(oPC, "GW_bArmor");
            bItems = GetLocalInt(oPC, "GW_bItems");
            bCopyGlovesToClaws = FALSE;

            // Get the items stored earlier to reapply their effects.
            oWeaponOld =     GetLocalObject(oPC,"GW_OldWeapon");
            oArmorOld  =     GetLocalObject(oPC,"GW_OldArmor");
            oRing1Old  =     GetLocalObject(oPC,"GW_OldRing1");
            oRing2Old  =     GetLocalObject(oPC,"GW_OldRing2");
            oAmuletOld =     GetLocalObject(oPC,"GW_OldAmulet");
            oCloakOld  =     GetLocalObject(oPC,"GW_OldCloak");
            oBootsOld  =     GetLocalObject(oPC,"GW_OldBoots");
            oBeltOld   =     GetLocalObject(oPC,"GW_OldBelt");
            oHelmetOld =     GetLocalObject(oPC,"GW_OldHelmet");
            oShield    =     GetLocalObject(oPC,"GW_OldShield");
            oBracerOld =     GetLocalObject(oPC,"GW_OldBracer");
            oHideOld   =     GetLocalObject(oPC,"GW_OldHide");

            //--------------------------------------------------------------------------
            // Here the actual polymorphing is done
            //--------------------------------------------------------------------------
            ePoly = EffectPolymorph(nPoly);
            //--------------------------------------------------------------------------
            // Iznoghoud: Link the stackable properties as permanent bonuses to the
            // Polymorph effect, instead of putting them on the creature hide. They will
            // properly disappear as soon as the polymorph is ended.
            //--------------------------------------------------------------------------
            ePoly = AddStackablePropertiesToPoly ( oPC, ePoly, bWeapon, bItems, bArmor, oArmorOld, oRing1Old, oRing2Old, oAmuletOld, oCloakOld, oBracerOld, oBootsOld, oBeltOld, oHelmetOld, oShield, oWeaponOld, oHideOld);
            ePoly = ExtraordinaryEffect(ePoly);

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoly, oPC);

            //--------------------------------------------------------------------------
            // This code handles the merging of item properties
            //--------------------------------------------------------------------------
            object oWeaponNew = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
            object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
            object oClawLeft = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oPC);
            object oClawRight = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oPC);
            object oBite = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oPC);

            //--------------------------------------------------------------------------
            // ...Weapons
            //--------------------------------------------------------------------------
            if (bWeapon)
            {
                //----------------------------------------------------------------------
                // GZ: 2003-10-20
                // Sorry, but I was forced to take that out, it was confusing people
                // and there were problems with updating the stats sheet.
                //----------------------------------------------------------------------
                /* if (!GetIsObjectValid(oWeaponOld))
                {
                    //------------------------------------------------------------------
                    // If we had no weapon equipped before, remove the old weapon
                    // to allow monks to change into unarmed forms by not equipping any
                    // weapon before polymorphing
                    //------------------------------------------------------------------
                    DestroyObject(oWeaponNew);
                }
                else*/
                {
                    //------------------------------------------------------------------
                    // Merge item properties...
                    //------------------------------------------------------------------
                    WildshapeCopyWeaponProperties(oPC, oWeaponOld,oWeaponNew);
                }
            }
            else {
                switch ( GW_COPY_WEAPON_PROPS_TO_UNARMED )
                {
                case 1: // Copy over weapon properties to claws/bite
                    WildshapeCopyNonStackProperties(oWeaponOld,oClawLeft, TRUE);
                    WildshapeCopyNonStackProperties(oWeaponOld,oClawRight, TRUE);
                    WildshapeCopyNonStackProperties(oWeaponOld,oBite, TRUE);
                    break;
                case 2: // Copy over glove properties to claws/bite
                    WildshapeCopyNonStackProperties(oBracerOld,oClawLeft, FALSE);
                    WildshapeCopyNonStackProperties(oBracerOld,oClawRight, FALSE);
                    WildshapeCopyNonStackProperties(oBracerOld,oBite, FALSE);
                    bCopyGlovesToClaws = TRUE;
                    break;
                case 3: // Copy over weapon properties to claws/bite if wearing a weapon, otherwise copy gloves
                    if ( GetIsObjectValid(oWeaponOld) )
                    {
                        WildshapeCopyNonStackProperties(oWeaponOld,oClawLeft, TRUE);
                        WildshapeCopyNonStackProperties(oWeaponOld,oClawRight, TRUE);
                        WildshapeCopyNonStackProperties(oWeaponOld,oBite, TRUE);
                    }
                    else
                    {
                        WildshapeCopyNonStackProperties(oBracerOld,oClawLeft, FALSE);
                        WildshapeCopyNonStackProperties(oBracerOld,oClawRight, FALSE);
                        WildshapeCopyNonStackProperties(oBracerOld,oBite, FALSE);
                        bCopyGlovesToClaws = TRUE;
                    }
                    break;
                default: // Do not copy over anything
                    break;
                };
            }
            //--------------------------------------------------------------------------
            // ...Armor
            //--------------------------------------------------------------------------
            if (bArmor)
            {
                //----------------------------------------------------------------------
                // Merge item properties from armor and helmet...
                //----------------------------------------------------------------------
                WildshapeCopyNonStackProperties(oArmorOld,oArmorNew);
                WildshapeCopyNonStackProperties(oHelmetOld,oArmorNew);
                WildshapeCopyNonStackProperties(oShield,oArmorNew);
                WildshapeCopyNonStackProperties(oHideOld,oArmorNew);
            }
            //--------------------------------------------------------------------------
            // ...Magic Items
            //--------------------------------------------------------------------------
            if (bItems)
            {
                //----------------------------------------------------------------------
                // Merge item properties from from rings, amulets, cloak, boots, belt
                // Iz: And bracers, in case oBracerOld gets set to a valid object.
                //----------------------------------------------------------------------
                WildshapeCopyNonStackProperties(oRing1Old,oArmorNew);
                WildshapeCopyNonStackProperties(oRing2Old,oArmorNew);
                WildshapeCopyNonStackProperties(oAmuletOld,oArmorNew);
                WildshapeCopyNonStackProperties(oCloakOld,oArmorNew);
                WildshapeCopyNonStackProperties(oBootsOld,oArmorNew);
                WildshapeCopyNonStackProperties(oBeltOld,oArmorNew);
                WildshapeCopyNonStackProperties(oBracerOld,oArmorNew);
            }
        }

}
