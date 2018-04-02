#include "hc_text_activate"
void main()
{
    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");
        if(oOther==OBJECT_INVALID) return;
        if(GetRacialType(oOther) != RACIAL_TYPE_ANIMAL)
        {
            SendMessageToPC(oUser,ANIMALONLY);
            return;
        }
        if(GetCurrentHitPoints(oOther) > 0)
        {
            SendMessageToPC(oUser,NOTDEAD);
            return;
        }
        if(GetDistanceBetween(oUser, oOther) > 3.0)
        {
            SendMessageToPC(oUser,MOVECLOSER);
             return;
        }
        AssignCommand(oUser,ActionMoveToLocation(GetLocation(oOther)));
        DelayCommand(1.0,AssignCommand(oUser,ActionPlayAnimation(
            ANIMATION_LOOPING_GET_LOW)));
        DelayCommand(1.3,AssignCommand(oOther,SetIsDestroyable(TRUE)));
        CreateObject(OBJECT_TYPE_ITEM,"it_mmidmisc006",GetLocation(oOther),TRUE);

}
