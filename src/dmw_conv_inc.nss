#include "dmw_proto_inc"

//::///////////////////////////////////////////////
//:: File: dmw_conv_inc
//::
//:: Conversation functions for the DM's Helper
//:://////////////////////////////////////////////

int dmwand_BuildConversationDialog(int nCurrent, int nChoice, string sConversation, string sParams)
{
   if(TestStringAgainstPattern(sConversation, "ChangeAlign"))
   {
      return dmw_conv_ChangeAlign(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "DispAttribs"))
   {
      return dmw_conv_DispAttribs(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "DoRoll"))
   {
      return dmw_conv_DoRoll(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "Inventory"))
   {
      return dmw_conv_Inventory(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "ItemListConv"))
   {
      return dmw_conv_ItemListConv(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "ListInventory"))
   {
      return dmw_conv_ListInventory(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "ListPlayers"))
   {
      return dmw_conv_ListPlayers(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "ModAlign"))
   {
      return dmw_conv_ModAlign(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "ModRep"))
   {
      return dmw_conv_ModRep(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "Roll"))
   {
      return dmw_conv_Roll(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "Start"))
   {
      return dmw_conv_Start(nCurrent, nChoice, sParams);
   }
   if(TestStringAgainstPattern(sConversation, "TimeOfDay"))
   {
      return dmw_conv_TimeOfDay(nCurrent, nChoice, sParams);
   }
   return FALSE;
}

void dmwand_BuildConversation(string sConversation, string sParams)
{
   int nLast;
   int nTemp;
   int nChoice = 1;
   int nCurrent = 1;
   int nMatch;

   if(TestStringAgainstPattern(sParams, "prev"))
   {
      //Get the number choice to start with
      nCurrent = GetLocalInt(oMySpeaker, "dmw_dialogprev");

      //Since we're going to the previous page, there will be a next
      SetLocalString(oMySpeaker, "dmw_dialog9", "Next ->");
      SetLocalString(oMySpeaker, "dmw_function9", "conv_" + sConversation);
      SetLocalString(oMySpeaker, "dmw_params9", "next");
      SetLocalInt(oMySpeaker, "dmw_dialognext", nCurrent);

      nChoice = 8;
      for(;nChoice >= 0; nChoice--)
      {
         int nTemp1 = nCurrent;
         int nTemp2 = nCurrent;
         nMatch = nTemp2;
         while((nCurrent == nMatch) && (nTemp2 > 0))
         {
            nTemp2--;
            nMatch = dmwand_BuildConversationDialog(nTemp2, nChoice, sConversation, sParams);
         }

         if(nTemp2 <= 0)
         {
            //we went back too far for some reason, so make this choice blank
            SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), "");
            SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), "");
            SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), "");
         }
         nLast = nTemp;
         nTemp = nTemp1;
         nTemp1 = nMatch;
         nCurrent = nMatch;
      }

      if(nMatch > 0)
      {
         SetLocalString(oMySpeaker, "dmw_dialog1", "<- previous");
         SetLocalString(oMySpeaker, "dmw_function1", "conv_" + sConversation);
         SetLocalString(oMySpeaker, "dmw_params1", "prev");
         SetLocalInt(oMySpeaker, "dmw_dialogprev", nLast);
      }

      //fill the NPC's dialog spot
      //(saved for last because the build process tromps on it)
      dmwand_BuildConversationDialog(0, 0, sConversation, sParams);
   }
   else
   {
      //fill the NPC's dialog spot
      dmwand_BuildConversationDialog(0, 0, sConversation, sParams);

      //No parameters specified, start at the top of the conversation
      if(sParams == "")
      {
         nChoice = 1;
         nCurrent = 1;
      }

      //A "next->" choice was selected
      if(TestStringAgainstPattern(sParams, "next"))
      {
         //get the number choice to start with
         nCurrent = GetLocalInt(oMySpeaker, "dmw_dialognext");

         //set this as the number for the "previous" choice to use
         SetLocalInt(oMySpeaker, "dmw_dialogprev", nCurrent);

         //Set the first dialog choice to be "previous"
         nChoice = 2;
         SetLocalString(oMySpeaker, "dmw_dialog1", "<- Previous");
         SetLocalString(oMySpeaker, "dmw_function1", "conv_" + sConversation);
         SetLocalString(oMySpeaker, "dmw_params1", "prev");
      }

      //Loop through to build the dialog list
      for(;nChoice <= 10; nChoice++)
      {
         nMatch = dmwand_BuildConversationDialog(nCurrent, nChoice, sConversation, sParams);
         //nLast will be the value of the choice before the last one
         nLast = nTemp;
         nTemp = nMatch;
         if(nMatch > 0) { nCurrent = nMatch; }
         if(nMatch == 0) { nLast = 0; }
         nCurrent++;
      }

      //If there were enough choices to fill 10 spots, make spot 9 a "next"
      if(nLast > 0)
      {
         SetLocalString(oMySpeaker, "dmw_dialog9", "Next ->");
         SetLocalString(oMySpeaker, "dmw_function9", "conv_" + sConversation);
         SetLocalString(oMySpeaker, "dmw_params9", "next");
         SetLocalInt(oMySpeaker, "dmw_dialognext", nLast);
      }
   }
}

//:://////////////////////////////////////////////
//:: Dialog functions, in alpha order
//:://////////////////////////////////////////////
//Dialog functions (in general) use the following structure:
/*
int dmw_conv_FunctName(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   //Build the current dialog entry
   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Text to display in the top section.";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         if(TestToDisplayOption())
         {
            nCurrent = 1;
            sText =       "Option text.";
            sCall =       "callthis";
            sCallParams = "passthis";
            break;
         }
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   //Set the local variables for this dialog entry
   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   //Let the caller know which choice matched
   return nCurrent;
}
*/
int dmw_conv_ChangeAlign(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Which direction would you like to change?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Law.";
         sCall =       "conv_ModAlign";
         sCallParams = "law__";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Chaos.";
         sCall =       "conv_ModAlign";
         sCallParams = "chaos";
         break;
      case 3:
         nCurrent = 3;
         sText =       "Good.";
         sCall =       "conv_ModAlign";
         sCallParams = "good_";
         break;
      case 4:
         nCurrent = 4;
         sText =       "Evil.";
         sCall =       "conv_ModAlign";
         sCallParams = "evil_";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_DispAttribs(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "What attributes would you like to see?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Everything.";
         sCall =       "func_ShowAllAttribs";
         sCallParams = "";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Basic Character.";
         sCall =       "func_ShowBasicAttribs";
         sCallParams = "";
         break;
      case 3:
         nCurrent = 3;
         sText =       "Display inventory.";
         sCall =       "func_ShowInventory";
         sCallParams = "";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_DoRoll(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   if((! TestStringAgainstPattern(sParams, "next")) && (! TestStringAgainstPattern(sParams, "prev")))
   {
      SetLocalString(oMySpeaker, "dmw_rollargs", sParams);
   }

   string sArgs = GetLocalString(oMySpeaker, "dmw_rollargs");
   string sStatOrSkill = GetStringLeft(sArgs, 7);
   string sPrivate = GetStringRight(sArgs, 1);

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Which ability?";
         }
         else
         {
            sText =       "Which skill?";
         }
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Strength.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_STRENGTH);
            break;
         }
      case 2:
         nCurrent = 2;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Constitution.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_CONSTITUTION);
            break;
         }
      case 3:
         nCurrent = 3;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Dexterity.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_DEXTERITY);
            break;
         }
      case 4:
         nCurrent = 4;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Intelligence.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_INTELLIGENCE);
            break;
         }
      case 5:
         nCurrent = 5;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Wisdom.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_WISDOM);
            break;
         }
      case 6:
         nCurrent = 6;
         if(TestStringAgainstPattern(sStatOrSkill, "ability"))
         {
            sText =       "Charisma.";
            sCall =       "func_AbilityCheck";
            sCallParams = sPrivate + IntToString(ABILITY_CHARISMA);
            break;
         }
      case 7:
         nCurrent = 7;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Animal Empathy.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_ANIMAL_EMPATHY);
            break;
         }
      case 8:
         nCurrent = 8;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Concentration.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_CONCENTRATION);
            break;
         }
      case 9:
         nCurrent = 9;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Disable Trap.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_DISABLE_TRAP);
            break;
         }
      case 10:
         nCurrent = 10;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Discipline.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_DISCIPLINE);
            break;
         }
      case 11:
         nCurrent = 11;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Heal.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_HEAL);
            break;
         }
      case 12:
         nCurrent = 12;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Hide.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_HIDE);
            break;
         }
      case 13:
         nCurrent = 13;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Listen.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_LISTEN);
            break;
         }
      case 14:
         nCurrent = 14;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Lore.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_LORE);
            break;
         }
      case 15:
         nCurrent = 15;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Move Silently.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_MOVE_SILENTLY);
            break;
         }
      case 16:
         nCurrent = 16;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Open Lock.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_OPEN_LOCK);
            break;
         }
      case 17:
         nCurrent = 17;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Parry.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_PARRY);
            break;
         }
      case 18:
         nCurrent = 18;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Perform.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_PERFORM);
            break;
         }
      case 19:
         nCurrent = 19;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Persuade.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_PERSUADE);
            break;
         }
      case 20:
         nCurrent = 20;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Pick Pocket.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_PICK_POCKET);
            break;
         }
      case 21:
         nCurrent = 21;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Search.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_SEARCH);
            break;
         }
      case 22:
         nCurrent = 22;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Set Trap.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_SET_TRAP);
            break;
         }
      case 23:
         nCurrent = 23;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Spellcraft.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_SPELLCRAFT);
            break;
         }
      case 24:
         nCurrent = 24;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Spot.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_SPOT);
            break;
         }
      case 25:
         nCurrent = 25;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Taunt.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_TAUNT);
            break;
         }
      case 26:
         nCurrent = 26;
         if(TestStringAgainstPattern(sStatOrSkill, "skill__"))
         {
            sText =       "Use Magic Device.";
            sCall =       "func_SkillCheck";
            sCallParams = sPrivate + IntToString(SKILL_USE_MAGIC_DEVICE);
            break;
         }
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_Inventory(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "What would you like to do with this object's inventory?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Work with individual items.";
         sCall =       "conv_ListInventory";
         sCallParams = "";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Take all items.";
         sCall =       "func_TakeAll";
         sCallParams = "";
         break;
      case 3:
         nCurrent = 3;
         sText =       "Take all equipped items.";
         sCall =       "func_TakeAllEquipped";
         sCallParams = "";
         break;
      case 4:
         nCurrent = 4;
         sText =       "Take all unequipped items.";
         sCall =       "func_TakeAllUnequipped";
         sCallParams = "";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_ItemListConv(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";
   int nCache;
   int nCount;
   object oItem;

   if((sParams != "") && (! TestStringAgainstPattern(sParams, "next")) && (! TestStringAgainstPattern(sParams, "prev")))
   {
      //We've been given an item to work with, save that item!
      oItem = GetLocalObject(oMySpeaker, "dmw_itemcache" + sParams);
      SetLocalObject(oMySpeaker, "dmw_item", oItem);
   }
   else
   {
      oItem = GetLocalObject(oMySpeaker, "dmw_item");
   }

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       dmwand_ItemInfo(oItem, 1);
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Take this item.";
         sCall =       "func_TakeItem";
         sCallParams = "";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Destroy this item.";
         sCall =       "func_DestroyItem";
         sCallParams = "";
         break;
      case 3:
         nCurrent = 3;
         if(! GetIdentified(oItem))
         {
            sText =       "Set this item as identified.";
            sCall =       "func_IdentifyItem";
            sCallParams = "";
            break;
         }
      case 4:
         nCurrent = 4;
         if(GetIdentified(oItem))
         {
            sText =       "Set this item as unidentified.";
            sCall =       "func_IdentifyItem";
            sCallParams = "";
            break;
         }
      case 5:
         nCurrent = 5;
         sText =       "Go back to the inventory list.";
         sCall =       "conv_ListInventory";
         sCallParams = "";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_ListInventory(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";
   object oItem;
   int nCache;

   if(sParams == "")
   {
      //This is the first time running this function, so cache the objects
      // of all items... we don't want our list swapping itself around every
      // time you change a page
      int nCount = 1;
      oItem = GetFirstItemInInventory(oMyTarget);
      while(GetIsObjectValid(oItem))
      {
         SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount), oItem);
         oItem = GetNextItemInInventory(oMyTarget);
         nCount++;
      }

      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_ARMS, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_ARROWS, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_BELT, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_BOLTS, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_BOOTS, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_BULLETS, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CHEST, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CLOAK, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_HEAD, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_LEFTRING, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_NECK, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CARMOUR, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oMyTarget));
      SetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCount++), GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oMyTarget));

      nCount--;
      SetLocalInt(oMySpeaker, "dmw_itemcache", nCount);
   }

   nCache = GetLocalInt(oMySpeaker, "dmw_itemcache");

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "What item would you like to see?";
         sCall =       "";
         sCallParams = "";
         break;
      default:
         //Find the next item in the cache that is valid
         oItem = GetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCurrent));
         while((! GetIsObjectValid(oItem)) && (nCurrent <= nCache))
         {
            nCurrent++;
            oItem = GetLocalObject(oMySpeaker, "dmw_itemcache" + IntToString(nCurrent));
         }

         if(nCurrent > nCache)
         {
            //We've run out of cache, any other spots in this list should be
            //skipped
            nCurrent = 0;
            sText =       "";
            sCall =       "";
            sCallParams = "";
         }
         else
         {
            //We found an item, set up the list entry
            sText =       dmwand_ItemInfo(oItem, 0);
            sCall =       "conv_ItemListConv";
            sCallParams = IntToString(nCurrent);
         }
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_ListPlayers(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";
   object oPlayer;
   int nCache;

   if((! TestStringAgainstPattern(sParams, "next")) && (! TestStringAgainstPattern(sParams, "prev")))
   {
      //This is the first time running this function, so cache the objects
      // of all players... we don't want our list swapping itself around every
      // time you change a page
      SetLocalString(oMySpeaker, "dmw_playerfunc", sParams);
      int nCount = 1;
      oPlayer = GetFirstPC();
      while(GetIsObjectValid(oPlayer))
      {
         SetLocalObject(oMySpeaker, "dmw_playercache" + IntToString(nCount), oPlayer);
         oPlayer = GetNextPC();
         nCount++;
      }
      nCount--;
      SetLocalInt(oMySpeaker, "dmw_playercache", nCount);
   }

   string sFunc = GetLocalString(oMySpeaker, "dmw_playerfunc");
   nCache = GetLocalInt(oMySpeaker, "dmw_playercache");

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Who would you like to work on?";
         sCall =       "";
         sCallParams = "";
         break;
      default:
         //Find the next player in the cache who is valid
         oPlayer = GetLocalObject(oMySpeaker, "dmw_playercache" + IntToString(nCurrent));
         while((! GetIsObjectValid(oPlayer)) && (nCurrent <= nCache))
         {
            nCurrent++;
            oPlayer = GetLocalObject(oMySpeaker, "dmw_playercache" + IntToString(nCurrent));
         }

         if(nCurrent > nCache)
         {
            //We've run out of cache, any other spots in this list should be
            //skipped
            nCurrent = 0;
            sText =       "";
            sCall =       "";
            sCallParams = "";
         }
         else
         {
            //We found a player, set up the list entry
            sText =       GetName(oPlayer) + " (" + GetPCPlayerName(oPlayer) + ")";
            sCall =       sFunc;
            sCallParams = IntToString(nCurrent);
         }
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_ModAlign(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Change by how much?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "1 point.";
         sCall =       "func_ShiftAlignment";
         sCallParams = sParams + "1";
         break;
      case 2:
         nCurrent = 2;
         sText =       "5 points.";
         sCall =       "func_ShiftAlignment";
         sCallParams = sParams + "5";
         break;
      case 3:
         nCurrent = 3;
         sText =       "10 points.";
         sCall =       "func_ShiftAlignment";
         sCallParams = sParams + "10";
         break;
      case 4:
         nCurrent = 4;
         sText =       "20 points.";
         sCall =       "func_ShiftAlignment";
         sCallParams = sParams + "20";
         break;
      case 5:
         nCurrent = 5;
         sText =       "50 points.";
         sCall =       "func_ShiftAlignment";
         sCallParams = sParams + "50";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_ModRep(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";
   string sOneOrAll;

   if((! TestStringAgainstPattern(sParams, "next")) && (! TestStringAgainstPattern(sParams, "prev")))
   {
      SetLocalString(oMySpeaker, "dmw_repargs", sParams);
   }
   sOneOrAll = GetLocalString(oMySpeaker, "dmw_repargs");

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Change reputation by how much?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Plus 70";
         sCall =       "func_ModRep";
         sCallParams = "+70";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Plus 30";
         sCall =       "func_ModRep";
         sCallParams = "+30";
         break;
      case 3:
         nCurrent = 3;
         sText =       "Plus 10";
         sCall =       "func_ModRep";
         sCallParams = "+10";
         break;
      case 4:
         nCurrent = 4;
         sText =       "Plus 5";
         sCall =       "func_ModRep";
         sCallParams = "+05";
         break;
      case 5:
         nCurrent = 5;
         sText =       "Minus 5";
         sCall =       "func_ModRep";
         sCallParams = "-05";
         break;
      case 6:
         nCurrent = 6;
         sText =       "Minus 10";
         sCall =       "func_ModRep";
         sCallParams = "-10";
         break;
      case 7:
         nCurrent = 7;
         sText =       "Minus 30";
         sCall =       "func_ModRep";
         sCallParams = "-30";
         break;
      case 8:
         nCurrent = 8;
         sText =       "Minus 70";
         sCall =       "func_ModRep";
         sCallParams = "-70";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_Roll(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Should This Roll be Public or Private?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "Public";
         sCall =       "conv_DoRoll";
         sCallParams = sParams + "0";
         break;
      case 2:
         nCurrent = 2;
         sText =       "Private";
         sCall =       "conv_DoRoll";
         sCallParams = sParams + "1";
         break;
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_Start(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "Hello there, DM.  What can I do for you?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Display this creature's attributes.";
            sCall =       "conv_DispAttribs";
            sCallParams = "";
            break;
         }
      case 2:
         nCurrent = 2;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Change this creature's alignment.";
            sCall =       "conv_ChangeAlign";
            sCallParams = "";
            break;
         }
      case 3:
         nCurrent = 3;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Map area out for this player.";
            sCall =       "func_MapArea";
            sCallParams = "";
            break;
         }
      case 4:
         nCurrent = 4;
         if(dmwand_istargetinventory())
         {
            sText =       "Work with this object's inventory.";
            sCall =       "conv_Inventory";
            sCallParams = "";
            break;
         }
     case 5:
         nCurrent = 5;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Follow this creature.";
            sCall =       "func_FollowTarget";
            sCallParams = "";
            break;
         }
      case 6:
         nCurrent = 6;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Make this creature follow me.";
            sCall =       "func_FollowMe";
            sCallParams = "";
            break;
         }
      case 7:
         nCurrent = 7;
         if(dmwand_istargetpcornpcnme())
         {
            sText =       "Make this creature go about its business.";
            sCall =       "func_ResumeDefault";
            sCallParams = "";
            break;
         }
      case 8:
         nCurrent = 8;
         if(dmwand_istargetpcnme())
         {
            sText =       "Penguin this player.";
            sCall =       "func_Toad";
            sCallParams = "";
            break;
         }
      case 9:
         nCurrent = 9;
         if(dmwand_istargetpcnme())
         {
            sText =       "Unpenguin this player.";
            sCall =       "func_Untoad";
            sCallParams = "";
            break;
         }
      case 10:
         nCurrent = 10;
         if(dmwand_istargetpcnme())
         {
            sText =       "Boot this player.";
            sCall =       "func_KickPC";
            sCallParams = "";
            break;
         }
      case 11:
         nCurrent = 11;
         if(dmwand_istargetnpc())
         {
            sText =       "Kill this, leaving a corpse.";
            sCall =       "func_KillAndReplace";
            sCallParams = "";
            break;
         }
      case 12:
         nCurrent = 12;
         if(dmwand_istargetinvalid())
         {
            sText =       "List all players...";
            sCall =       "conv_ListPlayers";
            sCallParams = "func_PlayerListConv";
            break;
         }
      case 13:
         nCurrent = 13;
         if(dmwand_istargetinvalid())
         {
            sText =       "Advance the current time of day.";
            sCall =       "conv_TimeOfDay";
            sCallParams = "";
            break;
         }
      case 14:
         nCurrent = 14;
         if(dmwand_istargetinvalid())
         {
            sText =       "Reload the current running module.";
            sCall =       "func_ReloadModule";
            sCallParams = "";
            break;
         }
      case 15:
         nCurrent = 15;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Roll a skill check.";
            sCall =       "conv_Roll";
            sCallParams = "skill__";
            break;
         }
      case 16:
         nCurrent = 16;
         if(dmwand_istargetpcornpc())
         {
            sText =       "Roll an ability check.";
            sCall =       "conv_Roll";
            sCallParams = "ability";
            break;
         }
      case 17:
         nCurrent = 17;
         if(dmwand_istargetdestroyable())
         {
            sText =       "Destroy this object.";
            sCall =       "func_DestroyTarget";
            sCallParams = "";
            break;
         }
      case 18:
         nCurrent = 18;
         if((!dmwand_istargetdestroyable()) && dmwand_isnearbydestroyable())
         {
            sText =       "Destroy an object near this spot.";
            sCall =       "func_DestroyNearbyTarget";
            sCallParams = "";
            break;
         }
      case 19:
         nCurrent = 19;
         if(dmwand_istargetdestroyable())
         {
            sText =       "Turn this object on.";
            sCall =       "func_TurnTargetOn";
            sCallParams = "";
            break;
         }
      case 20:
         nCurrent = 20;
         if(dmwand_istargetdestroyable())
         {
            sText =       "Turn this object off.";
            sCall =       "func_TurnTargetOff";
            sCallParams = "";
            break;
         }
      case 21:
         nCurrent = 21;
         if((!dmwand_istargetdestroyable()) && dmwand_isnearbydestroyable())
         {
            sText =       "Turn on an object near this spot.";
            sCall =       "func_TurnNearOn";
            sCallParams = "";
            break;
         }
      case 22:
         nCurrent = 22;
         if((!dmwand_istargetdestroyable()) && dmwand_isnearbydestroyable())
         {
            sText =       "Turn off an object near this spot.";
            sCall =       "func_TurnNearOff";
            sCallParams = "";
            break;
         }
      case 23:
         nCurrent = 23;
         if(dmwand_istargetnpc())
         {
            sText =       "Change a player's reputation with this creature's faction.";
            sCall =       "conv_ModRep";
            sCallParams = "one";
            break;
         }
      case 24:
         nCurrent = 24;
         if(dmwand_istargetnpc())
         {
            sText =       "Change all player reputations with this creature's faction.";
            sCall =       "conv_ModRep";
            sCallParams = "all";
            break;
         }
      case 25:
         nCurrent = 25;
         if(dmwand_istargetinvalid())
         {
            sText =       "Export all characters.";
            sCall =       "func_ExportChars";
            sCallParams = "";
            break;
         }
      case 26:
         nCurrent = 26;
         if(dmwand_istargetpcnme())
         {
            sText =       "Join this player's party.";
            sCall =       "func_JoinParty";
            sCallParams = "";
            break;
         }
      case 27:
         nCurrent = 27;
         if(dmwand_istargetinvalid())
         {
            sText =       "Remove me from my current party.";
            sCall =       "func_LeaveParty";
            sCallParams = "";
            break;
         }
      case 28:
         nCurrent = 28;
         if(dmwand_istargetpcnme())
         {
            sText =       "Jump this player to my location.";
            sCall =       "func_JumpPlayerHere";
            sCallParams = "";
            break;
         }
      case 29:
         nCurrent = 29;
         if(dmwand_istargetpcnme())
         {
            sText =       "Jump me to this player's location.";
            sCall =       "func_JumpToPlayer";
            sCallParams = "";
            break;
         }
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}

int dmw_conv_TimeOfDay(int nCurrent, int nChoice, string sParams = "")
{
   string sText = "";
   string sCall = "";
   string sCallParams = "";

   switch(nCurrent)
   {
      case 0:
         nCurrent = 0;
         sText =       "How far would you like to advance the time?";
         sCall =       "";
         sCallParams = "";
         break;
      case 1:
         nCurrent = 1;
         sText =       "1 hour.";
         sCall =       "func_AdvanceTime";
         sCallParams = "1";
         break;
      case 2:
         nCurrent = 2;
         sText =       "3 hours.";
         sCall =       "func_AdvanceTime";
         sCallParams = "3";
         break;
      case 3:
         nCurrent = 3;
         sText =       "7 hours.";
         sCall =       "func_AdvanceTime";
         sCallParams = "7";
         break;
      case 4:
         nCurrent = 4;
         if((GetTimeHour() > 6) && (GetTimeHour() < 18))
         {
            sText =       "Make it nighttime.";
            sCall =       "func_SwapDayNight";
            sCallParams = "0";
            break;
         }
      case 5:
         nCurrent = 5;
         if((GetTimeHour() < 6) || (GetTimeHour() > 18))
         {
            sText =       "Make it daytime.";
            sCall =       "func_SwapDayNight";
            sCallParams = "1";
            break;
         }
      default:
         nCurrent = 0;
         sText =       "";
         sCall =       "";
         sCallParams = "";
         break;
   }

   SetLocalString(oMySpeaker, "dmw_dialog" + IntToString(nChoice), sText);
   SetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice), sCall);
   SetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice), sCallParams);

   return nCurrent;
}
