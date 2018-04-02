//------------------------------------------------------------------------------
//
// nky_codsrconspwn.ncs
//
// Used for my (Nakey's) Damned Sorcerers in the Cavern of the Damned to give
// them a permanent damage shield effect that does 10 + 1d10 magical damage each
// time someone hits them.
//
//------------------------------------------------------------------------------
//
// Created By: Nakey
// Created On: 22-12-2003
//
//------------------------------------------------------------------------------
//
// Known bugs/issues...
// - None
//
//------------------------------------------------------------------------------
//
// Changelog...
// Version: 000 (22-12-2003)
// - None
//
//------------------------------------------------------------------------------

void main()
{
    if (!((GetClassByPosition(1,OBJECT_SELF)==CLASS_TYPE_ANIMAL)||(GetClassByPosition(1,OBJECT_SELF)==CLASS_TYPE_VERMIN)))
    {
         SetLocalInt(OBJECT_SELF, "noloot", TRUE);
    }
ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamageShield(DAMAGE_BONUS_10, d10(1), DAMAGE_TYPE_MAGICAL), OBJECT_SELF);
}

//------------------------------------------------------------------------------
