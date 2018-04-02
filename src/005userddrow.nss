//::///////////////////////////////////////////////
//:: User Defined Script
//:://////////////////////////////////////////////
//:: Created By: Implimian
//:: Created On: August 2002
//:://////////////////////////////////////////////
#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"
#include "nw_i0_henchman"
////////////////////////////////////////////////////////////////////
void main()
{
int nEvent=GetUserDefinedEventNumber();
//=================================================================//
if(nEvent==1001)  // Called by Heart Beat
  {
     //This is just to give The Solider something to do while he/she waits for you to recruit them---//
     //
     int nCheckConvState = GetLocalInt(GetModule(),"005_CONV_STATE");
     if (nCheckConvState == FALSE)
        {
        if (IsInConversation(OBJECT_SELF) == FALSE)//No animations while I'm talking...it would be rude//
        {
        int nWhatToDo = d20();
        if (nWhatToDo <= 19)
            {
            ClearAllActions();
            ActionPlayAnimation (ANIMATION_LOOPING_SIT_CROSS, 1.0, 8.0);
            }
        else if (nWhatToDo == 20)
            {
            object oWPcampfire = GetObjectByTag("010_campfire");
            object oWP = GetObjectByTag("010_katyane_rest");
            ClearAllActions();
            ActionForceMoveToObject(oWP, FALSE, 0.5f, 5.0f);
            ActionDoCommand(SetFacingPoint(GetPosition(oWPcampfire)));
            ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0);
            ActionWait(1.0f);
            ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0, 0.0);
            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0, 0.0);
            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 1.0, 0.0);
            ActionWait(1.0f);
            ActionPlayAnimation (ANIMATION_LOOPING_SIT_CROSS, 1.0, 8.0);
            ActionDoCommand(SetCommandable(TRUE));
            SetCommandable(FALSE);
            }
        }
        }
    //-----------------------------------------------------------------//
    //Special henchmen commands//
    //Pass Down New Orders---we use the heartbeat event to pass down new orders//
    string sIndex = GetName(OBJECT_SELF) + "_ORDERS";
    int nLastOrders = GetLocalInt(GetModule(),sIndex);
    int nNewOrders = GetLastAssociateCommand(OBJECT_SELF);
    if (nNewOrders != nLastOrders)//My orders are different than they were last heartbeat
       {
        if (nNewOrders == ASSOCIATE_COMMAND_GUARDMASTER)//Guard Master
            {
            SignalEvent(GetHenchman(OBJECT_SELF), EventUserDefined(1205));
            SetLocalInt(GetModule(),sIndex,nNewOrders);
            }
        else if (nNewOrders == ASSOCIATE_COMMAND_STANDGROUND)//Stand Ground
            {
            SignalEvent(GetHenchman(OBJECT_SELF), EventUserDefined(1206));
            SetLocalInt(GetModule(),sIndex,nNewOrders);
             }
        else if (nNewOrders == ASSOCIATE_COMMAND_FOLLOWMASTER)//Follow Me
             {
             SignalEvent(GetHenchman(OBJECT_SELF), EventUserDefined(1207));
             SetLocalInt(GetModule(),sIndex,nNewOrders);
             }
        else if (nNewOrders == ASSOCIATE_COMMAND_ATTACKNEAREST)//Attack
            {
             SignalEvent(GetHenchman(OBJECT_SELF), EventUserDefined(1208));
             SetLocalInt(GetModule(),sIndex,nNewOrders);
             }
        }
    //-----------------------------------------------------------------//
    }
//=================================================================//
else if(nEvent==1007) // Called by Death
   {
    //-----------------------------------------------------------------//
    ClearAllActions();
    ActionSpeakString("Lloth take your soul...", TALKVOLUME_TALK);
    //-----------------------------------------------------------------//
    //Special henchmen commands//
    //Disband the henchman queue if I die
    if (GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
        object oHench = GetHenchman(OBJECT_SELF);
        ResetHenchmenState();
        RemoveHenchman(OBJECT_SELF, oHench);
        SignalEvent(oHench, EventUserDefined(1202));
        }
    //-----------------------------------------------------------------//
     }//--End of Death Script--------------------------------------//
//=================================================================//
// 1200 Series for custom henchmen commands
//=================================================================//
else if (nEvent==1201) //Assign New Master (demote 1 in Henchmen queue)
   {
    object oNewMaster = GetLocalObject(GetModule(),"000_NEW_MASTER");
    ResetHenchmenState();
    ClearAllActions();
    AddHenchman(oNewMaster,OBJECT_SELF);
   }
//=================================================================//
else if (nEvent==1202) //If Master is a henchman and is disbanded, disband my henchman and have him do the same
   {
    if (GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
        object oHench = GetHenchman(OBJECT_SELF);
        ClearAllActions();
        ResetHenchmenState();
        RemoveHenchman(OBJECT_SELF, oHench);
        SignalEvent(oHench, EventUserDefined(1202));
        }
   }
//=================================================================//
else if (nEvent==1203) //Go to Melee Combat
   {
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
    ClearAllActions();
    EquipAppropriateWeapons(GetMaster());
    //Signal Henchmen to Go to Melee
    if (GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
        object oHench = GetHenchman(OBJECT_SELF);
        SignalEvent(oHench, EventUserDefined(1203));
        }
   }
//=================================================================//
else if (nEvent==1204) //Go to Ranged Combat
   {
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON);
    ClearAllActions();
    EquipAppropriateWeapons(GetMaster());
    //Signal Henchmen to Go to Ranged
    if (GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
        object oHench = GetHenchman(OBJECT_SELF);
        SignalEvent(oHench, EventUserDefined(1204));
        }
   }
//=================================================================//
else if (nEvent==1205) //Pass Down Orders: DEFEND
   {
    string sIndex = GetName(OBJECT_SELF) + "_ORDERS";
    RespondToShout(GetMaster(OBJECT_SELF),ASSOCIATE_COMMAND_GUARDMASTER);
    SetLocalInt(GetModule(),sIndex,ASSOCIATE_COMMAND_GUARDMASTER);
    //Signal Henchmen to Defend
    if (GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
        object oHench = GetHenchman(OBJECT_SELF);
        SignalEvent(oHench, EventUserDefined(1205));
        }
   }
//=================================================================//
else if (nEvent==1206) //Pass Down Orders: STAND GROUND
   {
    string sIndex = GetName(OBJECT_SELF) + "_ORDERS";
    RespondToShout(GetMaster(OBJECT_SELF),ASSOCIATE_COMMAND_STANDGROUND);
    SetLocalInt(GetModule(),sIndex,ASSOCIATE_COMMAND_STANDGROUND);
    //Signal Henchmen to Stand Ground
    if (GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
        object oHench = GetHenchman(OBJECT_SELF);
        SignalEvent(oHench, EventUserDefined(1206));
        }
   }
//=================================================================//
else if (nEvent==1207) //Pass Down Orders: FOLLOW MASTER
   {
    string sIndex = GetName(OBJECT_SELF) + "_ORDERS";
    RespondToShout(GetMaster(OBJECT_SELF),ASSOCIATE_COMMAND_FOLLOWMASTER);
    SetLocalInt(GetModule(),sIndex,ASSOCIATE_COMMAND_FOLLOWMASTER);
    //Signal Henchmen to Follow Master
    if (GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
        object oHench = GetHenchman(OBJECT_SELF);
        SignalEvent(oHench, EventUserDefined(1207));
        }
   }
//=================================================================//
else if (nEvent==1208) //Pass Down Orders: ATTACK NEAREST
   {
    string sIndex = GetName(OBJECT_SELF) + "_ORDERS";
    RespondToShout(GetMaster(OBJECT_SELF),ASSOCIATE_COMMAND_ATTACKNEAREST);
    SetLocalInt(GetModule(),sIndex,ASSOCIATE_COMMAND_ATTACKNEAREST);
    //Signal Henchmen to Attack
    if (GetIsObjectValid(GetHenchman(OBJECT_SELF)) == TRUE)
        {
        object oHench = GetHenchman(OBJECT_SELF);
        SignalEvent(oHench, EventUserDefined(1208));
        }
   }
//=================================================================//
}
