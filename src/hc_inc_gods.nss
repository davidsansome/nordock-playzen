//hc_gods_inc
//Archaegeo

#include "hc_inc"
#include "hc_inc_remeff"
#include "hc_text_gods"

int ress_check(object oPlayer)
{
    if(GetLocalInt(oMod,"GODSYSTEM"))
    {
        int nrezpercent=GetLocalInt(oMod,"REZCHANCE")+(GetHitDice(oPlayer)/4);
        if(GetLocalInt(oPlayer,"LOGINDEATH"))
        {
            DeleteLocalInt(oPlayer,"LOGINDEATH");
            return 0;
        }
        if(GetDeity(oPlayer)=="")
        {
            SendMessageToPC(oPlayer, NOGOD);
            return 0;
        }
        else if(Random(100) < (100-nrezpercent))
        {
            if(GetDeity(oPlayer)!="")
                SendMessageToPC(oPlayer,GODREFUSED);
            return 0;
// If someone dies, move them to limbo and paralyze them there.
        }
        SendMessageToPC(oPlayer,GODLISTENED);
// Their god was listening!!
        if(GetLocalInt(oMod,"BLEEDSYSTEM"))
           SPS(oPlayer, PWS_PLAYER_STATE_ALIVE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);
        if(GetLocalInt(oMod,"LIMBO"))
        {
            AssignCommand(oPlayer, DelayCommand(0.2, JumpToLocation(
                      GetPersistentLocation(oMod,"DIED_HERE"+GetName(oPlayer)+GetPCPublicCDKey(oPlayer)))));
        }
    // Clean up their player corpse token if one exists
        if(!GetLocalInt(oMod,"LOOTSYSTEM"))
        {
            object oPCT=GetLocalObject(oMod,"PlayerCorpse"+GetName(oPlayer)+GetPCPublicCDKey(oPlayer));
            if(GetIsObjectValid(oPCT)) DestroyObject(oPCT,3.0);
        }
    // At this point they are respawned where they stand.  If you want to move them
    // to safety, you should do so here.
        RemoveEffects(oPlayer);
        return 1;
    }
    return 0;
}
