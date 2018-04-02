// Created by: Iznoghoud
//
// A piece of sample code to make polymorphing effects reapply after an
// exportallcharacters.


void main()
{
    ExportAllCharacters();
    // ===== This is the code you need to add =====
    object oPC = GetFirstPC();
    while ( GetIsObjectValid(oPC) ) // Loop through all the Players
    {
        if ( GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC)) )
            DelayCommand(0.1, ExecuteScript("ws_saveall_sub", oPC));
            // We HAVE to use DelayCommand here or else properties will not carry over no matter what you do.

        oPC = GetNextPC();
    } // while
}
