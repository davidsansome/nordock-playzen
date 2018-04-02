#include "NW_i0_GENERIC"
void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetFirstFactionMember(oPC,TRUE);

while (GetIsObjectValid(oTarget))
{
    SetIsTemporaryEnemy(oTarget, OBJECT_SELF, TRUE, 100.0);
    oTarget = GetNextFactionMember(oPC, TRUE);
}
DelayCommand(2.0, AssignCommand(OBJECT_SELF, ActionAttack(oPC)));

DelayCommand(2.0, AssignCommand(OBJECT_SELF, DetermineCombatRound(oPC)));

}
