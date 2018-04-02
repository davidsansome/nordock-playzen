void main()
{
object olight = GetObjectByTag("closetlight");

if (GetLocalInt(olight,"NW_L_AMION") == 0)
    {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        DelayCommand(0.4,SetPlaceableIllumination(olight, TRUE));
        SetLocalInt(olight,"NW_L_AMION",1);
        DelayCommand(0.5,RecomputeStaticLighting(GetArea(olight)));
    }
    else
    {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        DelayCommand(0.4,SetPlaceableIllumination(olight, FALSE));
        SetLocalInt(olight,"NW_L_AMION",0);
        DelayCommand(0.4,RecomputeStaticLighting(GetArea(olight)));
    }
}
