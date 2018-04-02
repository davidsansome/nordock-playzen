#include "dmw_inc"
#include "dmw_proto_inc"
#include "dmw_conv_inc"
#include "dmw_test_inc"
#include "dmw_func_inc"

void dmwand_DoDialogChoice(int nChoice)
{
   string sCallFunction = GetLocalString(oMySpeaker, "dmw_function" + IntToString(nChoice));
   string sCallParams = GetLocalString(oMySpeaker, "dmw_params" + IntToString(nChoice));
   string sNav = "";

   string sStart = GetStringLeft(sCallFunction, 5);
   int nLen = GetStringLength(sCallFunction) - 5;
   string sCall = GetSubString(sCallFunction, 5, nLen);

   if(TestStringAgainstPattern("conv_", sStart))
   {
      dmwand_BuildConversation(sCall, sCallParams);
   }
   else
   {
      if(TestStringAgainstPattern("ShowAllAttribs", sCall))
      {
         dmwand_ShowAllAttribs();
         return;
      }
      if(TestStringAgainstPattern("ShowBasicAttribs", sCall))
      {
         dmwand_ShowBasicAttribs();
         return;
      }
      if(TestStringAgainstPattern("ShowInventory", sCall))
      {
         dmwand_ShowInventory();
         return;
      }
      if(TestStringAgainstPattern("PlayerListConv", sCall))
      {
         dmwand_PlayerListConv(sCallParams);
         return;
      }
      if(TestStringAgainstPattern("ShiftAlignment", sCall))
      {
         string sDir = GetStringLeft(sCallParams, 5);
         int nLen = GetStringLength(sCallParams) - 5;
         string sAmt = GetSubString(sCallParams, 5, nLen);
         dmwand_ShiftAlignment(sDir, StringToInt(sAmt));
         return;
      }
      if(TestStringAgainstPattern("MapArea", sCall))
      {
         dmwand_MapArea();
         return;
      }
      if(TestStringAgainstPattern("FollowTarget", sCall))
      {
         dmwand_FollowTarget();
         return;
      }
      if(TestStringAgainstPattern("FollowMe", sCall))
      {
         dmwand_FollowMe();
         return;
      }
      if(TestStringAgainstPattern("ResumeDefault", sCall))
      {
         dmwand_ResumeDefault();
         return;
      }
      if(TestStringAgainstPattern("Toad", sCall))
      {
         dmwand_Toad();
         return;
      }
      if(TestStringAgainstPattern("Untoad", sCall))
      {
         dmwand_Untoad();
         return;
      }
      if(TestStringAgainstPattern("KickPC", sCall))
      {
         dmwand_KickPC();
         return;
      }
      if(TestStringAgainstPattern("IdentifyItem", sCall))
      {
         dmwand_IdentifyItem();
         return;
      }
      if(TestStringAgainstPattern("DestroyItem", sCall))
      {
         dmwand_DestroyItem();
         return;
      }
      if(TestStringAgainstPattern("TakeItem", sCall))
      {
         dmwand_TakeItem();
         return;
      }
      if(TestStringAgainstPattern("KillAndReplace", sCall))
      {
         dmwand_KillAndReplace();
         return;
      }
      if(TestStringAgainstPattern("SwapDayNight", sCall))
      {
         dmwand_SwapDayNight(StringToInt(sCallParams));
         return;
      }
      if(TestStringAgainstPattern("AdvanceTime", sCall))
      {
         dmwand_AdvanceTime(StringToInt(sCallParams));
         return;
      }
      if(TestStringAgainstPattern("ReloadModule", sCall))
      {
         dmwand_ReloadModule();
         return;
      }
      if(TestStringAgainstPattern("TakeAll", sCall))
      {
         dmwand_TakeAll();
         return;
      }
      if(TestStringAgainstPattern("TakeAllEquipped", sCall))
      {
         dmwand_TakeAllEquipped();
         return;
      }
      if(TestStringAgainstPattern("TakeAllUnequipped", sCall))
      {
         dmwand_TakeAllUnequipped();
         return;
      }
      if(TestStringAgainstPattern("AbilityCheck", sCall))
      {
         int nPrivate = StringToInt(GetStringLeft(sCallParams, 1));
         int nLen = GetStringLength(sCallParams) - 1;
         int nAbility = StringToInt(GetSubString(sCallParams, 1, nLen));
         dmwand_AbilityCheck(nAbility, nPrivate);
         return;
      }
      if(TestStringAgainstPattern("SkillCheck", sCall))
      {
         int nPrivate = StringToInt(GetStringLeft(sCallParams, 1));
         int nLen = GetStringLength(sCallParams) - 1;
         int nSkill = StringToInt(GetSubString(sCallParams, 1, nLen));
         dmwand_SkillCheck(nSkill, nPrivate);
         return;
      }
      if(TestStringAgainstPattern("DestroyTarget", sCall))
      {
         dmwand_DestroyTarget();
         return;
      }
      if(TestStringAgainstPattern("DestroyNearbyTarget", sCall))
      {
         dmwand_DestroyNearbyTarget();
         return;
      }
      if(TestStringAgainstPattern("TurnTargetOn", sCall))
      {
         dmwand_TurnTargetOn();
         return;
      }
      if(TestStringAgainstPattern("TurnTargetOff", sCall))
      {
         dmwand_TurnTargetOff();
         return;
      }
      if(TestStringAgainstPattern("TurnNearOff", sCall))
      {
         dmwand_TurnNearOff();
         return;
      }
      if(TestStringAgainstPattern("TurnNearOn", sCall))
      {
         dmwand_TurnNearOn();
         return;
      }
      if(TestStringAgainstPattern("ModRep", sCall))
      {
         dmwand_ModRep(sCallParams);
         return;
      }
      if(TestStringAgainstPattern("ModOneRep", sCall))
      {
         dmwand_ModOneRep(sCallParams);
         return;
      }
      if(TestStringAgainstPattern("ExportChars", sCall))
      {
         dmwand_ExportChars();
         return;
      }
      if(TestStringAgainstPattern("JoinParty", sCall))
      {
         dmwand_JoinParty();
         return;
      }
      if(TestStringAgainstPattern("LeaveParty", sCall))
      {
         dmwand_LeaveParty();
         return;
      }
      if(TestStringAgainstPattern("JumpPlayerHere", sCall))
      {
         dmwand_JumpPlayerHere();
         return;
      }
      if(TestStringAgainstPattern("JumpToPlayer", sCall))
      {
         dmwand_JumpToPlayer();
         return;
      }
   }
}
