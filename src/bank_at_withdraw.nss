// Bank Withdrawl
// Modified by Jarketh Thavin on 12-12-2002
// Banker will send you a Server Message with your balance
// instead of broadcasting it for all in the vicinity to hear
#include "bank_inc"

void main()
{
int iBalance = GetTokenInt(GetPCSpeaker(), "vault_gold");
object oPC = GetPCSpeaker();
if(iBalance == 0)
   {
    SendMessageToPC(oPC, "You do not have any gold in your account.");
    return;
   }

SendMessageToPC(oPC, "You have " + IntToString(iBalance) + " gold in your account. How much would you like to withdraw?");
SetListenPattern(OBJECT_SELF, "**", 888);
SetListening(OBJECT_SELF, TRUE);
SetLocalObject(OBJECT_SELF, "pc_obj", GetPCSpeaker());
}
