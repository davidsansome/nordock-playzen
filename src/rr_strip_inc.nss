void DecrementTalentIndex(int iIndex, object oPC)

{
    int iDecrementIndex;

    talent tSpell;
    talent tFeat;

/* create our talent */
    tSpell = TalentSpell(iIndex);
    tFeat = TalentFeat(iIndex);

/* check for all spells */
    if (GetIsTalentValid(tSpell))
    {
        if (GetHasSpell(GetIdFromTalent(tSpell), oPC))
        {
            for (iDecrementIndex = 1; iDecrementIndex < 20; iDecrementIndex++)
            {
                DecrementRemainingSpellUses(oPC, GetIdFromTalent(tSpell));
            }
        }
    }

/* check for all feats*/
//    if (GetIsTalentValid(tFeat))
//    {
//        if (GetHasFeat(GetIdFromTalent(tFeat), oPC))
//        {
//            for (iDecrementIndex = 1; iDecrementIndex < 20; iDecrementIndex++)
//            {
//                DecrementRemainingFeatUses(oPC, GetIdFromTalent(tFeat));
//            }
//        }
//    }
}

void strip_spells(object oPC)
{

    int iIndex;

    for (iIndex = 1; iIndex < 1000; iIndex++)
    {
        DecrementTalentIndex(iIndex, oPC);
    }

}


