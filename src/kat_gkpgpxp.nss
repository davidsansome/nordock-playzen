#include "rr_persist"

void main()
{
//Give gold, xp as reward..
object oPC = GetPCSpeaker();
int goldToGive = 10000;
int xpToGive = 2500;
string itemToGive = "kat_boobyprize";

GiveGoldToCreature(oPC,goldToGive);
GiveXPToCreature(oPC,xpToGive);
CreateItemOnObject(itemToGive,oPC,1);
SPI(oPC,"kat_gatekeeper_reward",1);
}
