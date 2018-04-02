//Hardcore Dying
//Bleed's Out at -1.0hp/6 sec
//Archaegeo
//2002 June 24

// This script is used in OnPlayerDying event in Module Properties.  It
// is called if the players hit points drop to 0 to -9.  It sets the
// PlayerState as dying and puts a death amulet on a player to prevent
// them from logging out and back in to get around death effects.  (Note
// that players can get around this in Local Vault environments).

#include "hc_inc"
#include "hc_inc_on_dying"
#include "hc_inc_remeff"
#include "hc_inc_transfer"
#include "hc_text_health"

void main()
{
    preEvent();
    object oPlayer=GetLastPlayerDying();
// Sets up Heartbeat tracking if anyone enters OnPlayerDying
    int iCurrentHitPoints=GetCurrentHitPoints(oPlayer);
    int nBleed=GetLocalInt(oMod,"BLEEDSYSTEM");
    string sID=GetName(oPlayer)+GetPCPublicCDKey(oPlayer);
    if (iCurrentHitPoints==0 && nBleed)
    {
// They're just disabled
        SPS( oPlayer, PWS_PLAYER_STATE_DISABLED);
        effect eHeal = EffectHeal( abs ( iCurrentHitPoints ) + 1 );
        ApplyEffectToObject( DURATION_TYPE_INSTANT, eHeal, oPlayer);
        SendMessageToPC( oPlayer, DISABLED);
        ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectParalyze(), oPlayer, 6.0);
        ExecuteScript("hc_bleeding", oPlayer);
        postEvent();
        return;
    }
    if(nBleed)
    {
// They're dying
        if(GPS(oPlayer) != PWS_PLAYER_STATE_RECOVERY)
            SPS(oPlayer, PWS_PLAYER_STATE_DYING);
        DelayCommand(6.0,ExecuteScript("hc_bleeding", oPlayer));
    }

// If using lootable corpses, make one now and move UNEQUIPPED items to it
    if(GetLocalInt(oMod,"LOOTSYSTEM") && iCurrentHitPoints!=0)
    {
//        location lDiedHere=GetLocation(oPlayer);
//        object oDeathCorpse;
//       oDeathCorpse=GetLocalObject(oMod,"DeathCorpse"+sID);
// If no death corpse exists, make one
//        if(GetIsObjectValid(oDeathCorpse)==FALSE)
//        {
//            oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DyingCorpse", lDiedHere);
//            SetLocalObject(oMod,"DeathCorpse"+sID, oDeathCorpse);
//            SetLocalObject(oDeathCorpse,"Owner",oPlayer);
//            SetLocalString(oDeathCorpse,"Name",GetName(oPlayer));
//            SetLocalString(oDeathCorpse,"Key",GetPCPublicCDKey(oPlayer));
//        }
// Move all unequipped items to the death corpse
//        int nAmtGold=GetGold(oPlayer);
//        object oBag;
//        if(nAmtGold)
//        {
//            oBag=CreateItemOnObject("bagofgold",oDeathCorpse);
//            SetLocalInt(oBag,"AmtGold",nAmtGold);
//            AssignCommand(oDeathCorpse,TakeGoldFromCreature(nAmtGold,oPlayer,TRUE));
//        }
//        hcTransferObjects(oPlayer, oDeathCorpse);
        SetLocalInt(oMod,"LastHP"+sID,iCurrentHitPoints);
    }
    postEvent();
}


