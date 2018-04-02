#include "nw_i0_tool"

void main()
{
    object oTarget=GetPCSpeaker();
    string sRace=GetStringLowerCase(GetSubRace(oTarget));
    if (HasItem(oTarget,"BlackHillsStone"))
    {
        ExploreAreaForPlayer(GetObjectByTag("BlackHills"),oTarget);
        AssignCommand(oTarget, JumpToLocation(GetLocation(GetObjectByTag ("blackhillsspawn"))));
    }
    else
    if (HasItem(oTarget,"brosnastone"))
    {
        ExploreAreaForPlayer(GetObjectByTag("BrosnaTempleofLife"),oTarget);
        AssignCommand(oTarget, JumpToLocation(GetLocation(GetObjectByTag ("brosnatempspawn"))));
    }
    else
    if (HasItem(oTarget,"llothstone"))
    {
        ExploreAreaForPlayer(GetObjectByTag("TempleOfLloth"),oTarget);
        AssignCommand(oTarget, JumpToLocation(GetLocation(GetObjectByTag ("llothspawn"))));
    }
    else
    if (HasItem(oTarget,"loknarstone"))
    {
        ExploreAreaForPlayer(GetObjectByTag("Loknar"),oTarget);
        AssignCommand(oTarget, JumpToLocation(GetLocation(GetObjectByTag ("port_loknar"))));
    }
    else
    if (HasItem(oTarget,"tylnstone"))
    {
        ExploreAreaForPlayer(GetObjectByTag("TylnCastleWibblesfordWing"),oTarget);
        AssignCommand(oTarget, JumpToLocation(GetLocation(GetObjectByTag ("WibblesfordSpawnPoint"))));
    }
    if (HasItem(oTarget,"mcustone"))
        {
        ExploreAreaForPlayer(GetObjectByTag("taip_mcu_stonespawn"),oTarget);
        AssignCommand(oTarget, JumpToLocation(GetLocation(GetObjectByTag ("taip_mcu_stonespawn"))));
        }
    else
    if (HasItem(oTarget,"tobarostone"))
        {
        ExploreAreaForPlayer(GetObjectByTag("TobaroTempleofLife"),oTarget);
        AssignCommand(oTarget, JumpToLocation(GetLocation(GetObjectByTag ("TobaTempSpawn"))));
        }
    else
    if (HasItem(oTarget,"sholokeepstone"))
        {
        ExploreAreaForPlayer(GetObjectByTag("knightsofthem001"),oTarget);
        AssignCommand(oTarget, JumpToLocation(GetLocation(GetObjectByTag ("SholoKeepSpawn"))));
        }
    else
    if (sRace == "drow")
    {
        ExploreAreaForPlayer(GetObjectByTag("UnderdarkCentral"),oTarget);
        AssignCommand(oTarget, JumpToLocation(GetLocation(GetObjectByTag ("drowstart"))));
    }
    else
    if (sRace == "duergar")
    {
        ExploreAreaForPlayer(GetObjectByTag("LaduguerHalls"),oTarget);
        AssignCommand(oTarget, JumpToLocation(GetLocation(GetObjectByTag ("duergarstart"))));
    }
    else
    {
        ExploreAreaForPlayer(GetObjectByTag("Benzor"),oTarget);
        AssignCommand(oTarget,JumpToLocation(GetLocation(GetObjectByTag ("benzorstart"))));
    }
}
