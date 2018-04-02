void main()
{
    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");
    string sItemTag=GetLocalString(oUser,"TAG");
    DeleteLocalString(oUser,"TAG");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");
        int nToHeal;
        effect eHeal;
        effect eVis = EffectVisualEffect(VFX_IMP_HEALING_S);
        string sType=GetSubString(sItemTag,8,3);
        AssignCommand(oUser,ActionMoveToLocation(GetLocation(oOther)));
        DelayCommand(1.0,AssignCommand(oUser,ActionPlayAnimation(
            ANIMATION_LOOPING_GET_LOW)));
        if(sType=="CLW") nToHeal=d8(1)+1;
        if(sType=="CMW") nToHeal=d8(2)+3;
        if(sType=="CSW") nToHeal=d8(3)+5;
        if(sType=="CCW") nToHeal=d8(4)+7;
        //Fire cast spell at event for the specified target
        SignalEvent(oOther, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_LIGHT_WOUNDS, FALSE));
        //Apply VFX impact and heal effect
        eHeal = EffectHeal(nToHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oOther);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oOther);
        DestroyObject(oItem);
}
