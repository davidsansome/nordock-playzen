//::///////////////////////////////////////////////
//:: Summon Creature Series
//:: NW_S0_Summon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Carries out the summoning of the appropriate
    creature for the Summon Monster Series of spells
    1 to 9
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////

#include "hc_inc_summon"
#include "wm_include"
#include "nx_sf_include"

effect SetSummonEffect(int nSpellID);
void main()
{
    if(SpellSuccess())
    {
        if (WildMagicOverride()) { return; }
        //Declare major variables
        int nSpellID = GetSpellId();
        int nDuration = GetCasterLevel(OBJECT_SELF);
        nDuration = 24;
        if(nDuration == 1)
        {
            nDuration = 2;
        }
        if(GetLocalInt(GetModule(),"SUMMONTIME")) nDuration = (GetCasterLevel(OBJECT_SELF)*GetLocalInt(GetModule(),"SUMMONTIME"))+2;
        effect eSummon = SetSummonEffect(nSpellID);
        //Make metamagic check for extend
        int nMetaMagic = GetMetaMagicFeat();
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2;   //Duration is +100%
        }
        //Apply the VFX impact and summon effect
        if(GetLocalInt(GetModule(),"SUMMONTIME"))
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
        else
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    }
}

effect SetSummonEffect(int nSpellID)
{
    int nFNF_Effect;
    int nRoll = d3();
    string sSummon;
    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER)) //WITH THE ANIMAL DOMAIN
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon=pick_creature(2);
            if(sSummon=="") sSummon = "NW_S_BOARDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon=pick_creature(3);
            if(sSummon=="") sSummon = "NW_S_WOLFDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon=pick_creature(4);
            if(sSummon=="") sSummon = "NW_S_SPIDDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon=pick_creature(5);
            if(sSummon=="") sSummon = "NW_S_beardire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon=pick_creature(6);
            if(sSummon=="") sSummon = "NW_S_diretiger";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon=pick_creature(7);
          if(sSummon=="")
          {
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRHUGE";
                break;
                case 2:
                    sSummon = "NW_S_WATERHUGE";
                break;
                case 3:
                    sSummon = "NW_S_FIREHUGE";
                break;
            }
          }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon=pick_creature(8);
          if(sSummon=="")
          {
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRGREAT";
                break;
                case 2:
                    sSummon = "NW_S_WATERGREAT";
                break;
                case 3:
                    sSummon = "NW_S_FIREGREAT";
                break;
            }
          }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon=pick_creature(9);
          if(sSummon=="")
          {
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;
                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;
                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
            }
          }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon=pick_creature(9);
          if(sSummon=="")
          {
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;
                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;
                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
            }
          }
        }
    }
    else  //WITHOUT THE ANIMAL DOMAIN
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon=pick_creature(1);
            if(sSummon=="") sSummon = "NW_S_badgerdire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon=pick_creature(2);
            if(sSummon=="") sSummon = "NW_S_BOARDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon=pick_creature(3);
            if(sSummon=="") sSummon = "NW_S_WOLFDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon=pick_creature(4);
            if(sSummon=="") sSummon = "NW_S_SPIDDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon=pick_creature(5);
            if(sSummon=="") sSummon = "NW_S_beardire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon=pick_creature(6);
            if(sSummon=="") sSummon = "NW_S_diretiger";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon=pick_creature(7);
          if(sSummon=="")
          {
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRHUGE";
                break;
                case 2:
                    sSummon = "NW_S_WATERHUGE";
                break;
                case 3:
                    sSummon = "NW_S_FIREHUGE";
                break;
            }
          }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon=pick_creature(8);
          if(sSummon=="")
          {
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRGREAT";
                break;
                case 2:
                    sSummon = "NW_S_WATERGREAT";
                break;
                case 3:
                    sSummon = "NW_S_FIREGREAT";
                break;
            }
          }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon=pick_creature(9);
          if(sSummon=="")
          {
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;
                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;
                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
            }
          }
        }
    }
    //effect eVis = EffectVisualEffect(nFNF_Effect);
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
    return eSummonedMonster;
}

