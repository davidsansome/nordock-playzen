#include "hc_text_health"
void hcRezPenalty(object oRespawner)
{
//    int nClass2=GetClassByPosition(2, oRespawner);
//    int nClass3=GetClassByPosition(3, oRespawner);
//    if (
//        (nClass2 != CLASS_TYPE_INVALID && GetLevelByPosition(2, oRespawner)==1) ||
//        (nClass3 != CLASS_TYPE_INVALID && GetLevelByPosition(3, oRespawner)==1) ||
//        ((nClass2 != CLASS_TYPE_INVALID || nClass3 != CLASS_TYPE_INVALID)&&
//          GetLevelByPosition(1, oRespawner)==1))
//        {
//            SendMessageToPC(oRespawner, MEMLOSS);
//            string sID=GetName(oRespawner)+GetPCPublicCDKey(oRespawner);
//            SetLocalInt(GetModule(),"REZPEN"+sID,GetLocalInt(GetModule(),
//                "REZPEN"+sID)+500);
//            return;
//        }
        int nHD = GetHitDice ( oRespawner );
        int nNewXP = ((( nHD * ( nHD - 1)) / 2) * 1000)-(((  nHD-1 ) * 1000 ) / 2 );
        if ( nHD == 1 )
        {
            effect eRessickness = EffectAbilityDecrease (  ABILITY_CONSTITUTION, 1);
            ApplyEffectToObject( DURATION_TYPE_PERMANENT,  eRessickness, oRespawner );
        }
        else
        {
            SetXP( oRespawner, nNewXP);
        }
//        if(GetLocalInt(GetModule(),"PWEXP"))
//        {
//            SetUpExp(oRespawner, 0);
//        }
}
