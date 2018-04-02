#include "rr_persist"

void main()
{
    object oPC = GetEnteringObject();

    if (!GetIsPC(oPC))
        return;
    if (GPI(oPC, "TrevorCompleted") == 1)
        return;

    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    if (!GetIsObjectValid(oDominated))
        return;

    int iTotalFreed = GetLocalInt(oPC, "TrevorFreedCount");
    if (iTotalFreed >= 6) return;

    string sTag = GetTag(oDominated);
    if ((sTag == "TrevorBadger") ||
        (sTag == "TrevorBoar") ||
        (sTag == "TrevorLion") ||
        (sTag == "TrevorDog") ||
        (sTag == "TrevorChicken") ||
        (sTag == "TrevorRaven"))
    {
        iTotalFreed++;
        SetLocalInt(oPC, "TrevorFreedCount", iTotalFreed);
        DestroyObject(oDominated);
        FloatingTextStringOnCreature("Animals set free: " + IntToString(iTotalFreed) + " of 6", oPC);
    }
}
