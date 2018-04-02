//General Treasure Re-Spawn Script

//Change the Low in "GenerateLowTreasure" with Medium or High for better quality treasure.

#include "NW_O2_CONINCLUDE"

void main()

{

    if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)

    {

       return;

    }

    object oLastOpener = GetLastOpener();

    GenerateLowTreasure(oLastOpener, OBJECT_SELF);

    ActionDoCommand(SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1));

    ActionWait(60.0);

    ActionDoCommand(SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",0));

    ShoutDisturbed();

}

