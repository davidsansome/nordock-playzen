void Sleep(object oPC);

object oBed = OBJECT_SELF;

void main()
{
    object oPC = GetLastUsedBy();
    object oSleeper= GetLocalObject(oBed,"Sleeper");

    if(oSleeper != OBJECT_INVALID)
        Sleep(oPC);

    else if(GetArea(oPC) == GetArea(oBed))
    {
        AssignCommand(oPC,ClearAllActions());
        Sleep(oPC);
    }

    return;
}

void Sleep(object oPC)
{
    SetLocalObject(oBed,"Sleeper",oPC);
    AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,0.1,10.0));
    AssignCommand(oPC,SetFacing(GetFacing(oBed)));
    int iHeal = GetMaxHitPoints(oPC)-GetCurrentHitPoints(oPC);
    if (iHeal>0)
       {
       effect eHeal = EffectHeal(iHeal);
       ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oPC);
       }
}


