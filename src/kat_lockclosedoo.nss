//Put this OnOpen
void main()
{

object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = OBJECT_SELF;

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = OBJECT_SELF;

DelayCommand(10.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));

DelayCommand(10.0, SetLocked(oTarget, TRUE));

}

