//Hardcore Respawn
//Archaegeo 2002 Jun 24

// This goes in OnPlayerRespawn in Module Properties Events
// It checks to see if the player has a god, and if so whether or
// not he feels like listening to them.  As is now, they can pray
// as often as they want, with a 3% chance. (May set time limit or
// bad effect for annoying your God later). To go to normal respawn
// just comment out the section as noted below.

#include "hc_inc"
#include "hc_inc_remeff"
#include "hc_inc_on_respwn"
#include "nw_i0_tool"

void main()
{
    if(!preEvent()) return;
    object oRespawner = GetLastRespawnButtonPresser();
    string sID=GetName(oRespawner)+GetPCPublicCDKey(oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
    RemoveEffects(oRespawner);

    if (GetLocalInt(oRespawner,"arena"))
    {
        AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("arena_respawn"))));
        return;
    }

    if(GetLocalInt(oMod,"LIMBO"))
    {
             string sRace=GetStringLowerCase(GetSubRace(oRespawner));

            if (HasItem(oRespawner,"BlackHillsStone"))
                {

                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("blackhillsspawn"))));
                }
            else
            if (HasItem(oRespawner,"brosnastone"))
                {

                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("brostempspawn"))));
                }
            else
            if (HasItem(oRespawner,"llothstone"))
                {

                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("llothspawn"))));
                }
            else
            if (HasItem(oRespawner,"loknarstone"))
                {

                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("port_loknar"))));
                }
            else
            if (HasItem(oRespawner,"tobarostone"))
                {
                AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("TobaTempSpawn"))));
                }
            else
            if (HasItem(oRespawner,"sholokeepstone"))
                {
                AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("SholoKeepSpawn"))));
                }
            else
                if (HasItem(oRespawner,"mcustone"))
                    {
                    ExploreAreaForPlayer(GetObjectByTag("taip_mcu_stonespawn"),oRespawner);
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("taip_mcu_stonespawn"))));
                    }
            else
            if (sRace == "drow")
                {
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("drowstart"))));
                }
            else
            if (sRace == "duergar")
                {
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("duergarspawn"))));
                }
            else
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("playerrespawn"))));
    }
// Clean up their player corpse token if one exists
    if(GetLocalInt(oMod,"LOOTSYSTEM"))
    {
        object oPCT=GetLocalObject(oMod,"PlayerCorpse"+sID);
        if(GetIsObjectValid(oPCT)) DestroyObject(oPCT,3.0);
    }

// At this point they are respawned where they stand.  If you want to move them
// to safety, you should do so here.
    // SEI_NOTE: Re-init the subrace traits
    Subraces_RespawnSubrace( oRespawner );


// penalty

    int nXP = GetXP ( oRespawner );
    int nHD = GetHitDice ( oRespawner );
    int nNewXP = nXP - (nHD * nHD * 100);
    if (nHD>1)
        if (nNewXP < (((nHD * (nHD-1))/2)*1000))
            nNewXP = (((nHD * (nHD-1))/2)*1000);
    if (nNewXP<1)
        nNewXP=1;
    SetXP( oRespawner, nNewXP);
    TakeGoldFromCreature((GetGold(oRespawner)/5),oRespawner,TRUE);


    postEvent();

// one last thing, SAVE the character
ExportSingleCharacter(oRespawner);

}
