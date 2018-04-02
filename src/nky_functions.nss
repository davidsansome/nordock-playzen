//::///////////////////////////////////////////////
//:: nky_functions
//:://////////////////////////////////////////////
/*
    Functions made by Nakey for various scripts
*/
//:://////////////////////////////////////////////
//:: Created By: Nakey
//:: Created On: 18-02-04
//:://////////////////////////////////////////////



//:://////////////////////////////////////////////
//:: Resurrects the player out of fugue without loss
//:://////////////////////////////////////////////
#include "hc_inc"
#include "hc_inc_remeff"
#include "rr_persist"

void NkyDMRes(object oPlayer)
{
    object oMod = GetModule();
    object oPlayer = GetItemActivatedTarget();
    object oActivator = GetItemActivator();
    string sSubRace = GetStringLowerCase(GetSubRace(oPlayer));
    object oFugueRobes = GetItemPossessedBy(oPlayer, "fugue_NOD");

    if(GetLocalInt(oPlayer, "GHOST") && GetIsPC(oPlayer))
    {
        // Altered by Grug 25-May-2004 to include death variable
        SPI(oPlayer, "NCP_DEAD", 0); // Set the player as alive
        SetLocalInt(oPlayer, "GHOST", 0);
        if(GetIsObjectValid(GetItemPossessedBy(oPlayer, "fugue_NOD")) && GetIsPC(oPlayer))
        {
            DestroyObject(oFugueRobes);
        }
        if(sSubRace == "drow")
        {
            SendMessageToAllDMs(GetName(oPlayer) + " [" + GetPCPlayerName(oPlayer) + "] " + "DM respawned by " + GetName(oActivator) + ". Subrace: " + sSubRace);
            DelayCommand(2.0, AssignCommand(oPlayer, JumpToLocation(GetLocation(GetObjectByTag("drowstart")))));
        }
        else if(sSubRace == "duergar")
        {
            SendMessageToAllDMs(GetName(oPlayer) + " [" + GetPCPlayerName(oPlayer) + "] " + "DM respawned by " + GetName(oActivator) + ". Subrace: " + sSubRace);
            DelayCommand(2.0, AssignCommand(oPlayer, JumpToLocation(GetLocation(GetObjectByTag("duergarspawn")))));
        }
        else
        {
            SendMessageToAllDMs(GetName(oPlayer) + " [" + GetPCPlayerName(oPlayer) + "] " + "DM respawned by " + GetName(oActivator) + ".");
            DelayCommand(2.0, AssignCommand(oPlayer, JumpToLocation(GetLocation(GetObjectByTag("playerrespawn")))));
        }
        // Copied from the True Ressurection Script 'tru_res_t11'
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);
        RemoveEffects(oPlayer);
        SPS(oPlayer,0);
        Subraces_RespawnSubrace(oPlayer);
    }
    else
    {
        SendMessageToAllDMs(GetName(oPlayer) + " [" + GetPCPlayerName(oPlayer) + "] " + "is not dead, cannot DM res.");
    }
}
// used so it gets a nice compiled successfully message ^_^
//void main()
//{
//}
