//::///////////////////////////////////////////////
//:: Pack Ox: On User Defined
//:: pack_ox_userdef
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*

Determines actions based on the PACK_MODE local int.

0: Nothing. Ox has yet to recieve a command.
1: Follow owner (if any)
2: Stay put
3: Abandoned, so wander
4: Nothing. Messing with pack. Could just as well be 0.

If the pack animal ever becomes charmed, the charmer
becomes the animal's new owner and the effect is removed (redundant).
Also clears the charmer's personal reputation with the animal.
Tried it with EFFECT_DOMINATE, but dominated creatures don't seem to
run their normal AI. So, it didn't work.

*/
//:://////////////////////////////////////////////
//:: Created By: lex42@mac.com
//:: Created On: July 6, 2002
//:://////////////////////////////////////////////
void main()
{
    if (GetUserDefinedEventNumber() == 1001) {
        effect eEffect = GetFirstEffect(OBJECT_SELF);
        while (GetIsEffectValid(eEffect)) {
            if (GetEffectType(eEffect) == EFFECT_TYPE_CHARMED) {
                object oCharmer = GetEffectCreator(eEffect);
                if (GetIsObjectValid(oCharmer)) {
                    SetLocalObject(OBJECT_SELF, "PACK_OWNER", oCharmer);
                    RemoveEffect(OBJECT_SELF, eEffect);
                    ClearPersonalReputation(oCharmer);
                }
            }
            eEffect = GetNextEffect(OBJECT_SELF);
        }

        switch(GetLocalInt(OBJECT_SELF, "PACK_MODE")) {
            case 1: ActionForceFollowObject(GetLocalObject(OBJECT_SELF, "PACK_OWNER"), 3.0); break;
            case 2: ClearAllActions(); break;
            case 3: ActionRandomWalk(); break;
        }
    }

}
