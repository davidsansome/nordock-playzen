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
//    if(!preEvent()) return;
    object oRespawner = GetPCSpeaker();

    string sID=GetName(oRespawner)+GetPCPublicCDKey(oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
    RemoveEffects(oRespawner);

    SPS(oRespawner,0);

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
                    PrintString(GetPCPlayerName(oRespawner)+ " respawns. (blackhills)");
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("blackhillsspawn"))));
                }
            else
            if (HasItem(oRespawner,"brosnastone"))
                {
                    PrintString(GetPCPlayerName(oRespawner)+ " respawns. (brosna)");
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("brostempspawn"))));
                }
            else
            if (HasItem(oRespawner,"llothstone"))
                {
                PrintString(GetPCPlayerName(oRespawner)+ " respawns. (lloth)");
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("llothspawn"))));
                }
            else
            if (HasItem(oRespawner,"loknarstone"))
                {
                PrintString(GetPCPlayerName(oRespawner)+ " respawns. (loknar)");
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("port_loknar"))));
                }
            else
                if (HasItem(oRespawner,"mcustone"))
                    {
                    ExploreAreaForPlayer(GetObjectByTag("taip_mcu_stonespawn"),oRespawner);
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("taip_mcu_stonespawn"))));
                    }
            else
               if (HasItem(oRespawner,"tobarostone"))
                  {
                  ExploreAreaForPlayer(GetObjectByTag("TobaroTempleofLife"),oRespawner);
                  AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("TobaTempSpawn"))));
                  }
            else
                if (HasItem(oRespawner,"sholokeepstone"))
                {
                ExploreAreaForPlayer(GetObjectByTag("knightsofthem001"),oRespawner);
                AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("SholoKeepSpawn"))));
                }
            else
            if (sRace == "drow")
                {
                PrintString(GetPCPlayerName(oRespawner)+ " respawns. (drow)");
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("drowstart"))));
                }
            else
            if (sRace == "duergar")
                {
                PrintString(GetPCPlayerName(oRespawner)+ " respawns. (duergar)");
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("duergarspawn"))));
                }
            else
                {
                PrintString(GetPCPlayerName(oRespawner)+ " respawns. (temple of life)");
                    AssignCommand(oRespawner, JumpToLocation(GetLocation(GetObjectByTag ("playerrespawn"))));
                }
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
    int nNewXP;

    if (GetLocalInt(oMod,"PNPDEATH"))
    {
    if (nHD>1)
    {
        nNewXP = ((( nHD * ( nHD - 1)) / 2) * 1000)-(((  nHD-1 ) * 1000 ) / 2 );
//Grug 08/10/2003
//        SetLocalInt(oRespawner,"dropped_level",TRUE);
//        SendMessageToPC(oRespawner,"You have lost a level. You will need to log off and come back to earn XP again.");
        SetXP( oRespawner, nNewXP);
    }
    }
    else
    {
        nNewXP=FloatToInt(nXP*0.9);
//Grug 08/10/2003
//        if (nNewXP<(( nHD * ( nHD - 1)) / 2) * 1000)
//        {
//            SetLocalInt(oRespawner,"dropped_level",TRUE);
//            SendMessageToPC(oRespawner,"You have lost a level. You will need to log off and come back to earn XP again.");
//        }
        SetXP( oRespawner, nNewXP);
    }
//    TakeGoldFromCreature((GetGold(oRespawner)/5),oRespawner,TRUE);
    PrintString(GetPCPlayerName(oRespawner)+ " smacked with respawn penalty");
    if (GetLocalInt(oMod,"USESOULFRAG"))
    {
        if (!HasItem(oRespawner,"SoulFrag_NOD"))
           CreateItemOnObject("soulfrag_nod",oRespawner,1);
        SetLocalInt(oRespawner,"SOULFRAG"+sID,TRUE);
    }
    postEvent();
}
