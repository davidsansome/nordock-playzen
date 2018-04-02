#include "rr_persist"

void main()
{
object oPC = GetPCSpeaker();
CreateItemOnObject("mcuaccesskey", oPC);
TakeGoldFromCreature(500000, oPC);
SPI(oPC, "mcu_rego", 1);
}
