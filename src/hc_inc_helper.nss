// Main functions file for the HCR Helper
// Archaegeo 2002 June 27

#include "hc_inc"
#include "hc_text_helper"

object oMyTarget=GetLocalObject(OBJECT_SELF,"HCRHtarget");

void lock_module()
{
    SendMessageToAllDMs(SERVERLOCKED);
    SetLocalInt(oMod,"LOCKED",1);
}

void unlock_module()
{
    SendMessageToAllDMs(SERVERUNLOCKED);
    SetLocalInt(oMod,"LOCKED",0);
}

int hcrh_istargetpc()
{
   if(GetIsObjectValid(oMyTarget) && GetIsPC(oMyTarget))
   {
      return TRUE;
   }
   return FALSE;
}

int hcrh_istargetnvalid()
{
   if(!GetIsObjectValid(oMyTarget))
   {
      return TRUE;
   }
   return FALSE;
}

