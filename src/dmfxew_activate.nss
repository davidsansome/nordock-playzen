//dmw_activate

// ** This script goes in the OnItemActivation event of your Module
// ** Properties.  It checks to see if the item used is a DM Helper
// ** And if so, and the user isnt a DM, destroys it, otherwise it
// ** Starts the DM Helper working.  "dmw_inc" contains the actual
// ** code that controls the Helpers effects.  If you update anything
// ** in it, you must recompile the calling dmw_<name> script to make
// ** the change take effect.

void main()
{
   object oItem=GetItemActivated();
   object oActivator=GetItemActivator();

   if(GetTag(oItem)=="DMsHelper")
   {
      // Test to make sure the activator is a DM, or is a DM
      // controlling a creature.
      if(GetIsDM(oActivator) != TRUE)
      {
         object oTest = GetFirstPC();
         string sTestName = GetPCPlayerName(oActivator);
         int nFound = FALSE;
         while (GetIsObjectValid(oTest) && (! nFound))
         {
            if (GetPCPlayerName(oTest) == sTestName)
            {
               if(GetIsDM(oTest))
               {
                  nFound = TRUE;
               }
               else
               {
                  DestroyObject(oItem);
                  SendMessageToPC(oActivator,"You are mortal and this is not yours!");
                  return;
               }
            }
            oTest=GetNextPC();
         }
      }
      // get the wand's activator and target, put target info into local vars on activator
      object oMyActivator = GetItemActivator();
      object oMyTarget = GetItemActivatedTarget();
      SetLocalObject(oMyActivator, "dmwandtarget", oMyTarget);
      location lMyLoc = GetItemActivatedTargetLocation();
      SetLocalLocation(oMyActivator, "dmwandloc", lMyLoc);

      //Make the activator start a conversation with itself
      AssignCommand(oMyActivator, ActionStartConversation(oMyActivator, "dmwand", TRUE));
      return;
   }

   if(GetTag(oItem)=="AutoFollow")
   {
      object oTarget = GetItemActivatedTarget();

      if(GetIsObjectValid(oTarget))
      {
         AssignCommand ( oActivator, ActionForceFollowObject(oTarget));
      }
      return;
   }

   if(GetTag(oItem)=="WandOfFX")
   {

       // get the wand's activator and target, put target info into local vars on activator
      object oDM = GetItemActivator();
      object oMyTarget = GetItemActivatedTarget();
      SetLocalObject(oDM, "FXWandTarget", oMyTarget);
      location lTargetLoc = GetItemActivatedTargetLocation();
      SetLocalLocation(oDM, "FXWandLoc", lTargetLoc);

      object oTest=GetFirstPC();
      string sTestName = GetPCPlayerName(oDM);
      // Test to make sure the activator is a DM, or is a DM
      // controlling a creature.

      if(GetIsDM(oDM) != TRUE)
      {
         object oTest = GetFirstPC();
         string sTestName = GetPCPlayerName(oDM);
         int nFound = FALSE;
         while (GetIsObjectValid(oTest) && (! nFound))
         {
            if (GetPCPlayerName(oTest) == sTestName)
            {
               if(GetIsDM(oTest))
               {
                  nFound = TRUE;
               }
               else
               {
                  DestroyObject(oItem);
                  SendMessageToPC(oDM,"You are mortal and this is not yours!");
                  return;
               }
            }
            oTest=GetNextPC();
         }
      }

      //Make the activator start a conversation with itself
      AssignCommand(oDM, ActionStartConversation(oDM, "fxwand", TRUE));
      return;

   }
   if(GetTag(oItem)=="EmoteWand")
   {
      AssignCommand(oActivator, ActionStartConversation(oActivator, "emotewand", TRUE));
      return;
   }
}
