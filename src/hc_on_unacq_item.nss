// HardCore Module Destruction of dropped object
// Archaegeo 2002 Jun 24th

// 28 June 2002 Now also works with the drag corpse system to move players about

// Update: No Drop Script added for the subrace spell-like ability items
// - Panduh

#include "hc_inc"
#include "hc_inc_transfer"
#include "hc_inc_on_unacq"
#include "hc_text_unacq"
#include "subraces"
//#include "i_tagtests"
//#include "ats_inc_unacq"

void main()
{
    if(!preEvent()) return;
    // Removed by Robin (1st Mar 2005) - The function seems to do nothing
    //ATS_OnUnAcquireItem(GetModuleItemLost(), GetModuleItemLostBy(),
    //    GetModuleItemAcquiredFrom());
    object oDropped = GetModuleItemLost();
    string sDTag=GetTag(oDropped);
    object oPC=GetModuleItemLostBy();

    // Check if the lost item is one that was disarmed
    if (GetIsPC(oPC) && (GetLocalInt(oDropped, "RecentlyUnEquipped") == 1))
    {
        if (!GetIsObjectValid(GetItemPossessor(oDropped)))
        {
            // Only true if item has dropped to the ground (has no possessor)
            object oCopy = CopyItem(oDropped, oPC, TRUE);
            DestroyObject(oDropped);
            DeleteLocalInt(oCopy, "RecentlyUnEquipped");
        }
    }

//    if(GetTag(GetArea(oPC))=="FuguePlane")
//    {
//        object oPoss=GetItemPossessor(oDropped);
//        if(sDTag=="fugue_NOD" && oPoss==OBJECT_INVALID
//            && GetTag(GetArea(oDropped))=="")
//        {
//            SendMessageToPC(oPC,"You are not allowed to trade a fugue robe.");
//            SendMessageToAllDMs(GetName(oPC)+" tried to trade a fugue robe. "+
//                    "If you see this message again, they are cloneing robes.");
//            object oFR=CreateItemOnObject("fugue_NOD",oPC);
//            postEvent();
//            return;
//        }
//        if(sDTag=="fugue_NOD")
//        {
//            object oFR=CreateItemOnObject("fugue_NOD",oPC);
//            SendMessageToPC(oPC,NODROP);
//            DestroyObject(oDropped);
//            postEvent();
//            return;
//       }
//        AssignCommand(oPC, ActionPickUpItem(oDropped));
//        SendMessageToPC(oPC,NODROP);
//        postEvent();
//        return;
//    }
//    else if(sDTag=="fugue_NOD")
//    {
//        DestroyObject(oDropped);
//    }

// If someone drops a corpse, move the Death Corpse (item container) to where
// the PC Token was dropped, and then put the PC Token back in it
    if(GetLocalInt(oMod,"LOOTSYSTEM"))
    {
       if(sDTag=="PlayerCorpse")
       {
            object oPoss=GetItemPossessor(oDropped);
            if(oPoss==OBJECT_INVALID && GetTag(GetArea(oDropped))=="")
            {
                postEvent();
                return;
            }
            object oDC=GetLocalObject(oDropped,"DeathCorpse");
            object oOwner=GetLocalObject(oDropped,"Owner");
            string sName=GetLocalString(oDropped,"Name");
            string sCDK=GetLocalString(oDropped,"Key");

// If a Death Corpse exits, move all the stuff from the old one to the new one
// at the new location
            object oDeadMan;
            object oDeathCorpse;
            if(GetIsObjectValid(oDC))
            {
                oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse",
                                    GetLocation(oDropped));
            }
// Otherwise make a Death Corpse to put the new Player Corpse Token on
            else
                oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse",
                                    GetLocation(oDropped));

// Make a new PC Token to put on the new Death Corpse
            oDeadMan=CreateItemOnObject("PlayerCorpse", oDeathCorpse);
            SetLocalObject(oDeadMan,"Owner",oOwner);
            SetLocalString(oDeadMan,"Name",sName);
            SetLocalString(oDeadMan,"Key", sCDK);
            SetLocalObject(oDeadMan,"DeathCorpse",oDeathCorpse);
            SetLocalInt(oDeadMan,"Alignment",GetLocalInt(oDropped,"Alignment"));
            SetLocalString(oDeadMan,"Deity",GetLocalString(oDropped,"Deity"));
            SetLocalObject(oMod,"DeathCorpse"+sName+sCDK,oDeathCorpse);
            SetLocalObject(oMod,"PlayerCorpse"+sName+sCDK,oDeadMan);
            SetLocalObject(oDeathCorpse,"Owner",oOwner);
            SetLocalString(oDeathCorpse,"Name",sName);
            SetLocalString(oDeathCorpse,"Key",sCDK);
            SetLocalObject(oDeathCorpse,"PlayerCorpse",oDeadMan);
// Destroy the old dropped PC Token
            DestroyObject(oDropped);
            hcTransferObjects(oDC, oDeathCorpse);
       }
    }

  /**************************************************
  * Start of Scott Thorne's "No Drop Items" script
  * This script makes the PC pick "undroppable"
  * items back up and take items back
  * from placeables and other PC's
  * if they decide to drop it or barter it.
  *
  * We will be using this for the subrace spell-like
  * ability items.
  *
  *  - Panduh
  **************************************************/
  /* <-- Remove this to return the no-drop script to functionality
if (GetIsNoDrop(oDropped))
{

    object oLostBy = GetLocalObject(oDropped, "ND_OWNER");
    if (oLostBy == OBJECT_INVALID)
        {
            oLostBy = oPC;
            SetLocalObject(oDropped, "ND_OWNER",oPC);
        }


    if (GetIsPC(oLostBy))
    {

        string sItemName = GetName(oDropped);
        object oPossessor = GetItemPossessor(oDropped);

//Debug("Item = " + sItemName);
//Debug("LostBy = " + GetName(oLostBy));
//Debug("Possesor = " + GetName(oPossessor));

        switch (GetObjectType(oPossessor))
        {

        case OBJECT_TYPE_CREATURE:

//Debug("Bartered with a PC or taken by an NPC");
            break;  // no action, PC will give it back in OnAcquireItem


        case OBJECT_TYPE_STORE:

//Debug("Sold to a merchant");
            AssignCommand(oLostBy, ActionTakeItem(oDropped, oPossessor));
            SendMessageToPC(oLostBy, "The "+ sItemName + " mysteriously reappears in your pack!");
            break;


        case OBJECT_TYPE_PLACEABLE:

//Debug("Placed into a container");
            AssignCommand(oLostBy, ActionTakeItem(oDropped, oPossessor));
            SendMessageToPC(oLostBy, "The "+ sItemName + " mysteriously reappears in your pack!");
            break;


        default:

            if (GetIsObjectValid(GetAreaFromLocation(GetLocation(oDropped))))
            {

//Debug("Dropped on the ground");
                AssignCommand(oLostBy, ActionDoCommand(SetCommandable(FALSE, oLostBy)));
                AssignCommand(oLostBy, ActionSpeakString("Oops, I dropped something!"));
                AssignCommand(oLostBy, ActionMoveToObject(oDropped, TRUE));
                AssignCommand(oLostBy, ActionPickUpItem(oDropped));
                AssignCommand(oLostBy, ActionDoCommand(SetCommandable(TRUE, oLostBy)));

            }
            else
            {

                // no action, PC will give it back in OnAcquireItem

            }

        }  // switch

    }  // if GetIsPC()

}  // if GetIsNoDrop()
/**********************************
* End Scott Thorne's No-Drop Script
**********************************/

  postEvent();
}
