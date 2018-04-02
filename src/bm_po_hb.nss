#include "bm_po_inc"

void main()
{
//Cycle through all the players to see if they have a scroll waiting to be created.
    if(POTIONWAITTIME) //Only bother if scrollwait time is more than 0
    {
        object oPlayer = GetFirstPC();
        object oMod = GetModule();
        while (oPlayer != OBJECT_INVALID)
        {
            string sPCName=GetName(oPlayer);
            string sCDK=GetPCPublicCDKey(oPlayer);
            if(GetLocalInt(oMod, "PotionCreated"+sPCName+sCDK))
            //player has a scroll waiting.
            {
                if ( GetIsInCombat(oPlayer) )
                {
                   SetLocalInt(oMod, "PotionCreated"+sPCName+sCDK, 0);
                   SetLocalInt(oMod, "nPotionCreatedHour"+sPCName+sCDK, 0);
                   SetLocalInt(oMod, "nPotionCreatedDay"+sPCName+sCDK, 0);
                   SetLocalInt(oMod, "nPotionCreatedMonth"+sPCName+sCDK, 0);
                   SetLocalInt(oMod, "nPotionCreatedYear"+sPCName+sCDK, 0);
                   SetLocalInt(oMod, "nPotionCreationTime"+sPCName+sCDK, 0);
                   SetLocalString(oMod, "sCreatedPotion"+sPCName+sCDK, "");
                   SendMessageToPC(oPlayer, "Entering combat interrupts your attempt at making a potion");
                }
                else
                {

                    int nCreatedHour = GetLocalInt(oMod, "nPotionCreatedHour"+sPCName+sCDK);
                    int nCreatedDay = GetLocalInt(oMod, "nPotionCreatedDay"+sPCName+sCDK);
                    int nCreatedMonth = GetLocalInt(oMod, "nPotionCreatedMonth"+sPCName+sCDK);
                    int nCreatedYear = GetLocalInt(oMod, "nPotionCreatedYear"+sPCName+sCDK);

                    int nScrollCreationTime = GetLocalInt(oMod, "nPotionCreationTime"+sPCName+sCDK);
                    int nCurrentHour = GetTimeHour();
                    int nCurrentDay = GetCalendarDay();
                    int nCurrentMonth = GetCalendarMonth();
                    int nCurrentYear = GetCalendarYear();

                    int iHowLong;
                    int nCanCreate = 1;

                    iHowLong = nCurrentHour - nCreatedHour;
                    iHowLong = iHowLong + ((nCurrentDay - nCreatedDay) * 24);
                    iHowLong = iHowLong + ((nCurrentMonth - nCreatedMonth) * 24 * 28);
                    iHowLong = iHowLong + ((nCurrentYear - nCreatedYear) * 24 * 28 * 12);

                    if (iHowLong >= nScrollCreationTime) //Time to check to see if PC can still make scroll
                    {

                       if (nCanCreate)
                       {
                           string sScroll = GetLocalString(oMod, "sCreatedPotion"+sPCName+sCDK);
                           CreateItemOnObject(sScroll, oPlayer);
                       }
                       SetLocalInt(oMod, "PotionCreated"+sPCName+sCDK, 0);
                       SetLocalInt(oMod, "nPotionCreatedHour"+sPCName+sCDK, 0);
                       SetLocalInt(oMod, "nPotionCreatedDay"+sPCName+sCDK, 0);
                       SetLocalInt(oMod, "nPotionCreatedMonth"+sPCName+sCDK, 0);
                       SetLocalInt(oMod, "nPotionCreatedYear"+sPCName+sCDK, 0);
                       SetLocalInt(oMod, "nPotionCreationTime"+sPCName+sCDK, 0);
                       SetLocalString(oMod, "sCreatedPotion"+sPCName+sCDK, "");
                    }
                }
            }
            oPlayer = GetNextPC();
        }
    }
}
